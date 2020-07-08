package com.pando.subalzu.validator;

import com.pando.subalzu.model.ShopGrade;
import com.pando.subalzu.repository.ShopGradeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

@Component
public class ShopGradeValidator implements Validator {

    @Autowired
    ShopGradeRepository shopGradeRepository;

    @Override
    public boolean supports(Class<?> aClass) {
        return false;
    }

    @Override
    public void validate(Object o, Errors errors) {
        ShopGrade shopGrade = (ShopGrade) o;
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "name", "NotEmpty");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "saleType", "NotEmpty");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "percentage", "NotEmpty");

        if (shopGrade.getPercentage() < 0) {
            errors.rejectValue("percentage", "Size.shopGradeForm.percentage");
        }

        if (shopGrade.getId() == null) {
            if (shopGradeRepository.findByName(shopGrade.getName()) != null) {
                errors.rejectValue("name", "Duplicate.shopGradeForm.name");
            }
        }
    }
}
