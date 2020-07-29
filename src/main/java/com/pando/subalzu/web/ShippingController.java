package com.pando.subalzu.web;

import com.google.common.base.Strings;
import com.pando.subalzu.form.ShippingSearchForm;
import com.pando.subalzu.model.*;
import com.pando.subalzu.repository.*;
import com.pando.subalzu.specification.ProductRecordSpecification;
import com.pando.subalzu.specification.SearchCriteria;
import com.pando.subalzu.specification.SupplyOrderSpecification;
import com.pando.subalzu.validator.ShippingValidator;
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

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Controller
@RequestMapping("/shipping")
public class ShippingController {

    private static final String ALPHA_NUMERIC_STRING = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

    @Autowired
    SupplierRepository supplierRepository;

    @Autowired
    ProductRepository productRepository;

    @Autowired
    UserRepository userRepository;

    @Autowired
    SupplyOrderRepository supplyOrderRepository;

    @Autowired
    ShippingProductRepository shippingProductRepository;

    @Autowired
    ShippingValidator shippingValidator;

    @Autowired
    private SupplierTransactionRepository supplierTransactionRepository;

    public String randomAlphaNumeric(int count) {
        StringBuilder builder = new StringBuilder();
        while (count-- != 0) {
            int character = (int)(Math.random()*ALPHA_NUMERIC_STRING.length());
            builder.append(ALPHA_NUMERIC_STRING.charAt(character));
        }
        return builder.toString();
    }

    @GetMapping("")
    public String index(@ModelAttribute("form")ShippingSearchForm form, Model model) {
        String field = form.getField();
        String keyword = form.getKeyword();
        String strDateFrom = form.getDateFrom();
        String strDateTo = form.getDateTo();
        int page = form.getPage();

        Page<SupplyOrder> orderPage;
        Specification<SupplyOrder> spec = new SupplyOrderSpecification(new SearchCriteria(field, ":", keyword));

        if (!Strings.isNullOrEmpty(strDateFrom) && !Strings.isNullOrEmpty(strDateTo)) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDateTime dateFrom = LocalDate.parse(strDateFrom, formatter).atStartOfDay();
            LocalDateTime dateTo = LocalDate.parse(strDateTo, formatter).atTime(23, 59, 59);
            Pair<LocalDateTime, LocalDateTime> dateTimePair = Pair.of(dateFrom, dateTo);
            spec = Specification.where(spec).and(new SupplyOrderSpecification(new SearchCriteria("createdAt", "<>", dateTimePair)));
        }

        Pageable pageable = PageRequest.of(page - 1, 50, Sort.by("createdAt").descending());
        orderPage = supplyOrderRepository.findAll(spec, pageable);
        List<SupplyOrder> orders = orderPage.getContent();

        model.addAttribute("orderPage", orderPage);
        model.addAttribute("orders", orders);
        model.addAttribute("currentPage", page);
        model.addAttribute("localDateTimeFormat", DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss"));
        return "shipping_list";
    }

    @ModelAttribute("suppliers")
    public List<Supplier> suppliers() {
        return supplierRepository.findAll();
    }

    @ModelAttribute("employees")
    public List<User> employees() {
        return userRepository.findAll();
    }

    @GetMapping("/create")
    public String create(Model model) {
        SupplyOrder supplyOrder = new SupplyOrder();
        model.addAttribute("shippingForm", supplyOrder);
        return "shipping_create";
    }

    @PostMapping("/create")
    @ResponseBody
    public Map<String, String> store(@RequestBody Map<String, Object> requestMap) throws ParseException {
        Long supplierId = Long.parseLong((String) requestMap.get("supplier"));
        Long userId = Long.parseLong((String) requestMap.get("user")) ;
        String strDeliverBy = (String)requestMap.get("deliverBy");
        String description = (String)requestMap.get("description");
        Date deliverBy = new SimpleDateFormat("yyyy-MM-dd").parse(strDeliverBy);

        Optional<Supplier> optionalSupplier = supplierRepository.findById(supplierId);
        Optional<User> optionalUser = userRepository.findById(userId);
        if (optionalSupplier.isPresent() && optionalUser.isPresent()) {
            Supplier supplier = optionalSupplier.get();
            User user = optionalUser.get();
            SupplyOrder supplyOrder = new SupplyOrder();
            supplyOrder.setSupplier(supplier);
            supplyOrder.setUser(user);
            supplyOrder.setDeliverBy(deliverBy);
            supplyOrder.setDescription(description);
            supplyOrder.setOrderCode(randomAlphaNumeric(10));
            supplyOrder = supplyOrderRepository.save(supplyOrder);

            List<Map<String, Object>> orderProductMapList = (List<Map<String, Object>>) requestMap.get("supplyOrderProducts");

            long total = 0L;

            for (Map<String, Object> orderProductMap: orderProductMapList) {
                Long productId = Long.parseLong((String) orderProductMap.get("product"));
                int qty = Integer.parseInt((String) orderProductMap.get("qty"));
                Long price = Long.parseLong((String) orderProductMap.get("price"));
                long subTotal = Long.parseLong((String) orderProductMap.get("totalAmount"));

                total += subTotal;

                Optional<Product> optionalProduct = productRepository.findById(productId);

                if (optionalProduct.isPresent()) {
                    Product product = optionalProduct.get();
                    SupplyOrderProduct supplyOrderProduct = new SupplyOrderProduct();
                    supplyOrderProduct.setProduct(product);
                    supplyOrderProduct.setQty(qty);
                    supplyOrderProduct.setPrice(price);
                    supplyOrderProduct.setTotalAmount(subTotal);
                    supplyOrderProduct.setSupplyOrder(supplyOrder);
                    shippingProductRepository.save(supplyOrderProduct);
                }
            }

            supplyOrder.setTotalAmount(total);
            supplyOrderRepository.save(supplyOrder);

            SupplierTransaction transaction = new SupplierTransaction();
            transaction.setSupplier(supplier);
            transaction.setType("order");
            transaction.setMethod("manual_order");
            transaction.setAmount(total);
            transaction.setTotalAmount(supplierTransactionRepository.sumSupplierAmount(supplier) + total);
            transaction.setDescription(supplyOrder.getOrderCode() + " 발주 확정");
            supplierTransactionRepository.save(transaction);
        }

        Map<String, String> resultMap = new HashMap<>();
        resultMap.put("message", "Success");
        return resultMap;
    }
}
