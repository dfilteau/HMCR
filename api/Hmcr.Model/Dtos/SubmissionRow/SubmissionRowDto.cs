﻿using System;
using System.Collections.Generic;
using System.Text;

namespace Hmcr.Model.Dtos.SubmissionRow
{
    public class SubmissionRowDto
    {
        public decimal RowId { get; set; }
        public decimal SubmissionObjectId { get; set; }
        public decimal? RowStatusId { get; set; }
        public string RecordNumber { get; set; }
        public string RowValue { get; set; }
        public string RowHash { get; set; }
        public string ErrorDetail { get; set; }
        public string WarningDetail { get; set; }
        public decimal? RowNum { get; set; }
        public bool IsResubmitted { get; set; }
        public decimal? StartVariance { get; set; }
        public decimal? EndVariance { get; set; }

        public decimal? WarningSpThreshold { get; set; }
        public decimal? ErrorSpThreshold { get; set; }
        //this filed doesn't exist in the entity.
        public DateTime EndDate { get; set; }
    }
}
