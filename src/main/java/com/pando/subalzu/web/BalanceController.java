package com.pando.subalzu.web;

import com.pando.subalzu.form.SupplierSearchForm;
import com.pando.subalzu.model.Balance;
import com.pando.subalzu.model.Supplier;
import com.pando.subalzu.repository.BalanceRepository;
import com.pando.subalzu.repository.SupplierRepository;
import com.pando.subalzu.specification.SearchCriteria;
import com.pando.subalzu.specification.SupplierSpecification;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Controller
public class BalanceController {

    @Autowired
    SupplierRepository supplierRepository;

    @Autowired
    BalanceRepository balanceRepository;

    @GetMapping("/balance")
    public String index(@ModelAttribute("form")SupplierSearchForm form, Model model) {
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

        return "balance_list";
    }

    @GetMapping("/balance/{id}")
    public String show(@PathVariable Long id, Model model) {
        Optional<Supplier> optionalSupplier = supplierRepository.findById(id);
        if (optionalSupplier.isPresent()) {
            model.addAttribute("supplier", optionalSupplier.get());
            model.addAttribute("localDateTimeFormat", DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            model.addAttribute("form", new Balance(optionalSupplier.get()));
            model.addAttribute("balances", optionalSupplier.get().getBalances());
            return "balance_show";
        } else {
            return "redirect:/balance";
        }
    }

    @PostMapping("/balance/add")
    @ResponseBody
    public Map<String, String> store(@ModelAttribute("form") Balance balance) {
        balanceRepository.save(balance);
        Map<String, String> resultMap = new HashMap<>();
        resultMap.put("message", "Success");
        return resultMap;
    }
}
