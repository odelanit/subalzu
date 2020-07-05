package com.pando.subalzu.web;

import com.pando.subalzu.model.Company;
import com.pando.subalzu.model.User;
import com.pando.subalzu.repository.CompanyRepository;
import com.pando.subalzu.repository.UserRepository;
import com.pando.subalzu.validator.CompanyValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class ProfileController {
    @Autowired
    UserRepository userRepository;

    @GetMapping("/profile")
    public String profile() {
        return "profile";
    }
}
