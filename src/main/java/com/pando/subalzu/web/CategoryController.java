package com.pando.subalzu.web;

import com.pando.subalzu.form.CategoryLevelForm;
import com.pando.subalzu.model.Category;
import com.pando.subalzu.model.CompanyConfig;
import com.pando.subalzu.repository.CategoryRepository;
import com.pando.subalzu.repository.CompanyConfigRepository;
import com.pando.subalzu.validator.CategoryValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@Controller
public class CategoryController {
    @Autowired
    CategoryRepository categoryRepository;

    @Autowired
    CompanyConfigRepository companyConfigRepository;

    @Autowired
    CategoryValidator categoryValidator;

    @GetMapping("/categories")
    public String index(Model model) {
        model.addAttribute("categoryForm", new Category());
        return "category_list";
    }

    @GetMapping("/categories/data")
    @ResponseBody
    public Map<String, Object> getData() {
        Map<String, Object> resultMap = new HashMap<>();
        Optional<CompanyConfig> optionalCompanyConfig = companyConfigRepository.findByKey("first_category_popup");
        if (optionalCompanyConfig.isPresent()) {
            resultMap.put("first_category_popup", optionalCompanyConfig.get().getValue());
        } else {
            resultMap.put("first_category_popup", "off");
        }
        optionalCompanyConfig = companyConfigRepository.findByKey("use_special_price_rate");
        if (optionalCompanyConfig.isPresent()) {
            resultMap.put("use_special_price_rate", optionalCompanyConfig.get().getValue());
        } else {
            resultMap.put("use_special_price_rate", "false");
        }
        List<Category> categories = categoryRepository.findByParentNull();
        resultMap.put("categories", categories);
        resultMap.put("message", "Success");
        return resultMap;
    }

    @PostMapping("/categories/store")
    @ResponseBody
    public Map<String, Object> store(@RequestBody Map<String, Object> payload) {
        String name = (String)payload.get("name");
        Long categoryId = ((Integer)payload.get("category")).longValue();
        Optional<Category> optionalCategory = categoryRepository.findById(categoryId);
        Category newCategory = new Category();
        if (optionalCategory.isPresent()) {
            Category category = optionalCategory.get();
            newCategory.setParent(category);
        }
        newCategory.setName(name);
        newCategory = categoryRepository.save(newCategory);
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("message", "Success");
        resultMap.put("category", newCategory);
        return resultMap;
    }

    @PostMapping("/categories/change_level")
    @ResponseBody
    public Map<String, String> changeLevel(CategoryLevelForm form) {
        Long id = form.getId();
        String direction = form.getDirection();
        Optional<Category> optionalCategory = categoryRepository.findById(id);
        if (optionalCategory.isPresent()) {
            Category category = optionalCategory.get();
            if (direction.equalsIgnoreCase("up")) {
                category.setLevel(category.getLevel() + 1);
            } else {
                category.setLevel(category.getLevel() - 1);
            }
            categoryRepository.save(category);
        }

        Map<String, String> resultMap = new HashMap<>();
        resultMap.put("message", "Success");
        return resultMap;
    }

    // TODO: 카테고리 이름 수정
    @PostMapping("/categories/update")
    @ResponseBody
    public Map<String, String> update(@RequestBody Map<String, Object> payload) {
        String name = (String) payload.get("name");
        Long id = Long.valueOf((Integer)payload.get("id"));
        Optional<Category> optionalCategory = categoryRepository.findById(id);
        if (optionalCategory.isPresent()) {
            Category category = optionalCategory.get();
            category.setName(name);
            categoryRepository.save(category);
        }
        Map<String, String> resultMap = new HashMap<>();
        resultMap.put("message", "Success");
        resultMap.put("result_code", "00");
        return resultMap;
    }

    @PostMapping("/categories/delete")
    @ResponseBody
    public Map<String, String> delete(@RequestBody Map<String, Object> payload) {
        Long id = Long.valueOf((Integer)payload.get("category"));
        Optional<Category> optionalCategory = categoryRepository.findById(id);
        if (optionalCategory.isPresent()) {
            Category category = optionalCategory.get();
            categoryRepository.delete(category);
        }
        Map<String, String> resultMap = new HashMap<>();
        resultMap.put("message", "Success");
        resultMap.put("result_code", "00");
        return resultMap;
    }

    @PostMapping("/categories/set_individual")
    @ResponseBody
    public Map<String, Object> updateFixedRate(@RequestBody Map<String, String> payload) {
        Map<String, Object> resultMap = new HashMap<>();

        Long categoryId = Long.valueOf(payload.get("category"));
        Optional<Category> optionalCategory = categoryRepository.findById(categoryId);
        if (optionalCategory.isPresent()) {
            Category category = optionalCategory.get();
            category.setUseIndividual(!category.getUseIndividual());
            category = categoryRepository.save(category);
            resultMap.put("useIndividual", category.getUseIndividual());
        }
        resultMap.put("message", "Success");
        return resultMap;
    }
}
