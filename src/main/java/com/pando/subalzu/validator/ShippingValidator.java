package com.pando.subalzu.validator;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

@Component
public class ShippingValidator implements Validator {
    @Override
    public boolean supports(Class<?> aClass) {
        return false;
    }

    @Override
    public void validate(Object o, Errors errors) {
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "supplier", "NotEmpty");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "user", "NotEmpty");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "deliverBy", "NotEmpty");
    }
}
