package com.pando.subalzu.web;

import com.pando.subalzu.model.Category;
import com.pando.subalzu.model.CompanyConfig;
import com.pando.subalzu.model.FixedPriceRate;
import com.pando.subalzu.model.PriceGroup;
import com.pando.subalzu.repository.CategoryRepository;
import com.pando.subalzu.repository.CompanyConfigRepository;
import com.pando.subalzu.repository.FixedPriceRateRepository;
import com.pando.subalzu.repository.PriceGroupRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@Controller
@RequestMapping("/fixed_price_rate")
public class FixedPriceRateController {

    @Autowired
    CompanyConfigRepository companyConfigRepository;

    @Autowired
    PriceGroupRepository priceGroupRepository;

    @Autowired
    CategoryRepository categoryRepository;

    @Autowired
    FixedPriceRateRepository fixedPriceRateRepository;

    @GetMapping("")
    public String index() {
        return "fixed_price_rate";
    }

    @GetMapping("/data")
    @ResponseBody
    public Map<String, Object> getData() {
        Map<String, Object> resultMap = new HashMap<>();
        Optional<CompanyConfig> optionalCompanyConfig = companyConfigRepository.findByKey("use_special_price_rate");
        String useSpecialPriceRate = "";
        if (optionalCompanyConfig.isPresent()) {
            useSpecialPriceRate = optionalCompanyConfig.get().getValue();
        } else {
            useSpecialPriceRate = "false";
        }
        resultMap.put("use_special_price_rate", useSpecialPriceRate);

        List<PriceGroup> priceGroups = priceGroupRepository.findAll(Sort.by("id"));

        List<Category> categoriesUseIndividual = categoryRepository.getCategoriesByUseIndividualTrue();

        List<List<FixedPriceRate>> matrixFixedPriceRate = new ArrayList<>();

        List<FixedPriceRate> fixedPriceRates = new ArrayList<>();
        for (PriceGroup priceGroup : priceGroups) {
            Optional<FixedPriceRate> optional = fixedPriceRateRepository.findByCategoryAndPriceGroup(null, priceGroup);
            FixedPriceRate fixedPriceRate;
            if (optional.isPresent()) {
                fixedPriceRate = optional.get();
            } else {
                fixedPriceRate = new FixedPriceRate();
                fixedPriceRate.setCategory(null);
                fixedPriceRate.setPriceGroup(priceGroup);
                fixedPriceRate = fixedPriceRateRepository.save(fixedPriceRate);
            }
            fixedPriceRates.add(fixedPriceRate);
        }
        matrixFixedPriceRate.add(fixedPriceRates);

        for (Category category : categoriesUseIndividual) {
            List<FixedPriceRate> fixedPriceRates1 = new ArrayList<>();
            for (PriceGroup priceGroup : priceGroups) {
                Optional<FixedPriceRate> optional = fixedPriceRateRepository.findByCategoryAndPriceGroup(category, priceGroup);
                FixedPriceRate fixedPriceRate;
                if (optional.isPresent()) {
                    fixedPriceRate = optional.get();
                } else {
                    fixedPriceRate = new FixedPriceRate();
                    fixedPriceRate.setCategory(category);
                    fixedPriceRate.setPriceGroup(priceGroup);
                    fixedPriceRate = fixedPriceRateRepository.save(fixedPriceRate);
                }
                fixedPriceRates1.add(fixedPriceRate);
            }
            matrixFixedPriceRate.add(fixedPriceRates1);
        }

        resultMap.put("priceGroups", priceGroups);
        resultMap.put("categories", categoriesUseIndividual);
        resultMap.put("matrix", matrixFixedPriceRate);

        resultMap.put("message", "Success");
        return resultMap;
    }

    @PostMapping("/store")
    @ResponseBody
    public Map<String, String> store(@RequestBody Map<String, Object> payload) {
        List<List<Map<String, Object>>> matrix = (List<List<Map<String, Object>>>) payload.get("matrix");
        for (List<Map<String, Object>> row : matrix) {
            for (Map<String, Object> column : row) {
                Long id = ((Integer)column.get("id")).longValue();
                Double rate = Double.parseDouble(column.get("rate").toString());
                String unit = (String) column.get("unit");
                Optional<FixedPriceRate> optionalFixedPriceRate = fixedPriceRateRepository.findById(id);
                if (optionalFixedPriceRate.isPresent()) {
                    FixedPriceRate fixedPriceRate = optionalFixedPriceRate.get();
                    fixedPriceRate.setRate(rate);
                    fixedPriceRate.setUnit(unit);
                    fixedPriceRateRepository.save(fixedPriceRate);
                }
            }
        }
        Map<String, String> resultMap = new HashMap<>();
        resultMap.put("message", "Success");
        return resultMap;
    }
}
