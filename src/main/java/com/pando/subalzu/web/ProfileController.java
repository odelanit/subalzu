package com.pando.subalzu.web;

import com.pando.subalzu.model.Company;
import com.pando.subalzu.service.CompanyService;
import com.pando.subalzu.validator.CompanyValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.List;

@Controller
public class ProfileController {
    @Autowired
    CompanyService companyService;

    @Autowired
    CompanyValidator companyValidator;

    @GetMapping("/company")
    public String company(Model model) {
        Company company = companyService.getFirst();
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

        companyService.save(companyForm);
        model.addAttribute("message", "Successfully updated.");
        return "company";
    }
}
