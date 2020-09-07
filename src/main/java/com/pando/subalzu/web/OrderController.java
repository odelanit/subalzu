package com.pando.subalzu.web;

import com.google.common.base.Strings;
import com.pando.subalzu.form.*;
import com.pando.subalzu.model.*;
import com.pando.subalzu.repository.*;
import com.pando.subalzu.specification.OrderSpecification;
import com.pando.subalzu.specification.SearchCriteria;
import com.pando.subalzu.validator.OrderValidator;
import org.apache.commons.compress.utils.IOUtils;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
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

import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.security.Principal;
import java.text.ParseException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Controller
public class OrderController {

    private static final String ALPHA_NUMERIC_STRING = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

    @Autowired
    ShopRepository shopRepository;

    @Autowired
    UserRepository userRepository;

    @Autowired
    ProductRepository productRepository;

    @Autowired
    ProductRecordRepository productRecordRepository;

    @Autowired
    OrderRepository orderRepository;

    @Autowired
    OrderProductRepository orderProductRepository;

    @Autowired
    TransactionRepository transactionRepository;

    @Autowired
    CategoryRepository categoryRepository;

    @Autowired
    OrderValidator orderValidator;

    @Autowired
    private PriceGroupRepository priceGroupRepository;

    @Autowired
    private CompanyConfigRepository configRepository;

    @ModelAttribute("shops")
    List<Shop> shopList() {
        return shopRepository.findAll();
    }

    @ModelAttribute("deliverers")
    List<User> delivererList() {
        return userRepository.findByRoleName("deliverer");
    }

    @ModelAttribute("salesMans")
    List<User> salesManList() {
        return userRepository.findByRoleName("sales");
    }

    @ModelAttribute("priceGroups")
    List<PriceGroup> priceGroupList() {
        return priceGroupRepository.findAll();
    }

    @ModelAttribute("products")
    List<Product> products() {
        return productRepository.findAll();
    }

    @ModelAttribute("categories")
    List<Category> categories() {
        return categoryRepository.findByParentNull(Sort.by("name"));
    }

    @GetMapping("/orders")
    public String index(@ModelAttribute("form")OrderSearchForm form, Model model) throws ParseException {
        String field = form.getField();
        String keyword = form.getKeyword();
        String deliveryType = form.getDeliveryType();
        String orderStatus = form.getOrderStatus();
        String releaseStatus = form.getReleaseStatus();
        String dateField = form.getDateField();
        String strDateFrom = form.getDateFrom();
        String strDateTo = form.getDateTo();
        User deliverer = form.getDeliverer();
        User salesman = form.getSalesman();
        int page = form.getPage();

        Page<Order> orderPage;
        Specification<Order> spec = new OrderSpecification(new SearchCriteria(field, ":", keyword));
        if (!Strings.isNullOrEmpty(deliveryType)) {
            spec = Specification.where(spec).and(new OrderSpecification(new SearchCriteria("deliveryType", ":", deliveryType)));
        }
        if (!Strings.isNullOrEmpty(orderStatus)) {
            spec = Specification.where(spec).and(new OrderSpecification(new SearchCriteria("orderStatus", ":", orderStatus)));
        }
        if (!Strings.isNullOrEmpty(releaseStatus)) {
            spec = Specification.where(spec).and(new OrderSpecification(new SearchCriteria("releaseStatus", ":", releaseStatus)));
        }
        if (deliverer != null) {
            spec = Specification.where(spec).and(new OrderSpecification(new SearchCriteria("deliverer", ":", deliverer)));
        }
        if (salesman != null) {
            spec = Specification.where(spec).and(new OrderSpecification(new SearchCriteria("salesMan", ":", salesman)));
        }
        if (!Strings.isNullOrEmpty(strDateFrom) && !Strings.isNullOrEmpty(strDateTo)) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDateTime dateFrom = LocalDate.parse(strDateFrom, formatter).atStartOfDay();
            LocalDateTime dateTo = LocalDate.parse(strDateTo, formatter).atTime(23, 59, 59);
            Pair<LocalDateTime, LocalDateTime> dateTimePair = Pair.of(dateFrom, dateTo);
            spec = Specification.where(spec).and(new OrderSpecification(new SearchCriteria(dateField, "<>", dateTimePair)));
        }
        Pageable pageable = PageRequest.of(page - 1, 50, Sort.by("createdAt").descending());
        orderPage = orderRepository.findAll(spec, pageable);
        List<Order> orders = orderPage.getContent();

