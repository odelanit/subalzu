package com.pando.subalzu.web;

import com.pando.subalzu.model.Notification;
import com.pando.subalzu.repository.CompanyRepository;
import com.pando.subalzu.repository.NotificationRepository;
import com.pando.subalzu.validator.NotificationValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import java.time.format.DateTimeFormatter;

@Controller
public class NotificationController {
    @Autowired
    NotificationRepository notificationRepository;

    @Autowired
    NotificationValidator notificationValidator;

    @GetMapping("/notifications")
    public String index(Model model) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        model.addAttribute("notifications", notificationRepository.findAll());
        model.addAttribute("formatter", formatter);
        return "notification_list";
    }

    @GetMapping("/notifications/create")
    public String create(Model model) {
        model.addAttribute("notificationForm", new Notification());
        return "/notification_create";
    }

    @PostMapping("/notifications/create")
    public String store(@ModelAttribute("notificationForm") Notification notificationForm, BindingResult bindingResult) {
        notificationValidator.validate(notificationForm, bindingResult);

        if (bindingResult.hasErrors()) {
            return "/notification_create";
        }

        notificationRepository.save(notificationForm);

        return "redirect:/notifications";
    }

    @GetMapping("/notifications/{id}/delete")
    public String delete(@PathVariable(value = "id") long id) {
        notificationRepository.deleteById(id);
        return "redirect:/notifications";
    }
}
