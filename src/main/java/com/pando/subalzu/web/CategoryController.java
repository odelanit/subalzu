package com.pando.subalzu.web;

import com.pando.subalzu.model.Category;
import com.pando.subalzu.repository.CategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class CategoryController {
    @Autowired
    CategoryRepository productCategoryRepository;

    @GetMapping("/categories")
    public String index(Model model) {
        model.addAttribute("categories", productCategoryRepository.findAll());
        return "category_list";
    }

    @PostMapping("/categories/store")
    public String store(@RequestParam("name") String name) {
        Category category = new Category(name);
        productCategoryRepository.save(category);
        return "redirect:/categories";
    }
}
