package com.pando.subalzu.web;

import com.google.common.base.Strings;
import com.pando.subalzu.form.ShopSearchForm4;
import com.pando.subalzu.form.TransactionSearchForm;
import com.pando.subalzu.model.Shop;
import com.pando.subalzu.model.Transaction;
import com.pando.subalzu.model.User;
import com.pando.subalzu.repository.ShopRepository;
import com.pando.subalzu.repository.TransactionRepository;
import com.pando.subalzu.service.UserDetailsImpl;
import com.pando.subalzu.specification.SearchCriteria;
import com.pando.subalzu.specification.ShopSpecification;
import com.pando.subalzu.specification.TransactionSpecification;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.util.Pair;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Controller
@RequestMapping("/credits")
public class CreditController {

    @Autowired
    ShopRepository shopRepository;

    @Autowired
    TransactionRepository transactionRepository;

    @Autowired
    UserDetailsService userDetailsService;

    @ModelAttribute("localDateTimeFormat")
    DateTimeFormatter localDateTimeFormat() {
        return DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss");
    }

    @GetMapping("")
    public String index(@ModelAttribute("form") ShopSearchForm4 form, Model model) {
        Page<Shop> shopPage;
        String field = form.getField();
        String keyword = form.getKeyword();
        String dateFrom = form.getDateFrom();
        String dateTo = form.getDateTo();
        String dealStatus = form.getDealStatus();
        String paymentMethod = form.getPaymentMethod();
        int page = form.getPage();

        Specification<Shop> spec = new ShopSpecification(new SearchCriteria(field, ":", keyword));
        if (!Strings.isNullOrEmpty(dealStatus)) {
            spec = Specification.where(spec).and(new ShopSpecification(new SearchCriteria("dealStatus", ":", Boolean.parseBoolean(dealStatus))));
        }
        if (!Strings.isNullOrEmpty(paymentMethod)) {
            spec = Specification.where(spec).and(new ShopSpecification(new SearchCriteria("paymentMethod", ":", paymentMethod)));
        }

        Pageable pageable = PageRequest.of(page - 1, 50);
        shopPage = shopRepository.findAll(spec, pageable);
        List<Shop> shops = shopPage.getContent();

        model.addAttribute("shopPage", shopPage);
        model.addAttribute("currentPage", page);
        model.addAttribute("shops", shops);
        model.addAttribute("localDateTimeFormat", DateTimeFormatter.ofPattern("yyyy-MM-dd"));

        model.addAttribute("sumPrevBalance", shopRepository.sumPrevTotal());
        model.addAttribute("sumAmount", transactionRepository.sumAmount());
        model.addAttribute("sumUpdateAmount", transactionRepository.sumUpdateAmount());
        model.addAttribute("sumInputAmount", transactionRepository.sumInputAmount());
//        model.addAttribute("sumTotalSales", shopRepository.sumTotalSales());

        return "credit_list";
    }

    @GetMapping("/{id}")
    public String show(@PathVariable Long id, @ModelAttribute("form") TransactionSearchForm form, Model model, Principal principal) {
        Optional<Shop> optionalShop = shopRepository.findById(id);
        if (optionalShop.isPresent()) {
            Shop shop = optionalShop.get();
            UserDetailsImpl userDetails = (UserDetailsImpl) userDetailsService.loadUserByUsername(principal.getName());
            if (userDetails.hasPermission("in_charge")) {
                User user = userDetails.getUser();
                Set<Shop> salesShops = user.getSalesShops();
                if (!salesShops.contains(shop)) {
                    return "redirect:/credits";
                }
            }
            String transactionType = form.getTransactionType();
            String processingMethod = form.getProcessingMethod();
            String strDateFrom = form.getDateFrom();
            String strDateTo = form.getDateTo();
            int page = form.getPage();

            Specification<Transaction> spec = new TransactionSpecification(new SearchCriteria("shop", ":", shop));
            if (!Strings.isNullOrEmpty(transactionType)) {
                spec = Specification.where(spec).and(new TransactionSpecification(new SearchCriteria("transactionType", ":", transactionType)));
            }
            if (!Strings.isNullOrEmpty(processingMethod)) {
                spec = Specification.where(spec).and(new TransactionSpecification(new SearchCriteria("processingMethod", ":", processingMethod)));
            }
            if (!Strings.isNullOrEmpty(strDateFrom) && !Strings.isNullOrEmpty(strDateTo)) {
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                LocalDateTime dateFrom = LocalDate.parse(strDateFrom, formatter).atStartOfDay();
                LocalDateTime dateTo = LocalDate.parse(strDateTo, formatter).atTime(23, 59, 59);
                Pair<LocalDateTime, LocalDateTime> dateTimePair = Pair.of(dateFrom, dateTo);
                spec = Specification.where(spec).and(new TransactionSpecification(new SearchCriteria("createdAt", "<>", dateTimePair)));
            }
            Pageable pageable = PageRequest.of(page - 1, 50, Sort.by("createdAt").descending());
            Page<Transaction> transactionPage = transactionRepository.findAll(spec, pageable);
            List<Transaction> transactions = transactionPage.getContent();

            Transaction transaction1 = new Transaction();
            transaction1.setTransactionType("input");
            transaction1.setProcessingMethod("manual_minus");
            transaction1.setShop(shop);

            Transaction transaction2 = new Transaction();
            transaction2.setTransactionType("update");
            transaction2.setProcessingMethod("fund_minus");
            transaction2.setShop(shop);

            model.addAttribute("shop", shop);
            model.addAttribute("transactionForm1", transaction1);
            model.addAttribute("transactionForm2", transaction2);
            model.addAttribute("transactionPage", transactionPage);
            model.addAttribute("transactions", transactions);
            model.addAttribute("currentPage", page);
            model.addAttribute("totalBalance", shop.getTotalBalance());
            return "credit_show";
        } else {
            return "redirect:/credits";
        }
    }

    @GetMapping("/{id}/download_excel")
    public String downloadExcel(@PathVariable Long id) {
        return "redirect:/credits/" + id;
    }

    @PostMapping("/store")
    @ResponseBody
    public Map<String, String> store(Transaction transaction) {
        Map<String, String> resultMap = new HashMap<>();
        String method = transaction.getProcessingMethod();
        if (method.contains("minus")) {
            transaction.setFunds(-transaction.getFunds());
        }
        Long prevTotal = transaction.getPrevTotal();
        transaction = transactionRepository.save(transaction);
        Shop shop = transaction.getShop();
        shop.setDealtAt(LocalDateTime.now());
        shop.setPrevTotalBalance(prevTotal);
        shopRepository.save(shop);
        resultMap.put("message", "처리 완료 되었습니다.");
        return resultMap;
    }
}
