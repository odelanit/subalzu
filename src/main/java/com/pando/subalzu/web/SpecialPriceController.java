package com.pando.subalzu.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class SpecialPriceController {
    @GetMapping("/special-prices")
    public String index() {
        return "special_price_list";
    }

    @GetMapping("/special-prices/{id}")
    public String edit(@PathVariable String id) {
        return "special_price_edit";
    }
}
