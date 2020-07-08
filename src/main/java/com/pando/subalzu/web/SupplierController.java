package com.pando.subalzu.web;

import com.pando.subalzu.form.SupplierForm;
import com.pando.subalzu.model.Company;
import com.pando.subalzu.model.Supplier;
import com.pando.subalzu.model.User;
import com.pando.subalzu.repository.CompanyRepository;
import com.pando.subalzu.repository.SupplierDataRepository;
import com.pando.subalzu.repository.SupplierRepository;
import com.pando.subalzu.repository.UserRepository;
import com.pando.subalzu.validator.SupplierFormUpdateValidator;
import com.pando.subalzu.validator.SupplierFormValidator;
import com.pando.subalzu.validator.UserValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.datatables.mapping.DataTablesInput;
import org.springframework.data.jpa.datatables.mapping.DataTablesOutput;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.security.Principal;
import java.util.Optional;

@Controller
public class SupplierController {
    @Autowired
    CompanyRepository companyRepository;

    @Autowired
    SupplierRepository supplierRepository;

    @Autowired
    UserRepository userRepository;

    @Autowired
    SupplierFormValidator supplierFormValidator;

    @Autowired
    SupplierFormUpdateValidator supplierFormUpdateValidator;

    @Autowired
    UserValidator userValidator;

    @Autowired
    SupplierDataRepository supplierDataRepository;

    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    @GetMapping("/suppliers")
    public String index() {
        return "supplier_list";
    }

    @RequestMapping(value = "/data/suppliers", method = RequestMethod.POST)
    @ResponseBody
    public DataTablesOutput<Supplier> getSuppliers(@Valid @RequestBody DataTablesInput input) {
        return supplierDataRepository.findAll(input);
    }

    @GetMapping("/suppliers/create")
    public String create(Model model) {
        model.addAttribute("supplierForm", new SupplierForm(new Supplier(), new User()));
        model.addAttribute("page_title", "신규 매입처 등록");
        return "supplier_create";
    }

    @PostMapping("/suppliers/create")
    public String store(Principal principal, @ModelAttribute("supplierForm") SupplierForm supplierForm, BindingResult bindingResult, RedirectAttributes redirectAttributes) {
        supplierFormValidator.validate(supplierForm, bindingResult);
        if (bindingResult.hasErrors()) {
            return "supplier_create";
        }

        User user = supplierForm.getUser();
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        user = userRepository.save(user);

        Supplier supplier = supplierForm.getSupplier();
        Company company = companyRepository.findByUserUsername(principal.getName());
        supplier.setUser(user);
        supplierRepository.save(supplier);

        redirectAttributes.addFlashAttribute("message", "Supplier Created");
        return "redirect:/suppliers";
    }

    @GetMapping("/suppliers/{id}")
    public String edit(Model model, @PathVariable long id) {
        Optional<Supplier> supplierOptional = supplierRepository.findById(id);
        if (supplierOptional.isPresent()) {
            Supplier supplier = supplierOptional.get();
            User user = supplier.getUser();
            model.addAttribute("supplierForm", new SupplierForm(supplier, user));
            model.addAttribute("page_title", "매입처 수정");
            return "supplier_create";
        } else {
            return "redirect:/suppliers";
        }
    }

    @PostMapping("/suppliers/{id}")
    public String update(@ModelAttribute("supplierForm") SupplierForm supplierForm, BindingResult bindingResult, RedirectAttributes redirectAttributes, Model model, @PathVariable long id, Principal principal) {
        supplierFormUpdateValidator.validate(supplierForm, bindingResult);
        if (bindingResult.hasErrors()) {
            return "supplier_create";
        }

        User user = supplierForm.getUser();
        Optional<User> optionalUser = userRepository.findById(user.getId());
        User dbUser = optionalUser.get();
        String dbPassword = dbUser.getPassword();
        if (user.getPassword() != null && !user.getPassword().isEmpty()) {
            user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        } else {
            user.setPassword(dbPassword);
        }
        user = userRepository.save(user);

        Supplier supplier = supplierForm.getSupplier();
        supplier.setUser(user);
        supplierRepository.save(supplier);

        redirectAttributes.addFlashAttribute("message", "Supplier Updated");
        return "redirect:/suppliers";
    }
}
