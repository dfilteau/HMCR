﻿using System;
using System.Collections.Generic;
using System.Text;

namespace Hmcr.Model.Dtos.RockfallReport
{
    public class RockfallReportDto
    {
        public int RowNumber { get; set; }
        public decimal RockfallReportId { get; set; }
        public decimal SubmissionObjectId { get; set; }
        public decimal? ValidationStatusId { get; set; }
        public string MajorIncidentNumber { get; set; }
        public DateTime? EstimatedRockfallDate { get; set; }
        public TimeSpan? EstimatedRockfallTime { get; set; }
        public decimal? StartLatitude { get; set; }
        public decimal? StartLongitude { get; set; }
        public decimal? EndLatitude { get; set; }
        public decimal? EndLongitude { get; set; }
        public string HighwayUniqueNumber { get; set; }
        public string HighwayUniqueName { get; set; }
        public string Landmark { get; set; }
        public string LandMarkName { get; set; }
        public decimal? StartOffset { get; set; }
        public decimal? EndOffset { get; set; }
        public string DirectionFromLandmark { get; set; }
        public string LocationDescription { get; set; }
        public string DitchVolume { get; set; }
        public string TravelledLanesVolume { get; set; }
        public decimal? OtherVolume { get; set; }
        public string HeavyPrecip { get; set; }
        public string FreezeThaw { get; set; }
        public string DitchSnowIce { get; set; }
        public string VehicleDamage { get; set; }
        public string Comments { get; set; }
        public string ReporterName { get; set; }
        public string McPhoneNumber { get; set; }
        public DateTime? ReportDate { get; set; }
    }
}