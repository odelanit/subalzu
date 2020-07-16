package com.pando.subalzu.web;

import com.pando.subalzu.form.ProductSearchForm2;
import com.pando.subalzu.model.*;
import com.pando.subalzu.repository.*;
import com.pando.subalzu.specification.ProductSpecification;
import com.pando.subalzu.specification.SearchCriteria;
import com.pando.subalzu.validator.ProductValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Optional;

@Controller
public class ProductController {

    @Autowired
    CategoryRepository categoryRepository;

    @Autowired
    SupplierRepository supplierRepository;

    @Autowired
    ProductRepository productRepository;

    @Autowired
    PriceGroupRepository priceGroupRepository;

    @Autowired
    ProductGroupPriceRepository productGroupPriceRepository;

    @Autowired
    ProductValidator productValidator;

    @ModelAttribute("categories")
    List<Category> categories() {
        return categoryRepository.findByParentNull(Sort.by(Sort.Direction.DESC, "level"));
    }

    @ModelAttribute("suppliers")
    List<Supplier> suppliers() {
        return supplierRepository.findAll();
    }

    @ModelAttribute("priceGroups")
    List<PriceGroup> priceGroups() {
        return priceGroupRepository.findAll();
    }

    @GetMapping("/products")
    public String index(@ModelAttribute("form") ProductSearchForm2 form, Model model) {
        String field = form.getField();
        String keyword = form.getKeyword();
        int page = form.getPage();
        Page<Product> productPage;
        if (field != null && keyword != null) {
            ProductSpecification spec = new ProductSpecification(new SearchCriteria(field, ":", keyword));
            Pageable pageable = PageRequest.of(page - 1, 50);
            productPage = productRepository.findAll(spec, pageable);
        } else {
            Pageable pageable = PageRequest.of(page - 1, 50);
            productPage = productRepository.findAll(pageable);
        }
        List<Product> products = productPage.getContent();

        model.addAttribute("productPage", productPage);
        model.addAttribute("products", products);
        model.addAttribute("currentPage", page);
        return "product_list";
    }

    @GetMapping("/products/create")
    public String create(Model model) {
        model.addAttribute("productForm", new Product());
        return "product_create";
    }

    @PostMapping("/products/create")
    public String store(@ModelAttribute("productForm") Product productForm, BindingResult bindingResult, RedirectAttributes redirectAttributes) {
        productValidator.validate(productForm, bindingResult);
        if (bindingResult.hasErrors()) {
            return "product_create";
        }
        redirectAttributes.addFlashAttribute("message", "Product Added");
        Product product = productRepository.save(productForm);
        List<PriceGroup> priceGroups = priceGroupRepository.findAll();
        for (PriceGroup priceGroup : priceGroups) {
            ProductGroupPrice groupPrice = new ProductGroupPrice();
            groupPrice.setPrice(product.getBuyPrice());
            groupPrice.setProduct(product);
            groupPrice.setPriceGroup(priceGroup);
            productGroupPriceRepository.save(groupPrice);
        }
        return "redirect:/products";
    }

    @GetMapping("/products/{id}")
    public String edit(@PathVariable long id, Model model) {
        Optional<Product> optionalProduct = productRepository.findById(id);
        if (optionalProduct.isPresent()) {
            Product product = optionalProduct.get();

            model.addAttribute("productForm", product);
            return "product_edit";
        } else {
            return "redirect:/products";
        }
    }

    @PostMapping("/products/{id}")
    public String update(@PathVariable long id, Model model, @ModelAttribute("productForm")Product productForm, BindingResult bindingResult, RedirectAttributes redirectAttributes) {
        productValidator.validate(productForm, bindingResult);
        if (bindingResult.hasErrors()) {
            return "product_edit";
        }
        redirectAttributes.addFlashAttribute("message", "Product Updated");
        productRepository.save(productForm);
        return "redirect:/products";
    }
}
