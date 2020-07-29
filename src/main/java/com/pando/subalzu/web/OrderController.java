package com.pando.subalzu.web;

import com.google.common.base.Strings;
import com.pando.subalzu.form.OrderSearchForm;
import com.pando.subalzu.form.ProductSearchForm3;
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
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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
    CartItemRepository cartItemRepository;

    @Autowired
    OrderRepository orderRepository;

    @Autowired
    OrderProductRepository orderProductRepository;

    @Autowired
    TransactionRepository transactionRepository;

    @Autowired
    OrderValidator orderValidator;

    @Autowired
    private PriceGroupRepository priceGroupRepository;

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

    @GetMapping("/orders")
    public String index(@ModelAttribute("form")OrderSearchForm form, Model model) {
        String field = form.getField();
        String keyword = form.getKeyword();
        int page = form.getPage();
        Page<Order> orderPage;
        Specification<Order> spec = new OrderSpecification(new SearchCriteria(field, ":", keyword));
        String deliveryType = form.getDeliveryType();
        if (!Strings.isNullOrEmpty(deliveryType)) {
            spec = Specification.where(spec).and(new OrderSpecification(new SearchCriteria("deliveryType", ":", deliveryType)));
        }
        String orderStatus = form.getOrderStatus();
        if (!Strings.isNullOrEmpty(orderStatus)) {
            spec = Specification.where(spec).and(new OrderSpecification(new SearchCriteria("orderStatus", ":", orderStatus)));
        }
        String releaseStatus = form.getReleaseStatus();
        if (!Strings.isNullOrEmpty(releaseStatus)) {
            spec = Specification.where(spec).and(new OrderSpecification(new SearchCriteria("releaseStatus", ":", releaseStatus)));
        }
        User deliverer = form.getDeliverer();
        if (deliverer != null) {
            spec = Specification.where(spec).and(new OrderSpecification(new SearchCriteria("deliverer", ":", deliverer)));
        }
        User salesman = form.getSalesman();
        if (salesman != null) {
            spec = Specification.where(spec).and(new OrderSpecification(new SearchCriteria("salesMan", ":", salesman)));
        }
        Pageable pageable = PageRequest.of(page - 1, 50);
        orderPage = orderRepository.findAll(spec, pageable);
        List<Order> orders = orderPage.getContent();

        model.addAttribute("orderPage", orderPage);
        model.addAttribute("orders", orders);
        model.addAttribute("currentPage", page);
        model.addAttribute("localDateTimeFormat", DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        return "order_list";
    }

    @GetMapping("/orders/create")
    public String create(Model model) {
        model.addAttribute("orderForm", new Order());
        model.addAttribute("searchForm", new ProductSearchForm3());
        return "order_create";
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
    public Map<String, String> store(@RequestBody Map<String, Object> requestMap) throws ParseException {
        Long shopId = Long.parseLong((String) requestMap.get("shop"));
        String deliveryType = (String)requestMap.get("deliveryType");
        String strRequestDate = (String)requestMap.get("requestDate");
        Long delivererId = Long.parseLong((String) requestMap.get("deliverer")) ;
        Long salesmanId = Long.parseLong((String) requestMap.get("salesman")) ;
        String requestMemo = (String)requestMap.get("requestMemo");
        String memo = (String)requestMap.get("memo");

        Optional<Shop> optionalShop = shopRepository.findById(shopId);
        Optional<User> optionalDeliverer = userRepository.findById(delivererId);
        Optional<User> optionalSalesman = userRepository.findById(salesmanId);
        if (optionalShop.isPresent() && optionalDeliverer.isPresent()) {
            Shop shop = optionalShop.get();
            Order order = new Order();
            order.setShop(shop);
            order.setOrderCode(randomAlphaNumeric(10));
            order.setDeliveryType(deliveryType);
            if (!Strings.isNullOrEmpty(strRequestDate)) {
                Date requestDate = new SimpleDateFormat("yyyy-MM-dd").parse(strRequestDate);
                order.setRequestDate(requestDate);
            }
            order.setDeliverer(optionalDeliverer.get());
            optionalSalesman.ifPresent(order::setSalesMan);
            order.setRequestMemo(requestMemo);
            order.setMemo(memo);
            order = orderRepository.save(order);

            List<Map<String, Object>> orderProductMapList = (List<Map<String, Object>>) requestMap.get("products");

            long total = 0L;

            for (Map<String, Object> orderProductMap: orderProductMapList) {
                Long productId = ((Integer)orderProductMap.get("id")).longValue();
                int qty = (int) orderProductMap.get("qty");
                long price = ((Integer) orderProductMap.get("sellPrice")).longValue();
                long subTotal = qty * price;

                total += subTotal;

                Optional<Product> optionalProduct = productRepository.findById(productId);

                if (optionalProduct.isPresent()) {
                    Product product = optionalProduct.get();
                    OrderProduct orderProduct = new OrderProduct();
                    orderProduct.setProduct(product);
                    orderProduct.setQty(qty);
                    orderProduct.setPrice(price);
                    orderProduct.setTotalAmount(subTotal);
                    orderProduct.setOrder(order);
                    orderProductRepository.save(orderProduct);

                    ProductRecord productRecord = new ProductRecord();
                    productRecord.setProduct(product);
                    productRecord.setPreviousQty(product.getQty());
                    productRecord.setDiff(qty);
                    productRecord.setAction("order_output");
                    productRecordRepository.save(productRecord);

                    product.setQty(product.getQty() - qty);
                    productRepository.save(product);

                }
            }
            order.setTotalAmount(total);
            orderRepository.save(order);

            Transaction transaction = new Transaction();
            transaction.setShop(shop);
            transaction.setTransactionType("sale");
            transaction.setProcessingMethod("order_minus");
            transaction.setAmount(total);
            transaction.setTotalAmount(transactionRepository.sumShopAmount(shop));
            transaction.setDescription(order.getOrderCode() + " 주문 변경");
            transactionRepository.save(transaction);
        }

        Map<String, String> resultMap = new HashMap<>();
        requestMap.put("message", "Success");
        return resultMap;
    }

    @GetMapping("/orders/{id}")
    public String show(@PathVariable Long id, Model model) {
        Optional<Order> optionalOrder = orderRepository.findById(id);
        if (optionalOrder.isPresent()) {
            Order order = optionalOrder.get();
            model.addAttribute("order", order);
            return "order_show";
        }
        return "redirect:/orders";
    }

    @GetMapping("/orders/transaction-details")
    public String transactionDetails() {
        return "/transaction_details";
    }

    @GetMapping("/orders/release")
    public String release() {
        return "/order_release";
    }

    @GetMapping("/product-orders")
    public String ordersPerProduct() {
        return "orders_per_product";
    }

    @GetMapping("/returns")
    public String returnedOrders() {
        return "returned_orders";
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
                DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                String strRequestDate = "";
                if (orders.get(i).getRequestDate() != null) {
                    strRequestDate = dateFormat.format(orders.get(i).getRequestDate());
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
                dataRow.createCell(8).setCellValue(orders.get(i).getTotalAmount());
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

    @GetMapping("/orders/download/orders.xlsx")
    public void excelOrderReport(HttpServletResponse response) throws IOException {
        List<Order> orders = orderRepository.findAll();
        response.setContentType("application/octet-stream");
        response.setHeader("Content-Disposition", "attachment;filename=orders.xlsx");
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
    public Map<String, String> changeStatus(@RequestParam("id")Long id, @RequestParam("action")String action, @RequestParam("status")String status) {
        Optional<Order> optionalOrder = orderRepository.findById(id);
        optionalOrder.ifPresent(order -> {
            if (action.equalsIgnoreCase("release")) {
                order.setReleaseStatus(status);
                orderRepository.save(order);
            }
        });
        Map<String, String> resultMap = new HashMap<>();
        resultMap.put("message", "Success");
        return resultMap;
    }
}
