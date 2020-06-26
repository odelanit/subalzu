package com.pando.subalzu.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ProductController {
    @GetMapping("/products")
    public String index() {
        return "product_list";
    }

    @GetMapping("/products/create")
    public String create() {
        return "/product_create";
    }
}
