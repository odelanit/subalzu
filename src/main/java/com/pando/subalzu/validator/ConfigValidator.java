package com.pando.subalzu.validator;

import com.pando.subalzu.form.CompanyConfigForm;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

@Component
public class ConfigValidator implements Validator {

    @Override
    public boolean supports(Class<?> aClass) {
        return CompanyConfigForm.class.equals(aClass);
    }

    @Override
    public void validate(Object o, Errors errors) {
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "ownerName", "NotEmpty");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "erpCode", "NotEmpty");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "vendorName", "NotEmpty");
    }
}
