package com.pando.subalzu.web;

import com.google.common.base.Strings;
import com.pando.subalzu.form.SupplierSearchForm;
import com.pando.subalzu.model.Company;
import com.pando.subalzu.model.Role;
import com.pando.subalzu.model.Supplier;
import com.pando.subalzu.model.User;
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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.security.Principal;
import java.util.List;
import java.util.Optional;

@Controller
public class SupplierController {
    @Autowired
    CompanyRepository companyRepository;

    @Autowired
    SupplierRepository supplierRepository;

    @Autowired
    RoleRepository roleRepository;

    @Autowired
    UserRepository userRepository;

    @Autowired
    SupplierValidator supplierValidator;

    @Autowired
    UserValidator userValidator;

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
            User user = new User();
            user.setUsername(supplierForm.getUsername());
            user.setFullName(supplierForm.getFullName());
            user.setPhone(supplierForm.getPhone());
            user.setBio(supplierForm.getBio());
            user.setPassword(bCryptPasswordEncoder.encode(supplierForm.getPassword()));

            Role supplierRole = roleRepository.findByName("customer");
            user.setRole(supplierRole);

            User dbUser = userRepository.save(user);

            supplierForm.setUser(dbUser);
        }

        supplierRepository.save(supplierForm);

        redirectAttributes.addFlashAttribute("message", "Supplier Created");
        return "redirect:/suppliers";
    }

    @GetMapping("/suppliers/{id}")
    public String edit(Model model, @PathVariable long id) {
        Optional<Supplier> supplierOptional = supplierRepository.findById(id);
        if (supplierOptional.isPresent()) {
            Supplier supplier = supplierOptional.get();
            User user = supplier.getUser();
            if (user != null) {
                supplier.setUsername(user.getUsername());
                supplier.setFullName(user.getFullName());
                supplier.setPhone(user.getPhone());
                supplier.setBio(user.getBio());
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

        User user = supplierForm.getUser();
        if (user != null) {
            if (!Strings.isNullOrEmpty(supplierForm.getPassword())) {
                user.setPassword(bCryptPasswordEncoder.encode(supplierForm.getPassword()));
            }
            userRepository.save(user);
        } else {
            if (!Strings.isNullOrEmpty(supplierForm.getUsername())) {
                User newUser = new User();
                newUser.setUsername(supplierForm.getUsername());
                newUser.setFullName(supplierForm.getFullName());
                newUser.setPhone(supplierForm.getPhone());
                newUser.setBio(supplierForm.getBio());
                newUser.setPassword(bCryptPasswordEncoder.encode(supplierForm.getPassword()));

                Role supplierRole = roleRepository.findByName("customer");
                newUser.setRole(supplierRole);

                User dbUser = userRepository.save(newUser);

                supplierForm.setUser(dbUser);
            }
        }

        supplierRepository.save(supplierForm);

        redirectAttributes.addFlashAttribute("message", "Supplier Updated");
        return "redirect:/suppliers";
    }
}
