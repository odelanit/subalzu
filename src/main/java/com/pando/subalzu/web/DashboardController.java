package com.pando.subalzu.web;

import com.pando.subalzu.model.Order;
import com.pando.subalzu.repository.NoticeRepository;
import com.pando.subalzu.repository.OrderRepository;
import com.pando.subalzu.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Controller
public class DashboardController {

    @Autowired
    NoticeRepository noticeRepository;

    @Autowired
    OrderRepository orderRepository;

    @Autowired
    ProductRepository productRepository;

    @GetMapping("/")
    public String index(Model model) {
        model.addAttribute("notices", noticeRepository.findAll());

        Long countOrderReleaseProgress = orderRepository.countByReleaseStatus("progress");
        Long countOrderReleaseCompleted = orderRepository.countByReleaseStatus("completed");
        Long countOrderReleaseCanceled = orderRepository.countByReleaseStatus("rejected");
        Long countQtyInsufficient = productRepository.countQtyInsufficient();
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime aDayAgo = now.minusDays(1);
        LocalDateTime aMonthAgo = now.minusMonths(1);
        List<Order> orders1 = orderRepository.findByCreatedAtBetween(aDayAgo, now);
        List<Order> orders30 = orderRepository.findByCreatedAtBetween(aMonthAgo, now);

        Long total1 = 0L;
        int countReturnOrder1 = 0;
        Long sumReturnAmount1 = 0L;
        for (Order order : orders1) {
            total1 += order.getTotalAmount();
            if (order.getReturnedAt() != null) {
                countReturnOrder1++;
                sumReturnAmount1 += order.getReturnAmount();
            }
        }

        Long total30 = 0L;
        int countReturnOrder30 = 0;
        Long sumReturnAmount30 = 0L;
        for (Order order: orders30) {
            total30 += order.getTotalAmount();
            if (order.getReturnedAt() != null) {
                countReturnOrder30++;
                sumReturnAmount30 += order.getReturnAmount();
            }
        }

        model.addAttribute("localDateTimeFormat", DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        model.addAttribute("countQtyInsufficient", countQtyInsufficient);
        model.addAttribute("countOrderReleaseProgress", countOrderReleaseProgress);
        model.addAttribute("countOrderReleaseCompleted", countOrderReleaseCompleted);
        model.addAttribute("countOrderReleaseCanceled", countOrderReleaseCanceled);
        model.addAttribute("orders1", orders1);
        model.addAttribute("total1", total1);
        model.addAttribute("countReturnOrder1", countReturnOrder1);
        model.addAttribute("sumReturnAmount1", sumReturnAmount1);
        model.addAttribute("orders30", orders30);
        model.addAttribute("total30", total30);
        model.addAttribute("countReturnOrder30", countReturnOrder30);
        model.addAttribute("sumReturnAmount30", sumReturnAmount30);
        return "index";
    }
}
