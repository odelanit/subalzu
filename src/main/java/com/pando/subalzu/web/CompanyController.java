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
import java.util.Optional;

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
        Optional<User> optionalUser = userRepository.findByUsername(principal.getName());
        if (optionalUser.isPresent()) {
            User currentUser = optionalUser.get();
            Company company = currentUser.getCompany();
            if (company == null) {
                company = new Company();
            }
            model.addAttribute("companyForm", company);
        }
        return "company";
    }

    @PostMapping("/company")
    public String updateCompany(Principal principal, @ModelAttribute("companyForm") Company companyForm, BindingResult bindingResult, Model model) {
        companyValidator.validate(companyForm, bindingResult);

        if (bindingResult.hasErrors()) {
            return "company";
        }

        if (companyForm.getId() == null) {
            Optional<User> optionalUser = userRepository.findByUsername(principal.getName());
            if (optionalUser.isPresent()) {
                User currentUser = optionalUser.get();
                CompanySetting companySetting = new CompanySetting();
                companyForm.setUser(currentUser);
                Company savedCompany = companyRepository.save(companyForm);
                companySetting.setCompany(savedCompany);
                companySettingRepository.save(companySetting);
            }
        } else {
            companyRepository.save(companyForm);
            Optional<CompanySetting> optionalCompanySetting = companySettingRepository.findByCompany_Id(companyForm.getId());
            if (!optionalCompanySetting.isPresent()) {
                CompanySetting companySetting = new CompanySetting();
                companySetting.setCompany(companyForm);
                companySettingRepository.save(companySetting);
            }
        }

        model.addAttribute("message", "Successfully updated.");
        return "redirect:/";
    }
}
