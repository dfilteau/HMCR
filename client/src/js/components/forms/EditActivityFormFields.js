import React, { useEffect, useState } from 'react';
import { connect } from 'react-redux';
import * as Yup from 'yup';
import moment from 'moment';

import SingleDateField from '../ui/SingleDateField';
import SingleDropdownField from '../ui/SingleDropdownField';
import PageSpinner from '../ui/PageSpinner';
import { FormRow, FormInput } from './FormInputs';

import * as api from '../../Api';
import * as Constants from '../../Constants';

const defaultValues = {
  activityNumber: '',
  activityName: '',
  unitOfMeasure: '',
  maintenanceType: '',
  locationCodeId: '',
  pointLineFeature: '',
  endDate: null,
};

const validationSchema = Yup.object({
  activityNumber: Yup.string()
    .required('Required')
    .max(6)
    .trim(),
  activityName: Yup.string()
    .required('Required')
    .max(150)
    .trim(),
  unitOfMeasure: Yup.string()
    .required('Required')
    .max(12),
  maintenanceType: Yup.string()
    .required('Required')
    .max(12),
  locationCodeId: Yup.number().required('Required'),
});

const EditActivityFormFields = ({
  setInitialValues,
  formValues,
  setValidationSchema,
  formType,
  activityId,
  maintenanceTypes,
  unitOfMeasures,
  locationCodes,
  pointLineFeatures,
}) => {
  const [loading, setLoading] = useState(true);
  const locationCodeCId = locationCodes.find(code => code.name === 'C').id;

  useEffect(() => {
    // Add validation for point line feature when location code is C.
    // Need to get the id value of location code C
    const defaultValidationSchema = validationSchema.shape({
      pointLineFeature: Yup.string()
        .nullable()
        .when('locationCodeId', {
          is: locationCodeCId,
          then: Yup.string()
            .required('Required')
            .max(12),
        }),
    });

    setValidationSchema(defaultValidationSchema);

    setLoading(true);

    if (formType === Constants.FORM_TYPE.ADD) {
      setInitialValues(defaultValues);
      setLoading(false);
    } else {
      api.getActivityCode(activityId).then(response => {
        setInitialValues({
          ...response.data,
          endDate: response.data.endDate ? moment(response.data.endDate) : null,
        });
        setLoading(false);
      });
    }

    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  if (loading || formValues === null) return <PageSpinner />;

  return (
    <React.Fragment>
      <FormRow name="activityNumber" label="Activity Code*">
        <FormInput type="text" name="activityNumber" placeholder="Activity Code" />
      </FormRow>
      <FormRow name="activityName" label="Activity Name*">
        <FormInput type="text" name="activityName" placeholder="Activity Name" />
      </FormRow>
      <FormRow name="unitOfMeasure" label="Unit*">
        <SingleDropdownField defaultTitle="Select Unit" items={unitOfMeasures} name="unitOfMeasure" />
      </FormRow>
      <FormRow name="maintenanceType" label="Maintenance Type*">
        <SingleDropdownField defaultTitle="Select Maintenance Type" items={maintenanceTypes} name="maintenanceType" />
      </FormRow>
      <FormRow name="locationCodeId" label="Location Code*">
        <SingleDropdownField defaultTitle="Select Location Code" items={locationCodes} name="locationCodeId" />
      </FormRow>
      <FormRow name="pointLineFeature" label="Point Line Feature*">
        <SingleDropdownField
          defaultTitle="Select Point Line Feature"
          items={pointLineFeatures}
          name="pointLineFeature"
        />
      </FormRow>
      <FormRow name="endDate" label="End Date">
        <SingleDateField name="endDate" placeholder="End Date" />
      </FormRow>
    </React.Fragment>
  );
};

const mapStateToProps = state => {
  return {
    maintenanceTypes: state.codeLookups.maintenanceTypes,
    unitOfMeasures: state.codeLookups.unitOfMeasures,
    locationCodes: state.codeLookups.locationCodes,
    pointLineFeatures: state.codeLookups.pointLineFeatures,
  };
};

export default connect(mapStateToProps)(EditActivityFormFields);
