package com.pando.subalzu.web;

import com.google.common.base.Strings;
import com.pando.subalzu.form.SupplierSearchForm;
import com.pando.subalzu.form.SupplierTransactionSearch;
import com.pando.subalzu.model.Supplier;
import com.pando.subalzu.model.SupplierTransaction;
import com.pando.subalzu.repository.SupplierRepository;
import com.pando.subalzu.repository.SupplierTransactionRepository;
import com.pando.subalzu.specification.SearchCriteria;
import com.pando.subalzu.specification.SupplierSpecification;
import com.pando.subalzu.specification.SupplierTransactionSpecification;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.util.Pair;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
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
    SupplierTransactionRepository transactionRepository;

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
        model.addAttribute("localDateTimeFormat", DateTimeFormatter.ofPattern("yyyy-MM-dd"));

        model.addAttribute("sumPrevBalance", supplierRepository.sumPrevTotal());
        model.addAttribute("sumOrderAmount", transactionRepository.sumOrderAmount());
        model.addAttribute("sumUpdateAmount", transactionRepository.sumUpdateAmount());
        model.addAttribute("sumOutputAmount", transactionRepository.sumOutputAmount());
        model.addAttribute("sumAmount", transactionRepository.sumAmount());

        return "balance_list";
    }

    @GetMapping("/balance/{id}")
    public String show(@PathVariable Long id, @ModelAttribute("searchForm") SupplierTransactionSearch searchForm, Model model) {
        Optional<Supplier> optionalSupplier = supplierRepository.findById(id);
        if (optionalSupplier.isPresent()) {
            Supplier supplier = optionalSupplier.get();
            String type = searchForm.getType();
            String method = searchForm.getMethod();
            String strDateFrom = searchForm.getDateFrom();
            String strDateTo = searchForm.getDateTo();
            int page = searchForm.getPage();

            Specification<SupplierTransaction> spec = new SupplierTransactionSpecification(new SearchCriteria("supplier", ":", supplier));

            if (!Strings.isNullOrEmpty(type)) {
                spec = Specification.where(spec).and(new SupplierTransactionSpecification(new SearchCriteria("type", ":", type)));
            }
            if (!Strings.isNullOrEmpty(method)) {
                spec = Specification.where(spec).and(new SupplierTransactionSpecification(new SearchCriteria("method", ":", method)));
            }
            if (!Strings.isNullOrEmpty(strDateFrom) && !Strings.isNullOrEmpty(strDateTo)) {
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                LocalDateTime dateFrom = LocalDate.parse(strDateFrom, formatter).atStartOfDay();
                LocalDateTime dateTo = LocalDate.parse(strDateTo, formatter).atTime(23, 59, 59);
                Pair<LocalDateTime, LocalDateTime> dateTimePair = Pair.of(dateFrom, dateTo);
                spec = Specification.where(spec).and(new SupplierTransactionSpecification(new SearchCriteria("createdAt", "<>", dateTimePair)));
            }
            Pageable pageable = PageRequest.of(page - 1, 50, Sort.by("createdAt").descending());
            Page<SupplierTransaction> transactionPage = transactionRepository.findAll(spec, pageable);
            List<SupplierTransaction> transactions = transactionPage.getContent();

            model.addAttribute("supplier", optionalSupplier.get());
            model.addAttribute("localDateTimeFormat", DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            SupplierTransaction form1 = new SupplierTransaction(supplier);
            SupplierTransaction form2 = new SupplierTransaction(supplier);
            form1.setType("output");
            form1.setMethod("direct_minus");
            form2.setType("update");
            form2.setMethod("fund_minus");
            model.addAttribute("form1", form1);
            model.addAttribute("form2", form2);

            model.addAttribute("transactionPage", transactionPage);
            model.addAttribute("transactions", transactions);
            model.addAttribute("currentPage", page);

            return "balance_show";
        } else {
            return "redirect:/balance";
        }
    }

    @PostMapping("/balance/add")
    @ResponseBody
    public Map<String, String> store(SupplierTransaction supplierTransaction) {
        String method = supplierTransaction.getMethod();
        if (method.contains("minus")) {
            supplierTransaction.setAmount(-supplierTransaction.getAmount());
        }
        Long prevTotal = supplierTransaction.getPrevTotal();
        supplierTransaction = transactionRepository.save(supplierTransaction);
        Supplier supplier = supplierTransaction.getSupplier();
        supplier.setDealtAt(LocalDateTime.now());
        supplier.setTotalPrevBalance(prevTotal);
        supplierRepository.save(supplier);
        Map<String, String> resultMap = new HashMap<>();
        resultMap.put("message", "Success");
        return resultMap;
    }
}
