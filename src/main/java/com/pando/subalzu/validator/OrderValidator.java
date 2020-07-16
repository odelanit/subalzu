package com.pando.subalzu.validator;

import com.pando.subalzu.model.CartItem;
import com.pando.subalzu.model.Order;
import com.pando.subalzu.model.User;
import com.pando.subalzu.repository.CartItemRepository;
import com.pando.subalzu.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import java.util.List;
import java.util.Optional;

@Component
public class OrderValidator implements Validator {
    @Autowired
    UserRepository userRepository;

    @Autowired
    CartItemRepository cartItemRepository;

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

        Object userDetails = SecurityContextHolder.getContext().getAuthentication().getDetails();
        if (userDetails instanceof UserDetails) {
            Optional<User> optionalUser = userRepository.findByUsername(((UserDetails)userDetails).getUsername());
            if (optionalUser.isPresent()) {
                List<CartItem> cartItems = cartItemRepository.findByUser(optionalUser.get());
                if (cartItems.isEmpty()) {
                    errors.rejectValue("orderProducts", "NotEmpty");
                }
            } else {
                errors.rejectValue("orderProducts", "NotEmpty");
            }
        }
    }
}
