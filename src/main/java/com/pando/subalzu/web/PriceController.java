package com.pando.subalzu.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PriceController {
    @GetMapping("/prices")
    public String index() {
        return "price_list";
    }

    @GetMapping("/prices/flat-rate")
    public String flatRate() {
        return "/price_flat_rate";
    }
}
