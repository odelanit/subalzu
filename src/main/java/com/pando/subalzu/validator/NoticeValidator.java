package com.pando.subalzu.validator;

import com.pando.subalzu.model.Notice;
import com.pando.subalzu.model.User;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

@Component
public class NoticeValidator implements Validator {
    @Override
    public boolean supports(Class<?> aClass) {
        return false;
    }

    @Override
    public void validate(Object o, Errors errors) {
        Notice notice = (Notice) o;
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "type", "NotEmpty");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "title", "NotEmpty");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "description", "NotEmpty");

        if (notice.getSection().length() > 10) {
            errors.rejectValue("section", "Size.noticeForm.section");
        }
    }
}
