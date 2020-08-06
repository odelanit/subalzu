package com.pando.subalzu.validator;

import com.pando.subalzu.model.Order;
import com.pando.subalzu.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

@Component
public class OrderValidator implements Validator {
    @Autowired
    UserRepository userRepository;

    @Override
    public boolean supports(Class<?> aClass) {
        return false;
    }

    @Override
    public void validate(Object o, Errors errors) {
        Order order = (Order) o;

        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "shop", "NotEmpty");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "deliveryType", "NotEmpty");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "deliverer", "NotEmpty");
    }
}