        model.addAttribute("orderPage", orderPage);
        model.addAttribute("orders", orders);
        model.addAttribute("currentPage", page);
        model.addAttribute("localDateTimeFormat", DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss"));
        model.addAttribute("localDateTimeFormat2", DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        return "order_list";
    }

    @GetMapping("/orders/create")
    public String create() {
        return "order_create_vue";
    }

    public String randomAlphaNumeric(int count) {
        StringBuilder builder = new StringBuilder();
        while (count-- != 0) {
            int character = (int)(Math.random()*ALPHA_NUMERIC_STRING.length());
            builder.append(ALPHA_NUMERIC_STRING.charAt(character));
        }
        return builder.toString();
    }

    @PostMapping(value = "/orders/store")
    @ResponseBody
    public Map<String, String> store(@RequestBody OrderForm formData, HttpServletResponse response) {
        Order order = new Order();
        order.setOrderCode(randomAlphaNumeric(10));
        Long shopId = formData.getShopId();
        Optional<Shop> optionalShop = shopRepository.findById(shopId);
        if (optionalShop.isPresent()) {
            Shop shop = optionalShop.get();
            order.setShop(shop);
            order.setDeliveryType(formData.getDeliveryType());
            order.setRequestDate(formData.getRequestDate());
            Optional<User> optionalDeliverer = userRepository.findById(formData.getDelivererId());
            optionalDeliverer.ifPresent(order::setDeliverer);
            if (formData.getSalesmanId() != null) {
                Optional<User> optionalSalesman = userRepository.findById(formData.getSalesmanId());
                optionalSalesman.ifPresent(order::setSalesMan);
            }
            order.setRequestMemo(formData.getRequestMemo());
            order.setMemo(formData.getMemo());
            order = orderRepository.save(order);

            shop.setDealtAt(LocalDateTime.now());
            shopRepository.save(shop);

            Set<OrderProductForm> orderProductFormSet = formData.getOrderProducts();
            double total = 0.0;

            for (OrderProductForm orderProductForm : orderProductFormSet) {
                OrderProduct orderProduct = new OrderProduct();
                orderProduct.setOrder(order);
                Long productId = orderProductForm.getProductId();
                Optional<Product> optionalProduct = productRepository.findById(productId);
                if (optionalProduct.isPresent()) {
                    Product product = optionalProduct.get();
                    orderProduct.setProduct(product);
                    orderProduct.setQty(orderProductForm.getQty());
                    orderProduct.setPrice(orderProductForm.getPrice());
                    orderProductRepository.save(orderProduct);
                }
                total += orderProductForm.getQty() * orderProductForm.getPrice();
            }

            Transaction transaction = new Transaction();
            transaction.setShop(shop);
            transaction.setTransactionType("sale");
            transaction.setProcessingMethod("order_minus");
            transaction.setFunds(total);
            Double prevTotal = transactionRepository.sumShopAmount(shop);
            if (prevTotal == null) prevTotal = 0.0;
            transaction.setTotalFunds(prevTotal + total);
            transaction.setDescription(order.getOrderCode() + " 주문 완료");
            transactionRepository.save(transaction);
        }

        Map<String, String> resultMap = new HashMap<>();
        resultMap.put("message", "Success");
        return resultMap;
    }

    @PostMapping(value = "/orders/return_store")
    @ResponseBody
    public Map<String, String> returnStore(@RequestBody OrderForm formData, Principal principal, HttpServletResponse response) {
        Order order = new Order();
        order.setOrderCode(randomAlphaNumeric(10));
        Long shopId = formData.getShopId();
        Optional<Shop> optionalShop = shopRepository.findById(shopId);
        if (optionalShop.isPresent()) {
            Shop shop = optionalShop.get();
            order.setShop(shop);
            order.setDeliveryType(formData.getDeliveryType());
            Optional<User> optionalDeliverer = userRepository.findById(formData.getDelivererId());
            optionalDeliverer.ifPresent(order::setDeliverer);
            if (formData.getSalesmanId() != null) {
                Optional<User> optionalSalesman = userRepository.findById(formData.getSalesmanId());
                optionalSalesman.ifPresent(order::setSalesMan);
            }
            order.setMemo(formData.getMemo());
            order.setReturnStatus("completed");
            order.setReturnedAt(LocalDateTime.now());
            order = orderRepository.save(order);

            shop.setDealtAt(LocalDateTime.now());
            shopRepository.save(shop);

            Set<OrderProductForm> orderProductFormSet = formData.getOrderProducts();
            double total = 0.0;
            for (OrderProductForm orderProductForm : orderProductFormSet) {
                OrderProduct orderProduct = new OrderProduct();
                orderProduct.setOrder(order);
                Long productId = orderProductForm.getProductId();
                Optional<Product> optionalProduct = productRepository.findById(productId);
                optionalProduct.ifPresent(orderProduct::setProduct);
                orderProduct.setQty(0.0);
                orderProduct.setReQty(orderProductForm.getQty());
                orderProduct.setPrice(orderProductForm.getPrice());
                orderProduct = orderProductRepository.save(orderProduct);
                total += orderProductForm.getQty() * orderProductForm.getPrice();

                Product product = orderProduct.getProduct();

                ProductRecord productRecord = new ProductRecord();
                productRecord.setAction("return_output");
                productRecord.setProduct(orderProduct.getProduct());
                productRecord.setDiff(-orderProduct.getReQty());
                productRecord.setQty(product.getQty() - orderProduct.getReQty());
                Optional<User> optionalUser = userRepository.findByUsername(principal.getName());
                optionalUser.ifPresent(productRecord::setUser);
                productRecordRepository.save(productRecord);

                product.setQty(product.getQty() - orderProduct.getReQty());
                productRepository.save(product);
            }

            Transaction transaction = new Transaction();
            transaction.setShop(shop);
            transaction.setTransactionType("sale");
            transaction.setProcessingMethod("order_minus");
            transaction.setFunds(-total);
            Double prevTotal = transactionRepository.sumShopAmount(shop);
            if (prevTotal == null) prevTotal = 0.0;
            transaction.setTotalFunds(prevTotal - total);
            transaction.setDescription(order.getOrderCode() + " 반품 완료");
            transactionRepository.save(transaction);
        }

        Map<String, String> resultMap = new HashMap<>();
        resultMap.put("message", "Success");
        return resultMap;
    }

    @GetMapping("/orders/{id}")
    public String show(@PathVariable Long id, Model model) {
        Optional<Order> optionalOrder = orderRepository.findById(id);
        if (optionalOrder.isPresent()) {
            return "order_edit_vue";
        }
        return "redirect:/orders";
    }

    @GetMapping("/orders/{id}/ajax")
    @ResponseBody
    public Map<String, Object> getOrder(@PathVariable Long id) {
        Map<String, Object> resultMap = new HashMap<>();
        Optional<Order> optionalOrder = orderRepository.findById(id);
        if (optionalOrder.isPresent()) {
            Order order = optionalOrder.get();
            resultMap.put("order", order);
        }
        return resultMap;
    }

    @PostMapping(value = "/orders/update")
    @ResponseBody
    public Map<String, String> update(@RequestBody OrderForm formData, HttpServletResponse response) {
        Long orderId = formData.getId();
        Optional<Order> optionalOrder = orderRepository.findById(orderId);
        if (optionalOrder.isPresent()) {
            Order order = optionalOrder.get();
            order.setRequestDate(formData.getRequestDate());
            Optional<User> optionalDeliverer = userRepository.findById(formData.getDelivererId());
            optionalDeliverer.ifPresent(order::setDeliverer);
            if (formData.getSalesmanId() != null) {
                Optional<User> optionalSalesman = userRepository.findById(formData.getSalesmanId());
                optionalSalesman.ifPresent(order::setSalesMan);
            }
            order.setOrderStatus("modified");
            order.setMemo(formData.getMemo());
            order = orderRepository.save(order);

            double funds = order.getFunds();
            orderProductRepository.deleteAll(order.getOrderProducts());

            Set<OrderProductForm> orderProductFormSet = formData.getOrderProducts();
            double total = 0.0;
            for (OrderProductForm orderProductForm : orderProductFormSet) {
                OrderProduct orderProduct = new OrderProduct();
                orderProduct.setOrder(order);
                Long productId = orderProductForm.getProductId();
                Optional<Product> optionalProduct = productRepository.findById(productId);
                optionalProduct.ifPresent(orderProduct::setProduct);
                orderProduct.setQty(orderProductForm.getQty());
                orderProduct.setPrice(orderProductForm.getPrice());
                orderProductRepository.save(orderProduct);
                total += orderProductForm.getQty() * orderProductForm.getPrice();
            }

            Transaction transaction = new Transaction();
            transaction.setShop(order.getShop());
            transaction.setTransactionType("sale");
            transaction.setProcessingMethod("modify_minus");
            transaction.setFunds(total - funds);
            transaction.setTotalFunds(transactionRepository.sumShopAmount(order.getShop()) + total - funds);
            transaction.setDescription(order.getOrderCode() + " 주문 변경");
            transactionRepository.save(transaction);

            order.getShop().setDealtAt(LocalDateTime.now());
            shopRepository.save(order.getShop());
        }

        Map<String, String> resultMap = new HashMap<>();
        resultMap.put("message", "Success");
        return resultMap;
    }

    @PostMapping("/orders/receive_return")
    @ResponseBody
    public Map<String, String> createReturn(@RequestBody OrderReturnFom formData, Principal principal) {
        Long orderId = formData.getId();
        Optional<Order> optionalOrder = orderRepository.findById(orderId);
        if (optionalOrder.isPresent()) {
            Order order = optionalOrder.get();
            order.setReturnStatus("progress");
            order.setReturnedAt(LocalDateTime.now());
            order = orderRepository.save(order);
            Set<OrderProduct> orderProducts = order.getOrderProducts();
            orderProductRepository.deleteAll(orderProducts);
            Set<OrderProductForm> orderProductsData = formData.getOrderProducts();
            double funds = 0.0;
            for (OrderProductForm orderProductForm : orderProductsData) {
                OrderProduct orderProduct = new OrderProduct();
                orderProduct.setOrder(order);
                Long productId = orderProductForm.getProductId();
                Optional<Product> optionalProduct = productRepository.findById(productId);
                optionalProduct.ifPresent(orderProduct::setProduct);
                orderProduct.setQty(orderProductForm.getQty());
                orderProduct.setReQty(orderProductForm.getReQty());
                orderProduct.setPrice(orderProductForm.getPrice());
                funds += orderProductForm.getReQty() * orderProductForm.getPrice();
            }

            Transaction transaction = new Transaction();
            transaction.setShop(order.getShop());
            transaction.setTransactionType("sale");
            transaction.setProcessingMethod("return_plus");
            transaction.setFunds(-funds);
            transaction.setTotalFunds(transactionRepository.sumShopAmount(order.getShop()) - funds);
            transaction.setDescription(order.getOrderCode() + " 반품 접수");
            transactionRepository.save(transaction);
        }
        Map<String, String> resultMap = new HashMap<>();
        resultMap.put("message", "Success");
        return resultMap;
    }

    @GetMapping("/orders/{id}/cancel")
    public String cancel(@PathVariable Long id, Model model) {
        Optional<Order> optionalOrder = orderRepository.findById(id);
        if (optionalOrder.isPresent()) {
            Order order = optionalOrder.get();
            order.setOrderStatus("canceled");
            orderRepository.save(order);
            return "redirect:/orders/" + order.getId();
        }
        return "redirect:/orders";
    }

    @PostMapping("/orders/{id}/return_complete")
    @ResponseBody
    public Map<String, String> completeReturn(@PathVariable Long id, Principal principal) {
        Optional<Order> optionalOrder = orderRepository.findById(id);
        Map<String, String> resultMap = new HashMap<>();
        if (optionalOrder.isPresent()) {
            Order order = optionalOrder.get();
            order.setReturnStatus("completed");
            orderRepository.save(order);

            Set<OrderProduct> orderProducts = order.getOrderProducts();
            for (OrderProduct orderProduct : orderProducts) {
                if (orderProduct.getReQty() > 0) {
                    Product product = orderProduct.getProduct();

                    ProductRecord productRecord = new ProductRecord();
                    productRecord.setAction("return_output");
                    productRecord.setProduct(orderProduct.getProduct());
                    productRecord.setDiff(-orderProduct.getReQty());

                    productRecord.setQty(product.getQty() - orderProduct.getReQty());
                    Optional<User> optionalUser = userRepository.findByUsername(principal.getName());
                    optionalUser.ifPresent(productRecord::setUser);
                    productRecordRepository.save(productRecord);


                    product.setQty(product.getQty() - orderProduct.getReQty());
                    productRepository.save(product);
                }
            }
            resultMap.put("message", "Success");
        }
        return resultMap;
    }

    @GetMapping("/orders/transaction-details")
    public String transactionDetails() {
        return "/transaction_details";
    }

    @GetMapping("/orders/release")
    public String release() {
        return "/order_release";
    }

    @GetMapping("/returns")
    public String returnedOrders() {
        return "return_orders";
    }

    ByteArrayInputStream orderListToExcelFile(List<Order> orders) {
        try(Workbook workbook = new XSSFWorkbook()) {
            Sheet sheet = workbook.createSheet("orders");

            Row row = sheet.createRow(0);
            CellStyle headerCellStyle = workbook.createCellStyle();
            headerCellStyle.setFillForegroundColor(IndexedColors.AQUA.getIndex());
            headerCellStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            // Creating header
            Cell cell = row.createCell(0);
            cell.setCellValue("#");
            cell.setCellStyle(headerCellStyle);

            cell = row.createCell(1);
            cell.setCellValue("주문일시");
            cell.setCellStyle(headerCellStyle);

            cell = row.createCell(2);
            cell.setCellValue("배송요청일");
            cell.setCellStyle(headerCellStyle);

            cell = row.createCell(3);
            cell.setCellValue("주문번호");
            cell.setCellStyle(headerCellStyle);

            cell = row.createCell(4);
            cell.setCellValue("거래처");
            cell.setCellStyle(headerCellStyle);

            cell = row.createCell(5);
            cell.setCellValue("배송유형");
            cell.setCellStyle(headerCellStyle);

            cell = row.createCell(6);
            cell.setCellValue("총 주문수량");
            cell.setCellStyle(headerCellStyle);

            cell = row.createCell(7);
            cell.setCellValue("결제수단");
            cell.setCellStyle(headerCellStyle);

            cell = row.createCell(8);
            cell.setCellValue("주문금액");
            cell.setCellStyle(headerCellStyle);

            cell = row.createCell(9);
            cell.setCellValue("주문상태");
            cell.setCellStyle(headerCellStyle);

            cell = row.createCell(10);
            cell.setCellValue("출고상태");
            cell.setCellStyle(headerCellStyle);

            cell = row.createCell(11);
            cell.setCellValue("영업담당자");
            cell.setCellStyle(headerCellStyle);

            cell = row.createCell(12);
            cell.setCellValue("배송담당자");
            cell.setCellStyle(headerCellStyle);

            // Creating data rows for each customer
            for(int i = 0; i < orders.size(); i++) {
                Row dataRow = sheet.createRow(i + 1);
                dataRow.createCell(0).setCellValue(i + 1);
                dataRow.createCell(1).setCellValue(orders.get(i).getCreatedAt().format(DateTimeFormatter.ofPattern("yy-MM-dd hh:mm:ss")));
                String strRequestDate = "";
                if (orders.get(i).getRequestDate() != null) {
                    strRequestDate = orders.get(i).getRequestDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                }
                dataRow.createCell(2).setCellValue(strRequestDate);
                dataRow.createCell(3).setCellValue(orders.get(i).getOrderCode());
                dataRow.createCell(4).setCellValue(orders.get(i).getShop().getName());
                if (orders.get(i).getDeliveryType().equalsIgnoreCase("direct")) {
                    dataRow.createCell(5).setCellValue("직배송");
                } else {
                    dataRow.createCell(5).setCellValue("택배배송");
                }
                dataRow.createCell(6).setCellValue(orders.get(i).getOrderProducts().size());
                if (orders.get(i).getShop().getPaymentMethod().equalsIgnoreCase("credit")) {
                    dataRow.createCell(7).setCellValue("외상거래");
                } else {
                    dataRow.createCell(7).setCellValue("예치금");
                }
                dataRow.createCell(8).setCellValue(orders.get(i).getFunds());
                String orderStatus = orders.get(i).getOrderStatus();
                if (orderStatus.equalsIgnoreCase("completed")) {
                    dataRow.createCell(9).setCellValue("주문완료");
                } else if (orderStatus.equalsIgnoreCase("modified")){
                    dataRow.createCell(9).setCellValue("주문변경");
                } else if (orderStatus.equalsIgnoreCase("canceled")){
                    dataRow.createCell(9).setCellValue("주문취소");
                } else {
                    dataRow.createCell(9).setCellValue("");
                }
                String releaseStatus = orders.get(i).getReleaseStatus();
                if (releaseStatus.equalsIgnoreCase("completed")) {
                    dataRow.createCell(10).setCellValue("출고완료");
                } else if (releaseStatus.equalsIgnoreCase("progress")){
                    dataRow.createCell(10).setCellValue("출고전");
                } else if (releaseStatus.equalsIgnoreCase("rejected")){
                    dataRow.createCell(10).setCellValue("출고거절");
                } else {
                    dataRow.createCell(10).setCellValue("");
                }
                if (orders.get(i).getSalesMan() != null) {
                    dataRow.createCell(11).setCellValue(orders.get(i).getSalesMan().getFullName());
                }
                dataRow.createCell(12).setCellValue(orders.get(i).getDeliverer().getFullName());
            }

            // Making size of column auto resize to fit with data
            sheet.autoSizeColumn(0);
            sheet.autoSizeColumn(1);
            sheet.autoSizeColumn(2);
            sheet.autoSizeColumn(3);
            sheet.autoSizeColumn(4);
            sheet.autoSizeColumn(5);
            sheet.autoSizeColumn(6);
            sheet.autoSizeColumn(7);
            sheet.autoSizeColumn(8);
            sheet.autoSizeColumn(9);
            sheet.autoSizeColumn(10);
            sheet.autoSizeColumn(11);
            sheet.autoSizeColumn(12);


            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
            workbook.write(outputStream);
            return new ByteArrayInputStream(outputStream.toByteArray());
        } catch (IOException exception) {
            exception.printStackTrace();
            return null;
        }
    }

    @GetMapping("/orders/history/download")
    public void excelOrderReport(HttpServletResponse response) throws IOException {
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss");
        LocalDateTime now = LocalDateTime.now();
        String fileName = URLEncoder.encode("주문내역_" + dtf.format(now) + ".xlsx", "UTF-8");

        List<Order> orders = orderRepository.findAll();
        response.setContentType("application/octet-stream");
        response.setHeader("Content-Disposition", "attachment;filename=" + fileName + ";");
        ByteArrayInputStream stream = orderListToExcelFile(orders);
        IOUtils.copy(stream, response.getOutputStream());
    }

    @GetMapping("/orders/{id}/delete")
    public String delete(@PathVariable Long id) {
        Optional<Order> optionalOrder = orderRepository.findById(id);
        optionalOrder.ifPresent(order -> {
            orderProductRepository.deleteAll(order.getOrderProducts());
            orderRepository.delete(order);
        });
        return "redirect:/orders";
    }

    @PostMapping("/orders/change_status")
    @ResponseBody
    public Map<String, String> changeStatus(@RequestBody Map<String, Object> payload, Principal principal) {
        Long id = Long.valueOf(payload.get("id").toString());
        String action = payload.get("action").toString();
        String status = payload.get("status").toString();
        Optional<Order> optionalOrder = orderRepository.findById(id);
        optionalOrder.ifPresent(order -> {
            if (action.equalsIgnoreCase("release")) {
                order.setReleaseStatus(status);
                orderRepository.save(order);

                Set<OrderProduct> orderProducts = order.getOrderProducts();
                for(OrderProduct orderProduct : orderProducts) {
                    Product product = orderProduct.getProduct();

                    ProductRecord productRecord = new ProductRecord();
                    productRecord.setAction("output");
                    productRecord.setProduct(product);
                    productRecord.setDiff(-orderProduct.getQty());
                    productRecord.setQty(product.getQty() - orderProduct.getQty());
                    Optional<User> optionalUser = userRepository.findByUsername(principal.getName());
                    optionalUser.ifPresent(productRecord::setUser);
                    productRecordRepository.save(productRecord);

                    product.setQty(product.getQty() - orderProduct.getQty());
                    productRepository.save(product);
                }
            }
        });
        Map<String, String> resultMap = new HashMap<>();
        resultMap.put("message", "Success");
        return resultMap;
    }

    @PostMapping("/orders/complete_release_all")
    @ResponseBody
    public Map<String, String> completeReleaseAll(@RequestBody List<String> ids) {
        for (String id: ids) {
            Optional<Order> optionalOrder = orderRepository.findById(Long.parseLong(id));
            optionalOrder.ifPresent(order -> {
                order.setReleaseStatus("completed");
                orderRepository.save(order);
            });
        }
        Map<String, String> resultMap = new HashMap<>();
        resultMap.put("message", "Success");
        return resultMap;
    }

    @GetMapping("/orders/print_order")
    public String printOrder(@RequestParam List<Long> ids, Model model) {
        List<Order> orders = orderRepository.findAllById(ids);
        CompanyConfigForm configForm = new CompanyConfigForm();
        configForm.setConfigRepository(configRepository);
        model.addAttribute("orders", orders);
        model.addAttribute("currentCompany", configForm);
        model.addAttribute("localDateTimeFormat", DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        return "orders_print";
    }

    @GetMapping("/orders/print_order_return")
    public String printOrderReturn(@RequestParam List<Long> ids, Model model) {
        List<Order> orders = orderRepository.findAllById(ids);
        model.addAttribute("orders", orders);
        model.addAttribute("localDateTimeFormat", DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        return "orders_print_return";
    }

    @GetMapping("/orders/print_release")
    public String printReleaseProducts(@RequestParam List<Long> ids, Model model) {
        List<Order> orders = orderRepository.findAllById(ids);
        double totalQty = 0;
        Set<OrderProduct> orderProductSet = new HashSet<>();
        List<Shop> shops = new ArrayList<>();
        for (Order order : orders) {
            Set<OrderProduct> orderProducts = order.getOrderProducts();
            if (shops.isEmpty()) {
                shops.add(order.getShop());
            } else {
                for (Shop shop : shops) {
                    if (shop.getId().equals(order.getShop().getId())) {
                        continue;
                    }
                    shops.add(order.getShop());
                }
            }
            totalQty += order.getTotalQty();
            orderProductSet.addAll(orderProducts);
        }
        model.addAttribute("orderProducts", orderProductSet);
        model.addAttribute("totalQty", totalQty);
        model.addAttribute("shops", shops);
        model.addAttribute("localDateTimeFormat", DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        model.addAttribute("printDate", LocalDateTime.now());
        return "orders_print_release";
    }

    @GetMapping("/return_orders")
    public String returnOrders(@ModelAttribute("form")OrderSearchForm form, Model model) {
        String field = form.getField();
        String keyword = form.getKeyword();
        String strDateFrom = form.getDateFrom();
        String strDateTo = form.getDateTo();
        User deliverer = form.getDeliverer();
        int page = form.getPage();

        Page<Order> orderPage;
        Specification<Order> spec = new OrderSpecification(new SearchCriteria(field, ":", keyword));
        if (deliverer != null) {
            spec = Specification.where(spec).and(new OrderSpecification(new SearchCriteria("deliverer", ":", deliverer)));
        }
        if (!Strings.isNullOrEmpty(strDateFrom) && !Strings.isNullOrEmpty(strDateTo)) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDateTime dateFrom = LocalDate.parse(strDateFrom, formatter).atStartOfDay();
            LocalDateTime dateTo = LocalDate.parse(strDateTo, formatter).atTime(23, 59, 59);
            Pair<LocalDateTime, LocalDateTime> dateTimePair = Pair.of(dateFrom, dateTo);
            spec = Specification.where(spec).and(new OrderSpecification(new SearchCriteria("returnedAt", "<>", dateTimePair)));
        }
        Pageable pageable = PageRequest.of(page - 1, 50, Sort.by("returnedAt").descending());
        orderPage = orderRepository.findAll(spec, pageable);
        List<Order> orders = orderPage.getContent();

        model.addAttribute("orderPage", orderPage);
        model.addAttribute("orders", orders);
        model.addAttribute("currentPage", page);
        model.addAttribute("localDateTimeFormat", DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss"));
        return "return_orders";
    }

    @GetMapping("/return_orders/create")
    public String createReturnOrder() {
        return "return_order_create";
    }
}
