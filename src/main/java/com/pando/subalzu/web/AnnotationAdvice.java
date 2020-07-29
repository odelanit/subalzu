package com.pando.subalzu.web;

import com.pando.subalzu.model.Company;
import com.pando.subalzu.model.User;
import com.pando.subalzu.repository.CompanyRepository;
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
    CompanyRepository companyRepository;

    Company currentCompany;

    @ModelAttribute("currentUser")
    public User getCurrentUser(Principal principal) {
        if (principal == null) {
            return null;
        } else {
            Optional<User> optionalUser = userRepository.findByUsername(principal.getName());
            return optionalUser.orElse(null);
        }
    }

    @ModelAttribute("currentCompany")
    public Company getCurrentCompany(Principal principal) {
        if (principal == null) {
            return null;
        }
        else {
            Optional<Company> optionalCompany = companyRepository.findByUserUsername(principal.getName());
            return optionalCompany.orElse(null);
        }
    }
}
