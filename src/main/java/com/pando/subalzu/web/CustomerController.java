package com.pando.subalzu.web;

import com.pando.subalzu.model.ShopOwner;
import com.pando.subalzu.repository.ShopOwnerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@Controller
@RequestMapping("/customers")
public class CustomerController {
    @Autowired
    ShopOwnerRepository shopOwnerRepository;

    @PostMapping("/check_username")
    @ResponseBody
    public Map<String, String> checkUsername(@RequestParam("username") String username, HttpServletResponse response) {
        Optional<ShopOwner> optionalUser =  shopOwnerRepository.findByUsername(username);
        Map<String, String> resultMap = new HashMap<>();
        if (optionalUser.isPresent()) {
            response.setStatus(HttpServletResponse.SC_CONFLICT);
            resultMap.put("message", "Customer present");
        } else {
            resultMap.put("message", "Success");
        }
        return resultMap;
    }
}
