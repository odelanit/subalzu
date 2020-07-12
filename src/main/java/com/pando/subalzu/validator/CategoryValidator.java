package com.pando.subalzu.validator;

import com.pando.subalzu.model.Category;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

@Component
public class CategoryValidator implements Validator {
    @Override
    public boolean supports(Class<?> aClass) {
        return false;
    }

    @Override
    public void validate(Object o, Errors errors) {
        Category category = (Category)o;
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "name", "NotEmpty");
    }
}
