﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Hmcr.Api.Controllers.Base;
using Hmcr.Domain.Services;
using Hmcr.Model.Dtos.CodeLookup;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Hmcr.Api.Controllers
{
    [ApiVersion("1.0")]
    [Route("api/codelookup")]
    [ApiController]
    public class CodeLookupController : HmcrControllerBase
    {
        private IFieldValidatorService _validator;

        public CodeLookupController(IFieldValidatorService validator)
        {
            _validator = validator;
        }

        [HttpGet ("maintenancetypes")]
        public ActionResult<IEnumerable<CodeLookupForValidation>> GetMaintenanceTypes()
        {
           return Ok(_validator.CodeLookup.Where(x => x.CodeSet == "WRK_RPT_MAINT_TYPE"));
        }

        [HttpGet ("unitofmeasures")]
        public ActionResult<IEnumerable<CodeLookupForValidation>> GetUnitOfMeasures()
        {
            return Ok(_validator.CodeLookup.Where(x => x.CodeSet == "UOM"));
        }

        [HttpGet("pointlinefeatures")]
        public ActionResult<IEnumerable<CodeLookupForValidation>> GetPointlineFeatures()
        {
            //Test Data
            CodeLookupForValidation[] clfv = new CodeLookupForValidation[2] {
                new CodeLookupForValidation{CodeValue = "1", CodeName = "Point", CodeSet = "PointLine" },
                new CodeLookupForValidation{CodeValue = "2", CodeName = "Line", CodeSet = "PointLine" },
            };

            return Ok(clfv);
        }
    }
}