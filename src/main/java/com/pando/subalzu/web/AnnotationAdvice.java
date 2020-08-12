package com.pando.subalzu.web;

import com.pando.subalzu.model.CompanyConfig;
import com.pando.subalzu.model.User;
import com.pando.subalzu.repository.CompanyConfigRepository;
import com.pando.subalzu.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import java.security.Principal;
import java.util.Optional;

@ControllerAdvice(annotations = Controller.class)
public class AnnotationAdvice {

    @Autowired
    UserRepository userRepository;

    @Autowired
    CompanyConfigRepository configRepository;

    @ModelAttribute("currentUser")
    public User getCurrentUser(Principal principal) {
        if (principal == null) {
            return null;
        } else {
            Optional<User> optionalUser = userRepository.findByUsername(principal.getName());
            return optionalUser.orElse(null);
        }
    }

    @ModelAttribute("companyName")
    public String companyName() {
        Optional<CompanyConfig> configOptional = configRepository.findByKey("vendorName");
        return configOptional.map(CompanyConfig::getValue).orElse(null);
    }
}
