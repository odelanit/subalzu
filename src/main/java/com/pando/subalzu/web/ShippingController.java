package com.pando.subalzu.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ShippingController {
    @GetMapping("/shipping")
    public String index() {
        return "shipping_list";
    }

    @GetMapping("/shipping/create")
    public String create() {
        return "/shipping_create";
    }
}
