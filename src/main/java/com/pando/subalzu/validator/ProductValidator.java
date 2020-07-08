package com.pando.subalzu.validator;

import com.pando.subalzu.model.Product;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

@Component
public class ProductValidator implements Validator {
    @Override
    public boolean supports(Class<?> aClass) {
        return false;
    }

    @Override
    public void validate(Object o, Errors errors) {
        Product product = (Product) o;

        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "name", "NotEmpty");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "tax", "NotEmpty");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "deliveryTypes", "NotEmpty");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "shippingMethod", "NotEmpty");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "useDecimal", "NotEmpty");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "parcelPrice", "NotEmpty");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "directPrice", "NotEmpty");
    }
}
