package com.pando.subalzu.web;

import com.google.common.base.Strings;
import com.pando.subalzu.form.CompanyConfigForm;
import com.pando.subalzu.form.ShippingSearchForm;
import com.pando.subalzu.form.SupplyOrderForm;
import com.pando.subalzu.form.SupplyOrderProductForm;
import com.pando.subalzu.model.*;
import com.pando.subalzu.repository.*;
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
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
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
    SupplyOrderProductRepository supplyOrderProductRepository;

    @Autowired
    ProductRecordRepository productRecordRepository;

    @Autowired
    private CompanyConfigRepository configRepository;

    @Autowired
    ShippingValidator shippingValidator;

    @Autowired
    private SupplierTransactionRepository supplierTransactionRepository;

    public String randomAlphaNumeric(int count) {
        StringBuilder builder = new StringBuilder();
        while (count-- != 0) {
            int character = (int) (Math.random() * ALPHA_NUMERIC_STRING.length());
            builder.append(ALPHA_NUMERIC_STRING.charAt(character));
        }
        return builder.toString();
    }

    @GetMapping("")
    public String index(@ModelAttribute("form") ShippingSearchForm form, Model model) {
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
    public String create() {
        return "shipping_create_vue";
    }

    @PostMapping("/store")
    @ResponseBody
    public Map<String, String> store(@RequestBody SupplyOrderForm payload) {
        Long supplierId = payload.getSupplierId();
        String strDeliverBy = payload.getDeliverBy();
        Long salesmanId = payload.getSalesmanId();
        String description = payload.getDescription();

        Optional<Supplier> optionalSupplier = supplierRepository.findById(supplierId);
        Optional<User> optionalUser = userRepository.findById(salesmanId);

        if (optionalSupplier.isPresent() && optionalUser.isPresent()) {
            Supplier supplier = optionalSupplier.get();
            User user = optionalUser.get();
            SupplyOrder supplyOrder = new SupplyOrder();
            supplyOrder.setSupplier(supplier);
            supplyOrder.setUser(user);
            LocalDate deliverBy = LocalDate.parse(strDeliverBy, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            supplyOrder.setDeliverBy(deliverBy.atStartOfDay());
            supplyOrder.setDescription(description);
            supplyOrder.setOrderCode(randomAlphaNumeric(10));
            supplyOrder = supplyOrderRepository.save(supplyOrder);

            Set<SupplyOrderProductForm> orderProductFormSet = payload.getOrderProducts();

            for (SupplyOrderProductForm orderProductForm : orderProductFormSet) {
                Long productId = orderProductForm.getProductId();
                double qty = orderProductForm.getQty();
                Long price = orderProductForm.getPrice();

                Optional<Product> optionalProduct = productRepository.findById(productId);

                if (optionalProduct.isPresent()) {
                    Product product = optionalProduct.get();
                    SupplyOrderProduct supplyOrderProduct = new SupplyOrderProduct();
                    supplyOrderProduct.setProduct(product);
                    supplyOrderProduct.setQty(qty);
                    supplyOrderProduct.setPrice(price);
                    supplyOrderProduct.setSupplyOrder(supplyOrder);
                    supplyOrderProductRepository.save(supplyOrderProduct);
                }
            }
        }

        Map<String, String> resultMap = new HashMap<>();
        resultMap.put("message", "Success");
        return resultMap;
    }

    @PostMapping("/order_complete")
    @ResponseBody
    public Map<String, String> complete(@RequestBody Map<String, String> requestMap, Principal principal) {
        Long id = Long.valueOf(requestMap.get("id"));
        Optional<SupplyOrder> optionalSupplyOrder = supplyOrderRepository.findById(id);
        if (optionalSupplyOrder.isPresent()) {
            SupplyOrder supplyOrder = optionalSupplyOrder.get();
            supplyOrder.setShippingStatus("completed");
            supplyOrderRepository.save(supplyOrder);

            Supplier supplier = supplyOrder.getSupplier();
            supplier.setDealtAt(LocalDateTime.now());
            supplierRepository.save(supplier);
        }
        Map<String, String> resultMap = new HashMap<>();
        resultMap.put("message", "Success");
        return resultMap;
    }

    @PostMapping("/input_complete")
    @ResponseBody
    public Map<String, String> inputComplete(@RequestBody Map<String, Long> requestMap, Principal principal) {
        Long id = requestMap.get("id");
        Optional<SupplyOrder> optionalSupplyOrder = supplyOrderRepository.findById(id);
        if (optionalSupplyOrder.isPresent()) {
            SupplyOrder supplyOrder = optionalSupplyOrder.get();
            Set<SupplyOrderProduct> supplyOrderProducts = supplyOrder.getSupplyOrderProducts();
            double total = 0L;
            for (SupplyOrderProduct supplyOrderProduct : supplyOrderProducts) {
                Product product = supplyOrderProduct.getProduct();
                double previousQty = product.getQty();
                product.setQty(previousQty + supplyOrderProduct.getQty());
                productRepository.save(product);

                ProductRecord productRecord = new ProductRecord();
                productRecord.setProduct(supplyOrderProduct.getProduct());
                productRecord.setQty(previousQty);
                productRecord.setDiff(supplyOrderProduct.getQty());
                productRecord.setAction("shipping_input");
                Optional<User> optionalUser = userRepository.findByUsername(principal.getName());
                optionalUser.ifPresent(productRecord::setUser);
                productRecord.setQty(previousQty);
                productRecordRepository.save(productRecord);

                total += supplyOrderProduct.getPrice() * supplyOrderProduct.getQty();
            }

            SupplierTransaction transaction = new SupplierTransaction();
            transaction.setSupplier(supplyOrder.getSupplier());
            transaction.setType("shipping");
            transaction.setMethod("manual_order");
            transaction.setAmount(total);
            Long prevSumTotal = supplierTransactionRepository.sumSupplierAmount(supplyOrder.getSupplier());
            if (prevSumTotal == null) prevSumTotal = 0L;
            transaction.setTotalAmount(prevSumTotal + total);
            transaction.setDescription(supplyOrder.getOrderCode() + " 발주 확정");
            supplierTransactionRepository.save(transaction);
            supplyOrder.setInputStatus("completed");
            supplyOrderRepository.save(supplyOrder);

            Supplier supplier = supplyOrder.getSupplier();
            supplier.setDealtAt(LocalDateTime.now());
            supplierRepository.save(supplier);
        }
        Map<String, String> resultMap = new HashMap<>();
        resultMap.put("message", "Success");
        return resultMap;
    }

    @GetMapping("/{id}")
    public String edit() {
        return "shipping_edit_vue";
    }

    @GetMapping("/{id}/delete")
    public String delete(@PathVariable Long id) {
        Optional<SupplyOrder> optionalSupplyOrder = supplyOrderRepository.findById(id);
        if (optionalSupplyOrder.isPresent()) {
            SupplyOrder supplyOrder = optionalSupplyOrder.get();
            supplyOrderRepository.delete(supplyOrder);
        }
        return "redirect:/shipping";
    }

    @PostMapping("/{id}")
    public String update(Model model, @PathVariable Long id, SupplyOrder shippingForm, BindingResult bindingResult) {
        shippingValidator.validate(shippingForm, bindingResult);
        Optional<SupplyOrder> optionalSupplyOrder = supplyOrderRepository.findById(id);
        if (optionalSupplyOrder.isPresent()) {
            if (bindingResult.hasErrors()) {
                model.addAttribute("shippingForm", optionalSupplyOrder.get());
                return "shipping_edit";
            }
            SupplyOrder supplyOrder = optionalSupplyOrder.get();
            supplyOrder.setSupplier(shippingForm.getSupplier());
            supplyOrder.setUser(shippingForm.getUser());
            supplyOrder.setDeliverBy(shippingForm.getDeliverBy());
            supplyOrder.setDescription(shippingForm.getDescription());
            supplyOrderRepository.save(supplyOrder);
        }
        return "redirect:/shipping";
    }

    @GetMapping("/{id}/data")
    @ResponseBody
    public Map<String, Object> getOrder(@PathVariable Long id) {
        Optional<SupplyOrder> optionalSupplyOrder = supplyOrderRepository.findById(id);
        Map<String, Object> resultMap = new HashMap<>();
        if (optionalSupplyOrder.isPresent()) {
            SupplyOrder supplyOrder = optionalSupplyOrder.get();
            resultMap.put("supplyOrder", supplyOrder);
        }
        resultMap.put("message", "Success");
        return resultMap;
    }

    @PostMapping("/update")
    @ResponseBody
    public Map<String, String> update(@RequestBody SupplyOrderForm payload) {
        Long orderId = payload.getId();
        String strDeliverBy = payload.getDeliverBy();
        Long salesmanId = payload.getSalesmanId();
        String description = payload.getDescription();
        Set<SupplyOrderProductForm> supplyOrderProductFormSet = payload.getOrderProducts();
        Optional<SupplyOrder> optionalSupplyOrder = supplyOrderRepository.findById(orderId);
        if (optionalSupplyOrder.isPresent()) {
            SupplyOrder supplyOrder = optionalSupplyOrder.get();
            supplyOrder.setDeliverBy(LocalDate.parse(strDeliverBy, DateTimeFormatter.ofPattern("yyyy-MM-dd")).atStartOfDay());
            Optional<User> optionalUser = userRepository.findById(salesmanId);
            optionalUser.ifPresent(supplyOrder::setUser);
            supplyOrder.setDescription(description);
            supplyOrderRepository.save(supplyOrder);
            Supplier supplier = supplyOrder.getSupplier();
            supplier.setDealtAt(LocalDateTime.now());
            supplierRepository.save(supplier);
            supplyOrderProductRepository.deleteAll(supplyOrder.getSupplyOrderProducts());

            Set<SupplyOrderProductForm> orderProductFormSet = payload.getOrderProducts();

            for (SupplyOrderProductForm orderProductForm : orderProductFormSet) {
                Long productId = orderProductForm.getProductId();
                double qty = orderProductForm.getQty();
                Long price = orderProductForm.getPrice();

                Optional<Product> optionalProduct = productRepository.findById(productId);

                if (optionalProduct.isPresent()) {
                    Product product = optionalProduct.get();
                    SupplyOrderProduct supplyOrderProduct = new SupplyOrderProduct();
                    supplyOrderProduct.setProduct(product);
                    supplyOrderProduct.setQty(qty);
                    supplyOrderProduct.setPrice(price);
                    supplyOrderProduct.setSupplyOrder(supplyOrder);
                    supplyOrderProductRepository.save(supplyOrderProduct);
                }
            }
        }
        Map<String, String> resultMap = new HashMap<>();
        resultMap.put("message", "Success");
        return resultMap;
    }

    @GetMapping("/print")
    public String printOrder(@RequestParam List<Long> ids, Model model) {
        List<SupplyOrder> orders = supplyOrderRepository.findAllById(ids);
        CompanyConfigForm configForm = new CompanyConfigForm();
        configForm.setConfigRepository(configRepository);
        model.addAttribute("orders", orders);
        model.addAttribute("currentCompany", configForm);
        model.addAttribute("localDateTimeFormat", DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        return "shipping_print";
    }
}
