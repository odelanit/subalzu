package com.pando.subalzu.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CreditController {
    @GetMapping("/credits")
    public String index() {
        return "/credit_list";
    }
}
