package com.pando.subalzu.web;

import com.google.common.base.Strings;
import com.pando.subalzu.form.ProductSearchForm;
import com.pando.subalzu.form.SupplierSearchForm;
import com.pando.subalzu.model.*;
import com.pando.subalzu.repository.*;
import com.pando.subalzu.specification.SearchCriteria;
import com.pando.subalzu.specification.SupplierSpecification;
import com.pando.subalzu.validator.SupplierValidator;
import com.pando.subalzu.validator.UserValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.security.Principal;
import java.util.*;

@Controller
public class SupplierController {
    @Autowired
    CompanyConfigRepository companyRepository;

    @Autowired
    SupplierRepository supplierRepository;

    @Autowired
    RoleRepository roleRepository;

    @Autowired
    UserRepository userRepository;

    @Autowired
    SupplyOwnerRepository supplyOwnerRepository;

    @Autowired
    SupplierValidator supplierValidator;

    @Autowired
    UserValidator userValidator;

    @Autowired
    ProductRepository productRepository;

    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    @GetMapping("/suppliers")
    public String index(@ModelAttribute("form") SupplierSearchForm form, Model model) {
        String type = form.getType();
        String keyword = form.getKeyword();
        int page = form.getPage();
        Page<Supplier> supplierPage;
        if (type != null && keyword != null) {
            SupplierSpecification spec = new SupplierSpecification(new SearchCriteria(type, ":", keyword));
            Pageable pageable = PageRequest.of(page - 1, 50);
            supplierPage = supplierRepository.findAll(spec, pageable);
        } else {
            Pageable pageable = PageRequest.of(page - 1, 50);
            supplierPage = supplierRepository.findAll(pageable);
        }
        List<Supplier> suppliers = supplierPage.getContent();

        model.addAttribute("supplierPage", supplierPage);
        model.addAttribute("suppliers", suppliers);
        model.addAttribute("currentPage", page);
        return "supplier_list";
    }

    @GetMapping("/suppliers/data")
    @ResponseBody
    public Map<String, Object> getSuppliers() {
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("message", "Success");
        resultMap.put("suppliers", supplierRepository.findAll());
        return resultMap;
    }

    @ModelAttribute("productSearchForm")
    public ProductSearchForm productSearchForm() {
        return new ProductSearchForm();
    }

    @GetMapping("/suppliers/create")
    public String create(Model model) {
        model.addAttribute("supplierForm", new Supplier());
        model.addAttribute("page_title", "신규 매입처 등록");
        return "supplier_create";
    }

    @PostMapping("/suppliers/create")
    public String store(@ModelAttribute("supplierForm") Supplier supplierForm, BindingResult bindingResult, RedirectAttributes redirectAttributes) {
        supplierValidator.validate(supplierForm, bindingResult);
        if (bindingResult.hasErrors()) {
            return "supplier_create";
        }

        if (!Strings.isNullOrEmpty(supplierForm.getUsername())) {
            SupplyOwner owner = new SupplyOwner();
            owner.setUsername(supplierForm.getUsername());
            owner.setFullName(supplierForm.getFullName());
            owner.setPhone(supplierForm.getPhone());
            owner.setBio(supplierForm.getBio());
            owner.setPassword(bCryptPasswordEncoder.encode(supplierForm.getPassword()));
            SupplyOwner dbUser = supplyOwnerRepository.save(owner);

            supplierForm.setOwner(dbUser);
        }

        Supplier supplier = supplierRepository.save(supplierForm);

        if (supplierForm.getProducts() != null) {
            List<Product> products = new ArrayList<>(supplierForm.getProducts());
            for (Product product : products) {
                product.setSupplier(supplier);
                productRepository.save(product);
            }
        }

        redirectAttributes.addFlashAttribute("message", "Supplier Created");
        return "redirect:/suppliers";
    }

    @GetMapping("/suppliers/{id}")
    public String edit(Model model, @PathVariable long id) {
        Optional<Supplier> supplierOptional = supplierRepository.findById(id);
        if (supplierOptional.isPresent()) {
            Supplier supplier = supplierOptional.get();
            SupplyOwner owner = supplier.getOwner();
            if (owner != null) {
                supplier.setUsername(owner.getUsername());
                supplier.setFullName(owner.getFullName());
                supplier.setPhone(owner.getPhone());
                supplier.setBio(owner.getBio());
            }
            model.addAttribute("supplierForm", supplier);
            model.addAttribute("page_title", "매입처 수정");
            return "supplier_create";
        } else {
            return "redirect:/suppliers";
        }
    }

    @PostMapping("/suppliers/{id}")
    public String update(@ModelAttribute("supplierForm") Supplier supplierForm, BindingResult bindingResult, RedirectAttributes redirectAttributes, Model model, @PathVariable long id, Principal principal) {
        supplierValidator.validate(supplierForm, bindingResult);
        if (bindingResult.hasErrors()) {
            return "supplier_create";
        }

        SupplyOwner owner = supplierForm.getOwner();
        if (owner != null) {
            if (!Strings.isNullOrEmpty(supplierForm.getPassword())) {
                owner.setPassword(bCryptPasswordEncoder.encode(supplierForm.getPassword()));
            }
            supplyOwnerRepository.save(owner);
        } else {
            if (!Strings.isNullOrEmpty(supplierForm.getUsername())) {
                SupplyOwner newOwner = new SupplyOwner();
                newOwner.setUsername(supplierForm.getUsername());
                newOwner.setFullName(supplierForm.getFullName());
                newOwner.setPhone(supplierForm.getPhone());
                newOwner.setBio(supplierForm.getBio());
                newOwner.setPassword(bCryptPasswordEncoder.encode(supplierForm.getPassword()));

                SupplyOwner dbUser = supplyOwnerRepository.save(newOwner);

                supplierForm.setOwner(dbUser);
            }
        }

        Supplier supplier = supplierRepository.save(supplierForm);

        if (supplierForm.getProducts() != null) {
            List<Product> products = new ArrayList<>(supplierForm.getProducts());
            for (Product product : products) {
                product.setSupplier(supplier);
                productRepository.save(product);
            }
        }

        redirectAttributes.addFlashAttribute("message", "Supplier Updated");
        return "redirect:/suppliers";
    }

    @GetMapping("/suppliers/{id}/delete")
    public String delete(@PathVariable long id) {
        Optional<Supplier> supplierOptional = supplierRepository.findById(id);
        if (supplierOptional.isPresent()) {
            Supplier supplier = supplierOptional.get();
            supplierRepository.delete(supplier);
        }
        return "redirect:/suppliers";
    }
}
