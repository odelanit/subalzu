package com.pando.subalzu.web;

import com.pando.subalzu.form.SupplierForm;
import com.pando.subalzu.repository.SupplierRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

@Controller
public class SupplierController {
    @Autowired
    SupplierRepository supplierRepository;

    @GetMapping("/suppliers")
    public String index() {
        return "supplier_list";
    }

    @GetMapping("/suppliers/create")
    public String create(Model model) {
        model.addAttribute("supplierForm", new SupplierForm());
        return "/supplier_create";
    }

    @GetMapping("/suppliers/store")
    public String store(@ModelAttribute("supplierForm") SupplierForm supplierForm) {

        return "/supplier_create";
    }
}
