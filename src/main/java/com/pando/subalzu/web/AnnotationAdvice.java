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

@ControllerAdvice(annotations = Controller.class)
public class AnnotationAdvice {

    @Autowired
    UserRepository userRepository;

    @Autowired
    CompanyRepository companyRepository;

    Company currentCompany;

    @ModelAttribute("currentUser")
    public User getCurrentUser(Principal principal) {
        User user;
        if (principal == null) {
            user = null;
        } else {
            user = userRepository.findByUsername(principal.getName());
        }
        return user;
    }

    @ModelAttribute("currentCompany")
    public Company getCurrentCompany(Principal principal) {
        Company company;
        if (principal == null) {
            company = null;
        }
        else {
            company = companyRepository.findByUserUsername(principal.getName());
        }
        return company;
    }
}
