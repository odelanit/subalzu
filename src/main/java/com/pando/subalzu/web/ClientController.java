package com.pando.subalzu.web;

import com.pando.subalzu.model.Client;
import com.pando.subalzu.repository.ClientRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ClientController {
    @Autowired
    ClientRepository clientRepository;

    @GetMapping("/clients")
    public String index(Model model) {
        return "client_list";
    }

    @GetMapping("/clients/create")
    public String create(Model model) {
        model.addAttribute("clientForm", new Client());
        return "/client_create";
    }
}
