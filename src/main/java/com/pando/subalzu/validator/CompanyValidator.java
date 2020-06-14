package com.pando.subalzu.validator;

import com.pando.subalzu.model.Company;
import com.pando.subalzu.service.CompanyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

@Component
public class CompanyValidator implements Validator {
    @Autowired
    private CompanyService companyService;

    @Override
    public boolean supports(Class<?> aClass) {
        return Company.class.equals(aClass);
    }

    @Override
    public void validate(Object o, Errors errors) {
        Company company = (Company) o;

        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "ownerName", "NotEmpty");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "registeredNumber", "NotEmpty");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "represent", "NotEmpty");
    }
}
