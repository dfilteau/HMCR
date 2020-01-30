﻿using Hmcr.Data.Database;
using Hmcr.Data.Database.Entities;
using Hmcr.Data.Repositories;
using Hmcr.Domain.Services;
using Hmcr.Model;
using Hmcr.Model.Dtos;
using Hmcr.Model.Dtos.FeedbackMessage;
using Hmcr.Model.Dtos.SubmissionObject;
using Hmcr.Model.Utils;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Hmcr.Domain.Hangfire.Base
{
    public class ReportJobServiceBase
    {
        protected IUnitOfWork _unitOfWork;
        protected ISubmissionStatusRepository _statusRepo;
        protected ISubmissionObjectRepository _submissionRepo;
        protected ISumbissionRowRepository _submissionRowRepo;
        private IEmailService _emailService;
        protected ILogger _logger;
        private IConfiguration _config;
        private EmailBody _emailBody;
        private IFeebackMessageRepository _feedbackRepo;
        protected decimal _duplicateRowStatusId;
        protected decimal _errorRowStatusId;
        protected decimal _successRowStatusId;
        protected decimal _errorFileStatusId;
        protected decimal _successFileStatusId;
        protected decimal _inProgressRowStatusId;

        protected HmrSubmissionObject _submission;

        public ReportJobServiceBase(IUnitOfWork unitOfWork,
            ISubmissionStatusRepository statusRepo, ISubmissionObjectRepository submissionRepo,
            ISumbissionRowRepository submissionRowRepo, IEmailService emailService, ILogger logger, IConfiguration config,
            EmailBody emailBody, IFeebackMessageRepository feedbackRepo)
        {
            _unitOfWork = unitOfWork;
            _statusRepo = statusRepo;
            _submissionRepo = submissionRepo;
            _submissionRowRepo = submissionRowRepo;
            _emailService = emailService;
            _logger = logger;
            _config = config;
            _emailBody = emailBody;
            _feedbackRepo = feedbackRepo;
        }

        protected async Task SetStatusesAsync()
        {
            var statuses = await _statusRepo.GetActiveStatuses();

            _duplicateRowStatusId = statuses.First(x => x.StatusType == StatusType.Row && x.StatusCode == RowStatus.DuplicateRow).StatusId;
            _errorRowStatusId = statuses.First(x => x.StatusType == StatusType.Row && x.StatusCode == RowStatus.RowError).StatusId;
            _successRowStatusId = statuses.First(x => x.StatusType == StatusType.Row && x.StatusCode == RowStatus.Success).StatusId;

            _errorFileStatusId = statuses.First(x => x.StatusType == StatusType.File && x.StatusCode == FileStatus.DataError).StatusId;
            _successFileStatusId = statuses.First(x => x.StatusType == StatusType.File && x.StatusCode == FileStatus.Success).StatusId;

            _inProgressRowStatusId = statuses.First(x => x.StatusType == StatusType.File && x.StatusCode == FileStatus.InProgress).StatusId;
        }

        protected async Task SetSubmissionAsync(SubmissionDto submissionDto)
        {
            _logger.LogInformation("[Hangfire] Starting submission {submissionObjectId}", (long)submissionDto.SubmissionObjectId);

            _submission = await _submissionRepo.GetSubmissionObjecForBackgroundJobAsync(submissionDto.SubmissionObjectId);
            _submission.SubmissionStatusId = _inProgressRowStatusId;
            _unitOfWork.Commit();
        }

        protected bool CheckCommonMandatoryHeaders<T1, T2>(List<T1> rows, T2 headers, Dictionary<string, List<string>> errors) where T2 : IReportHeaders
        {
            if (rows.Count == 0) //not possible since it's already validated in the ReportServiceBase.
                throw new Exception("File has no rows.");

            var row = rows[0];

            var fields = typeof(T1).GetProperties();

            foreach (var field in fields)
            {
                if (!headers.CommonMandatoryFields.Any(x => x == field.Name))
                    continue;

                if (field.GetValue(row) == null)
                {
                    errors.AddItem("File", $"Header [{field.Name.WordToWords()}] is missing");
                }
            }

            return errors.Count == 0;
        }

        protected async Task<string> SetRowIdAndRemoveDuplicate<T>(List<T> untypedRows, string headers) where T : IReportCsvDto
        {
            headers = $"{Fields.RowNum}," + headers;
            var text = new StringBuilder();
            text.AppendLine(headers);

            for (int i = untypedRows.Count - 1; i >= 0; i--)
            {
                var untypedRow = untypedRows[i];
                var entity = await _submissionRowRepo.GetSubmissionRowByRowNum(_submission.SubmissionObjectId, (decimal)untypedRow.RowNum);

                if (entity.RowStatusId == _duplicateRowStatusId)
                {
                    untypedRows.RemoveAt(i);
                    continue;
                }

                text.AppendLine($"{untypedRow.RowNum},{entity.RowValue}");
                untypedRow.RowId = entity.RowId;
            }

            return text.ToString();
        }

        protected void SetErrorDetail(HmrSubmissionRow submissionRow, Dictionary<string, List<string>> errors)
        {
            submissionRow.RowStatusId = _errorRowStatusId;
            submissionRow.ErrorDetail = errors.GetErrorDetail();
            _submission.ErrorDetail = FileError.ReferToRowErrors;
            _submission.SubmissionStatusId = _errorFileStatusId;
        }
        protected string GetHeader(string text)
        {
            if (text == null)
                return "";

            using var reader = new StringReader(text);
            var header = reader.ReadLine().Replace("\"", "");

            return header ?? "";
        }

        protected async Task CommitAndSendEmail()
        {
            await _unitOfWork.CommitAsync();

            var submissionId = (long)_submission.SubmissionObjectId;
            var resultUrl = string.Format(_config.GetValue<string>("SUBMISSION_RESULT"), (int)_submission.ServiceAreaNumber, submissionId);

            var env = _config.GetEnvironment();
            var environment = env == HmcrEnvironments.Prod ? "" : $"[{env}]";

            var subject = $"HMCR {environment} report submission({submissionId}) result";
            var htmlBody = string.Format(_emailBody.HtmlBody, submissionId, resultUrl);
            var textBody = string.Format(_emailBody.TextBody, submissionId, resultUrl);

            var isSent = true;
            var isError = false;
            var errorText = "";

            try
            {
                _emailService.SendEmailToUsersInServiceArea(_submission.ServiceAreaNumber, subject, htmlBody, textBody);
            }
            catch (Exception ex)
            {
                isSent = false;
                isError = true;
                errorText = ex.Message;

                _logger.LogError(ex.ToString());
            }

            var feedback = new FeedbackMessageDto
            {
                SubmissionObjectId = _submission.SubmissionObjectId,
                CommunicationSubject = subject,
                CommunicationText = htmlBody,
                CommunicationDate = DateTime.UtcNow,
                IsSent = isSent ? "Y" : "N",
                IsError = isError ? "Y" : "N",
                SendErrorText = errorText
            };

            await _feedbackRepo.CreateFeedbackMessage(feedback);
            await _unitOfWork.CommitAsync();

            _logger.LogInformation("[Hangfire] Finishing submission {submissionObjectId}", submissionId);
        }
    }
}