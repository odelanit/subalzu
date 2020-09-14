package com.pando.subalzu.validator;

import com.google.common.base.Strings;
import com.pando.subalzu.model.Supplier;
import com.pando.subalzu.repository.SupplyOwnerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import java.util.regex.Pattern;

@Component
public class SupplierValidator implements Validator {

    @Autowired
    private SupplyOwnerRepository supplyOwnerRepository;

    @Override
    public boolean supports(Class<?> aClass) {
        return Supplier.class.equals(aClass);
    }

    @Override
    public void validate(Object o, Errors errors) {
        Supplier supplier = (Supplier) o;

        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "name", "NotEmpty");

        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "username", "NotEmpty");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "fullName", "NotEmpty");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "phone", "NotEmpty");

        if (supplier.getOwner() == null) {
            ValidationUtils.rejectIfEmptyOrWhitespace(errors, "password", "NotEmpty");
        }

        if (supplier.getUsername().length() < 4) {
            errors.rejectValue("username", "Size.userForm.username");
        }

        if (!Pattern.matches("^[a-zA-Z0-9]*$", supplier.getUsername())) {
            errors.rejectValue("username", "Size.userForm.username");
        }

        if (!Pattern.matches("^[0-9]*$", supplier.getPhone())) {
            errors.rejectValue("phone", "Numeric");
        }

        if (supplier.getOwner() == null && (supplyOwnerRepository.getSupplyOwnerByUsername(supplier.getUsername())).isPresent()) {
            errors.rejectValue("username", "Duplicate.userForm.username");
        }

        if (!Strings.isNullOrEmpty(supplier.getPassword()) && supplier.getPassword().length() < 6) {
            errors.rejectValue("password", "Size.userForm.password");
        }

        if (!Strings.isNullOrEmpty(supplier.getPassword()) && !supplier.getPasswordConfirm().equals(supplier.getPassword())) {
            errors.rejectValue("passwordConfirm", "Diff.userForm.passwordConfirm");
        }
    }
}
