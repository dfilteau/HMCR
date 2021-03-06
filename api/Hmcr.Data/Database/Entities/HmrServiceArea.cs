﻿using System;
using System.Collections.Generic;

namespace Hmcr.Data.Database.Entities
{
    public partial class HmrServiceArea
    {
        public HmrServiceArea()
        {
            HmrContractTerms = new HashSet<HmrContractTerm>();
            HmrRockfallReports = new HashSet<HmrRockfallReport>();
            HmrServiceAreaActivities = new HashSet<HmrServiceAreaActivity>();
            HmrServiceAreaUsers = new HashSet<HmrServiceAreaUser>();
            HmrSubmissionObjects = new HashSet<HmrSubmissionObject>();
            HmrWildlifeReports = new HashSet<HmrWildlifeReport>();
            HmrWorkReports = new HashSet<HmrWorkReport>();
        }

        public decimal ServiceAreaId { get; set; }
        public decimal ServiceAreaNumber { get; set; }
        public string ServiceAreaName { get; set; }
        public decimal DistrictNumber { get; set; }
        public string HighwayUniquePrefix { get; set; }
        public long ConcurrencyControlNumber { get; set; }
        public string DbAuditCreateUserid { get; set; }
        public DateTime DbAuditCreateTimestamp { get; set; }
        public string DbAuditLastUpdateUserid { get; set; }
        public DateTime DbAuditLastUpdateTimestamp { get; set; }

        public virtual HmrDistrict DistrictNumberNavigation { get; set; }
        public virtual ICollection<HmrContractTerm> HmrContractTerms { get; set; }
        public virtual ICollection<HmrRockfallReport> HmrRockfallReports { get; set; }
        public virtual ICollection<HmrServiceAreaActivity> HmrServiceAreaActivities { get; set; }
        public virtual ICollection<HmrServiceAreaUser> HmrServiceAreaUsers { get; set; }
        public virtual ICollection<HmrSubmissionObject> HmrSubmissionObjects { get; set; }
        public virtual ICollection<HmrWildlifeReport> HmrWildlifeReports { get; set; }
        public virtual ICollection<HmrWorkReport> HmrWorkReports { get; set; }
    }
}
