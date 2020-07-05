package com.pando.subalzu.web;

import com.pando.subalzu.model.Company;
import com.pando.subalzu.model.CompanySetting;
import com.pando.subalzu.model.User;
import com.pando.subalzu.repository.CompanyRepository;
import com.pando.subalzu.repository.CompanySettingRepository;
import com.pando.subalzu.repository.UserRepository;
import com.pando.subalzu.validator.CompanyValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import java.security.Principal;

@Controller
public class CompanyController {

    @Autowired
    CompanyRepository companyRepository;

    @Autowired
    CompanySettingRepository companySettingRepository;

    @Autowired
    UserRepository userRepository;

    @Autowired
    CompanyValidator companyValidator;

    @GetMapping("/company")
    public String company(Principal principal, Model model) {
        User currentUser = userRepository.findByUsername(principal.getName());
        Company company = currentUser.getCompany();
        if (company == null) {
            company = new Company();
        }
        model.addAttribute("companyForm", company);
        return "company";
    }

    @PostMapping("/company")
    public String updateCompany(Principal principal, @ModelAttribute("companyForm") Company companyForm, BindingResult bindingResult, Model model) {
        companyValidator.validate(companyForm, bindingResult);

        if (bindingResult.hasErrors()) {
            return "company";
        }

        User currentUser = userRepository.findByUsername(principal.getName());
        companyForm.setUser(currentUser);
        Company company = companyRepository.save(companyForm);
        CompanySetting companySetting = company.getCompanySetting();
        if (companySetting == null) {
            companySetting = new CompanySetting();
            companySetting.setCompany(company);
            companySettingRepository.save(companySetting);
        }

        model.addAttribute("message", "Successfully updated.");
        return "company";
    }
}
