package com.pando.subalzu.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class StoreController {
    @GetMapping("/store")
    public String index() {
        return "store_inout";
    }

    @GetMapping("/store-history")
    public String history() {
        return "store_history";
    }

    @GetMapping("/store-status")
    public String status() {
        return "store_status";
    }
}
