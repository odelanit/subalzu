package com.pando.subalzu.web;

import com.pando.subalzu.model.Company;
import com.pando.subalzu.model.CompanySetting;
import com.pando.subalzu.model.User;
import com.pando.subalzu.repository.CompanyRepository;
import com.pando.subalzu.repository.CompanySettingRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import java.security.Principal;
import java.util.Map;

@Controller
public class PriceController {

    @Autowired
    CompanyRepository companyRepository;

    @Autowired
    CompanySettingRepository companySettingRepository;

    @GetMapping("/prices")
    public String index() {
        return "price_list";
    }

    @GetMapping("/prices/fixed-price-rate")
    public String fixedRate(Principal principal, Model model) {
        Company company = companyRepository.findByUserUsername(principal.getName());
        if (company == null) {
            return "redirect:/company";
        }
        CompanySetting companySetting = company.getCompanySetting();
        if (companySetting == null) {
            return "redirect:/company";
        }
        boolean fixedRateSetting = companySetting.getFixedPriceRate();
        model.addAttribute("fixedRateSetting", fixedRateSetting);
        return "price_fixed_rate";
    }

    @PostMapping("/prices/fixed-price-rate")
    public String updateRate(Principal principal, @RequestParam Map<String, String> formData) {
        Company company = companyRepository.findByUserUsername(principal.getName());
        CompanySetting companySetting = company.getCompanySetting();
        boolean fixedRateSetting = Boolean.parseBoolean(formData.get("is_fixed"));
        companySetting.setFixedPriceRate(fixedRateSetting);
        companySettingRepository.save(companySetting);
        return "redirect:/prices";
    }
}
