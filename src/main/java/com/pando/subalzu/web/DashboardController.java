package com.pando.subalzu.web;

import com.pando.subalzu.repository.NoticeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DashboardController {

    @Autowired
    NoticeRepository noticeRepository;

    @GetMapping("/")
    public String index(Model model) {
        model.addAttribute("notices", noticeRepository.findAll());
        return "index";
    }
}
