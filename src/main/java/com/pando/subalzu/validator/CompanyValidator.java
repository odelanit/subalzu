package com.pando.subalzu.validator;

import com.pando.subalzu.model.Company;
import com.pando.subalzu.repository.CompanyRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

@Component
public class CompanyValidator implements Validator {
    @Autowired
    private CompanyRepository companyRepository;

    @Override
    public boolean supports(Class<?> aClass) {
        return Company.class.equals(aClass);
    }

    @Override
    public void validate(Object o, Errors errors) {
        Company company = (Company) o;

        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "ownerName", "NotEmpty");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "erpCode", "NotEmpty");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "vendorName", "NotEmpty");
    }
}
