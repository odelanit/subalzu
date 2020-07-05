package com.pando.subalzu.web;

import com.pando.subalzu.model.Company;
import com.pando.subalzu.model.User;
import com.pando.subalzu.repository.CompanyRepository;
import com.pando.subalzu.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

@ControllerAdvice(annotations = Controller.class)
public class AnnotationAdvice {

    @Autowired
    UserRepository userRepository;

    @Autowired
    CompanyRepository companyRepository;

    Company currentCompany;

    @ModelAttribute("currentUser")
    public User getCurrentUser() {
        UserDetails userDetails = (UserDetails)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        return userRepository.findByUsername(userDetails.getUsername());
    }

    @ModelAttribute("currentCompany")
    public Company getCurrentCompany() {
        UserDetails userDetails = (UserDetails)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        return companyRepository.findByUserUsername(userDetails.getUsername());
    }
}
