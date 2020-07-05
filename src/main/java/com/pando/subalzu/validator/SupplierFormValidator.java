package com.pando.subalzu.validator;

import com.pando.subalzu.form.SupplierForm;
import com.pando.subalzu.model.Supplier;
import com.pando.subalzu.model.User;
import com.pando.subalzu.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import java.util.regex.Pattern;

@Component
public class SupplierFormValidator implements Validator {

    @Autowired
    private UserRepository userRepository;

    @Override
    public boolean supports(Class<?> aClass) {
        return SupplierForm.class.equals(aClass);
    }

    @Override
    public void validate(Object o, Errors errors) {
        SupplierForm supplierForm = (SupplierForm) o;

        Supplier supplier = supplierForm.getSupplier();
        User user = supplierForm.getUser();

        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "supplier.name", "NotEmpty");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "user.username", "NotEmpty");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "user.fullName", "NotEmpty");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "user.phone", "NotEmpty");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "user.password", "NotEmpty");

        if (user.getUsername().length() < 4) {
            errors.rejectValue("user.username", "Size.userForm.username");
        }

        if (!Pattern.matches("^[a-zA-Z0-9]*$", user.getUsername())) {
            errors.rejectValue("user.username", "Size.userForm.username");
        }

        if (!Pattern.matches("^[0-9]*$", user.getPhone())) {
            errors.rejectValue("user.phone", "Numeric");
        }

        if (userRepository.findByUsername(user.getUsername()) != null) {
            errors.rejectValue("user.username", "Duplicate.userForm.username");
        }

        if (user.getPassword().length() < 6) {
            errors.rejectValue("user.password", "Size.userForm.password");
        }

        if (!user.getPasswordConfirm().equals(user.getPassword())) {
            errors.rejectValue("user.passwordConfirm", "Diff.userForm.passwordConfirm");
        }
    }
}
