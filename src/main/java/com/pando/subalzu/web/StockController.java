package com.pando.subalzu.web;

import com.google.common.base.Strings;
import com.pando.subalzu.form.ProductSearchForm4;
import com.pando.subalzu.model.Category;
import com.pando.subalzu.model.Product;
import com.pando.subalzu.repository.CategoryRepository;
import com.pando.subalzu.repository.ProductRepository;
import com.pando.subalzu.specification.ProductSpecification;
import com.pando.subalzu.specification.SearchCriteria;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/stock_rest")
public class StockController {

    @Autowired
    CategoryRepository categoryRepository;

    @Autowired
    ProductRepository productRepository;

    @ModelAttribute("categories")
    List<Category> categories() {
        return categoryRepository.findByParentNull(Sort.by(Sort.Direction.DESC, "level"));
    }

    @GetMapping("")
    public String index(@ModelAttribute("form") ProductSearchForm4 form, Model model) {
        String field = form.getField();
        String keyword = form.getKeyword();
        String qtyStatus = form.getQtyStatus();
        int page = form.getPage();
        Page<Product> productPage;

        Specification<Product> spec = new ProductSpecification(new SearchCriteria(field, ":", keyword));
        if (!Strings.isNullOrEmpty(qtyStatus)) {
            if (qtyStatus.equalsIgnoreCase("1")) {
                spec = Specification.where(spec).and(new ProductSpecification(new SearchCriteria("qty", ">", 0.0)));
            } else {
                spec = Specification.where(spec).and(new ProductSpecification(new SearchCriteria("qty", "<", 0.0)));
            }
        }

        Category category = form.getCategory();
        if (category != null) {
            List<Category> subcategories = categoryRepository.findByParent(category);
            model.addAttribute("subcategories", subcategories);
            spec = Specification.where(spec).and(new ProductSpecification(new SearchCriteria("category", ":", category)));

            Category subcategory = form.getSubcategory();
            if (subcategory != null) {
                spec = Specification.where(spec).and(new ProductSpecification(new SearchCriteria("subCategory", ":", subcategory)));
            }
        } else {
            form.setSubcategory(null);
        }

        Pageable pageable = PageRequest.of(page - 1, 50);
        productPage = productRepository.findAll(spec, pageable);
        List<Product> products = productPage.getContent();

        model.addAttribute("productPage", productPage);
        model.addAttribute("products", products);
        model.addAttribute("currentPage", page);

        return "stock_list";
    }

}
