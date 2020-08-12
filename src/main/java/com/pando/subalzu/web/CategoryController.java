package com.pando.subalzu.web;

import com.pando.subalzu.form.CategoryLevelForm;
import com.pando.subalzu.form.CategoryPopupForm;
import com.pando.subalzu.model.Category;
import com.pando.subalzu.repository.CategoryRepository;
import com.pando.subalzu.repository.CompanyConfigRepository;
import com.pando.subalzu.validator.CategoryValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.*;

@Controller
public class CategoryController {
    @Autowired
    CategoryRepository categoryRepository;

    @Autowired
    CompanyConfigRepository companyRepository;

    @Autowired
    CategoryValidator categoryValidator;

    @GetMapping("/categories")
    public String index(Model model) {
        CategoryPopupForm form = new CategoryPopupForm();
        model.addAttribute("categories", categoryRepository.findByParentNull(Sort.by(Sort.Direction.DESC, "level")));
        model.addAttribute("popupForm", form);
        model.addAttribute("categoryForm", new Category());
        return "category_list";
    }

    @PostMapping("/categories/store")
    public String store(@ModelAttribute("categoryForm") Category categoryForm, BindingResult bindingResult) {
        categoryValidator.validate(categoryForm, bindingResult);
        if (bindingResult.hasErrors()) {
            return "redirect:/categories";
        }
        categoryRepository.save(categoryForm);
        return "redirect:/categories";
    }

    @PostMapping("/categories/set_popup")
    @ResponseBody
    public Map<String, String> setPopup(@ModelAttribute("popupForm") CategoryPopupForm form, Principal principal) {
        Map<String, String> resultMap = new HashMap<>();
//        List<Company> companies = companyRepository.findAll();
//        if (companies.size() > 0) {
//            Company company = companies.get(0);
//            CompanySetting companySetting = company.getCompanySetting();
//            companySetting.setCategoryPopup(form.getPopup());
//            companySettingRepository.save(companySetting);
//        }
        resultMap.put("message", "Success");
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

    @PostMapping("/categories/update")
    @ResponseBody
    public Map<String, String> update(Category category) {
        categoryRepository.save(category);
        Map<String, String> resultMap = new HashMap<>();
        resultMap.put("message", "Success");
        resultMap.put("result_code", "00");
        return resultMap;
    }

    @PostMapping("/categories/delete")
    @ResponseBody
    public Map<String, String> delete(@RequestParam("id") Long id) {
        Optional<Category> optionalCategory = categoryRepository.findById(id);
        if (optionalCategory.isPresent()) {
            Category category = optionalCategory.get();
            Set<Category> children = category.getChildren();
            for (Category child : children) {
                categoryRepository.delete(child);
            }
            categoryRepository.deleteAll(children);
            categoryRepository.delete(category);
        }
        Map<String, String> resultMap = new HashMap<>();
        resultMap.put("message", "Success");
        resultMap.put("result_code", "00");
        return resultMap;
    }

    @PostMapping("/categories/update_fixed_rate")
    @ResponseBody
    public Map<String, String> updateFixedRate(@RequestParam("id")Long id, @RequestParam("usedIndividual") boolean usedIndividual) {
        Optional<Category> optionalCategory = categoryRepository.findById(id);
        if (optionalCategory.isPresent()) {
            Category category = optionalCategory.get();
            category.setUsedIndividual(usedIndividual);
            categoryRepository.save(category);
        }
        Map<String, String> resultMap = new HashMap<>();
        resultMap.put("message", "Success");
        resultMap.put("result_code", "00");
        return resultMap;
    }

    @GetMapping("/categories/sub_categories")
    @ResponseBody
    public Map<String, Object> getSubCategories(@RequestParam("id") Long id) {
        Optional<Category> optionalCategory = categoryRepository.findById(id);
        Map<String, Object> resultMap = new HashMap<>();
        if (optionalCategory.isPresent()) {
            Category category = optionalCategory.get();
            Set<Category> subCategories = category.getChildren();
            resultMap.put("listdata", subCategories);
        }
        resultMap.put("result_code", "00");
        return resultMap;
    }

    @PostMapping("/categories/add_category")
    @ResponseBody
    public Map<String, Object> addCategory(Category category) {
        Category dbCategory = categoryRepository.save(category);
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("category", dbCategory);
        resultMap.put("result_code", "00");
        return resultMap;
    }

    @GetMapping("/categories/all")
    @ResponseBody
    public Map<String, Object> getCategories() {
        Map<String, Object> resultMap = new HashMap<>();
        List<Category> categories = categoryRepository.findByParentNull();
        resultMap.put("categories", categories);
        return resultMap;
    }
}
