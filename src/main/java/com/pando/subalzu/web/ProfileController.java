package com.pando.subalzu.web;

import com.pando.subalzu.model.Company;
import com.pando.subalzu.model.User;
import com.pando.subalzu.repository.CompanyRepository;
import com.pando.subalzu.service.UserService;
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
    UserService userService;

    @Autowired
    CompanyRepository companyRepository;

    @Autowired
    CompanyValidator companyValidator;

    @GetMapping("/company")
    public String company(Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String username = auth.getName();
        User currentUser = userService.findByUsername(username);
        Company company = currentUser.getCompany();
        if (company == null) {
            company = new Company();
        }
        model.addAttribute("companyForm", company);
        return "company";
    }

    @PostMapping("/company")
    public String updateCompany(@ModelAttribute("companyForm") Company companyForm, BindingResult bindingResult, Model model) {
        companyValidator.validate(companyForm, bindingResult);

        if (bindingResult.hasErrors()) {
            return "company";
        }

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String username = auth.getName();
        User currentUser = userService.findByUsername(username);
        Company company = currentUser.getCompany();
        if (company == null) {
            currentUser.setCompany(companyForm);
            companyForm.setUser(currentUser);

            userService.save(currentUser);
        } else {
            companyForm.setUser(currentUser);
            companyRepository.save(companyForm);
        }

        model.addAttribute("message", "Successfully updated.");
        return "company";
    }

    @GetMapping("/profile")
    public String profile() {
        return "profile";
    }
}
