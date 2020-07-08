package com.pando.subalzu.web;

import com.pando.subalzu.model.Category;
import com.pando.subalzu.model.Product;
import com.pando.subalzu.model.Supplier;
import com.pando.subalzu.repository.*;
import com.pando.subalzu.validator.ProductValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.datatables.mapping.DataTablesInput;
import org.springframework.data.jpa.datatables.mapping.DataTablesOutput;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
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
    ProductDataRepository productDataRepository;

    @Autowired
    PriceGroupRepository priceGroupRepository;

    @Autowired
    ProductValidator productValidator;

    @ModelAttribute("categories")
    List<Category> categories() {
        return categoryRepository.findAll();
    }

    @ModelAttribute("suppliers")
    List<Supplier> suppliers() {
        return supplierRepository.findAll();
    }

    @GetMapping("/products")
    public String index() {
        return "product_list";
    }

    @RequestMapping(value = "/data/products", method = RequestMethod.POST)
    @ResponseBody
    public DataTablesOutput<Product> dataUsers(@Valid @RequestBody DataTablesInput input) {
        return productDataRepository.findAll(input);
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
        productRepository.save(productForm);
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
