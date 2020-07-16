package com.pando.subalzu.web;

import com.pando.subalzu.model.Order;
import com.pando.subalzu.repository.NoticeRepository;
import com.pando.subalzu.repository.OrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.time.format.DateTimeFormatter;
import java.util.List;

@Controller
public class DashboardController {

    @Autowired
    NoticeRepository noticeRepository;

    @Autowired
    OrderRepository orderRepository;

    @GetMapping("/")
    public String index(Model model) {
        model.addAttribute("notices", noticeRepository.findAll());
        List<Order> orderList = orderRepository.findAll();

        model.addAttribute("orders", orderList);
        long totalAmount = 0;
        for (Order order: orderList) {
            totalAmount += order.getTotalAmount();
        }
        model.addAttribute("localDateTimeFormat", DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        model.addAttribute("totalAmount", totalAmount);
        return "index";
    }
}
