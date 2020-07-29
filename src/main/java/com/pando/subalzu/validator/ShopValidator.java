package com.pando.subalzu.validator;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

@Component
public class ShopValidator implements Validator {
    @Override
    public boolean supports(Class<?> aClass) {
        return false;
    }

    @Override
    public void validate(Object o, Errors errors) {
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "name", "NotEmpty");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "business", "NotEmpty");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "zipCode", "NotEmpty");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "addressLine1", "NotEmpty");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "addressLine2", "NotEmpty");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "ownerUsername", "NotEmpty");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "ownerFullname", "NotEmpty");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "ownerPhone", "NotEmpty");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "deliverer", "NotEmpty");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "deliveryType", "NotEmpty");
    }
}
