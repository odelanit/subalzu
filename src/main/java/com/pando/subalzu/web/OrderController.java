package com.pando.subalzu.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class OrderController {
    @GetMapping("/orders")
    public String index() {
        return "order_list";
    }

    @GetMapping("/orders/create")
    public String create() {
        return "/order_create";
    }

    @GetMapping("/orders/{id}")
    public String show(@PathVariable String id) {
        return "/order_show";
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
}
