package com.pando.subalzu.web;

import com.pando.subalzu.form.CompanyConfigForm;
import com.pando.subalzu.model.CompanyConfig;
import com.pando.subalzu.repository.CompanyConfigRepository;
import com.pando.subalzu.repository.UserRepository;
import com.pando.subalzu.validator.ConfigValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

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

    @PostMapping("/company/set")
    @ResponseBody
    public Map<String, String> setConfig(@RequestBody Map<String, String> payload) {
        for (Map.Entry<String, String> entry : payload.entrySet()) {
            Optional<CompanyConfig> optionalConfig = configRepository.findByKey(entry.getKey());
            CompanyConfig config;
            if (optionalConfig.isPresent()) {
                config = optionalConfig.get();
            } else {
                config = new CompanyConfig();
                config.setKey(entry.getKey());
            }
            config.setValue(entry.getValue());
            configRepository.save(config);
        }
        Map<String, String> resultMap = new HashMap<>();
        resultMap.put("message", "Success");
        return resultMap;
    }
}
