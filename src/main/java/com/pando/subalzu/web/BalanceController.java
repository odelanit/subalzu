package com.pando.subalzu.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class BalanceController {
    @GetMapping("/balance")
    public String index() {
        return "balance_list";
    }

    @GetMapping("/balance/{id}")
    public String show(@PathVariable String id) {
        return "balance_show";
    }
}
