package com.pando.subalzu.web;

import com.pando.subalzu.form.CompanyConfigForm;
import com.pando.subalzu.repository.CompanyConfigRepository;
import com.pando.subalzu.repository.UserRepository;
import com.pando.subalzu.validator.ConfigValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class CompanyController {

    @Autowired
    CompanyConfigRepository configRepository;

    @Autowired
    UserRepository userRepository;

    @Autowired
    ConfigValidator configValidator;

    @GetMapping("/company")
    public String company(@ModelAttribute("configForm") CompanyConfigForm configForm) {
        configForm.setConfigRepository(configRepository);
        return "company";
    }

    @PostMapping("/company")
    public String updateCompany(@ModelAttribute("configForm") CompanyConfigForm configForm, BindingResult bindingResult, Model model) {
        configForm.setConfigRepository(configRepository);
        configValidator.validate(configForm, bindingResult);

        if (bindingResult.hasErrors()) {
            return "company";
        }

        configForm.save();

        model.addAttribute("message", "Successfully updated.");
        return "redirect:/";
    }
}
