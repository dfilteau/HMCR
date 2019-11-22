﻿using AutoMapper;
using Hmcr.Data.Database.Entities;
using Hmcr.Model.Dtos.ContractTerm;
using Hmcr.Model.Dtos.District;
using Hmcr.Model.Dtos.MimeType;
using Hmcr.Model.Dtos.Party;
using Hmcr.Model.Dtos.Permission;
using Hmcr.Model.Dtos.Region;
using Hmcr.Model.Dtos.Role;
using Hmcr.Model.Dtos.RolePermission;
using Hmcr.Model.Dtos.ServiceArea;
using Hmcr.Model.Dtos.ServiceAreaUser;
using Hmcr.Model.Dtos.SubmissionObject;
using Hmcr.Model.Dtos.SubmissionStatus;
using Hmcr.Model.Dtos.User;
using Hmcr.Model.Dtos.UserRole;

namespace Hmcr.Data.Mappings
{
    public class ModelToEntityProfile : Profile
    {
        public ModelToEntityProfile()
        {
            SourceMemberNamingConvention = new PascalCaseNamingConvention();
            DestinationMemberNamingConvention = new LowerUnderscoreNamingConvention();

            SourceMemberNamingConvention = new LowerUnderscoreNamingConvention();
            DestinationMemberNamingConvention = new PascalCaseNamingConvention();

            CreateMap<ContractTermDto, HmrContractTerm>();

            CreateMap<DistrictDto, HmrDistrict>();

            CreateMap<MimeTypeDto, HmrMimeType>();

            CreateMap<PartyDto, HmrParty>();

            CreateMap<PermissionDto, HmrPermission>();

            CreateMap<RegionDto, HmrRegion>();

            CreateMap<RoleDto, HmrRole>();

            CreateMap<RolePermissionDto, HmrRolePermission>();

            CreateMap<ServiceAreaDto, HmrServiceArea>();
            CreateMap<ServiceAreaNumberDto, HmrServiceArea>();

            CreateMap<ServiceAreaUserDto, HmrServiceAreaUser>();

            CreateMap<SubmissionObjectDto, HmrSubmissionObject>();

            CreateMap<SubmissionStatusDto, HmrSubmissionStatu>();

            CreateMap<UserDto, HmrSystemUser>();
            CreateMap<UserCreateDto, HmrSystemUser>();
            CreateMap<UserCurrentDto, HmrSystemUser>();
            CreateMap<UserSearchDto, HmrSystemUser>();
            CreateMap<UserUpdateDto, HmrSystemUser>();
            CreateMap<UserDeleteDto, HmrSystemUser>();

            CreateMap<UserRoleDto, HmrUserRole>();
        }
    }
}
