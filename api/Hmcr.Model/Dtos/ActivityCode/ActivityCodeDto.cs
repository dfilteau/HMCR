﻿using System;
using System.Collections.Generic;
using System.Text;

namespace Hmcr.Model.Dtos.ActivityCode
{
    public class ActivityCodeDto
    {
        public decimal ActivityCodeId { get; set; }
        public string ActivityNumber { get; set; }
        public string ActivityName { get; set; }
        public string UnitOfMeasure { get; set; }
        public string MaintenanceType { get; set; }
        public decimal LocationCodeId { get; set; }
        public string PointLineFeature { get; set; }
        public string ActivityApplication { get; set; }
        public DateTime? EndDate { get; set; }
        public bool IsActive => EndDate == null || EndDate > DateTime.Today;

        public LocationCodeDto LocationCode { get; set; }

    }
}
