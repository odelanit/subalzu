package com.pando.subalzu.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class BlankPageController {

    @GetMapping("/blank")
    public String index() {
        return "blank";
    }
}
