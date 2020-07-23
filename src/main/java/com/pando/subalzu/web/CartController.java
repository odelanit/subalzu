package com.pando.subalzu.web;

import com.pando.subalzu.model.CartItem;
import com.pando.subalzu.model.User;
import com.pando.subalzu.repository.CartItemRepository;
import com.pando.subalzu.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.security.Principal;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@Controller
public class CartController {

    @Autowired
    CartItemRepository cartItemRepository;

    @Autowired
    UserRepository userRepository;

    @GetMapping("/cart/all")
    @ResponseBody
    public Map<String, Object> index(Principal principal) {
        Optional<User> optionalUser = userRepository.findByUsername(principal.getName());
        Map<String, Object> resultMap = new HashMap<>();
        if (optionalUser.isPresent()) {
            User currentUser = optionalUser.get();
            resultMap.put("items", cartItemRepository.findByUser(currentUser));
        }
        resultMap.put("message", "Success");
        return resultMap;
    }

    @PostMapping("/cart/store")
    @ResponseBody
    public Map<String, Object> store(CartItem item, Principal principal) {
        Map<String, Object> resultMap = new HashMap<>();
        Optional<User> optionalUser = userRepository.findByUsername(principal.getName());
        if (optionalUser.isPresent()) {
            User currentUser = optionalUser.get();
            Optional<CartItem> optionalCartItem = cartItemRepository.findByUserAndProduct(currentUser, item.getProduct());
            if (optionalCartItem.isPresent()) {
                CartItem dbItem = optionalCartItem.get();
                dbItem.setQty(dbItem.getQty() + 1);
                dbItem = cartItemRepository.save(dbItem);
                resultMap.put("item", dbItem);
                resultMap.put("status", "updated");
            } else {
                item.setUser(currentUser);
                CartItem dbItem = cartItemRepository.save(item);
                resultMap.put("item", dbItem);
                resultMap.put("status", "created");
            }
        }
        resultMap.put("message", "Success");
        return resultMap;
    }

    @PostMapping("/cart/delete")
    @ResponseBody
    public Map<String, String> delete(@RequestParam("id") Long id) {
        Map<String, String> resultMap = new HashMap<>();
        Optional<CartItem> optionalCartItem = cartItemRepository.findById(id);
        optionalCartItem.ifPresent(cartItem -> cartItemRepository.delete(cartItem));
        resultMap.put("message", "Success");
        return resultMap;
    }

    @PostMapping("/cart/update")
    @ResponseBody
    public Map<String, Object> update(@RequestParam("id") Long id, String action) {
        Map<String, Object> resultMap = new HashMap<>();
        Optional<CartItem> optionalCartItem = cartItemRepository.findById(id);
        optionalCartItem.ifPresent(cartItem -> {
            if (action.equalsIgnoreCase("plus")) {
                cartItem.setQty(cartItem.getQty() + 1);
            } else {
                if (cartItem.getQty() > 1) {
                    cartItem.setQty(cartItem.getQty() - 1);
                }
            }
            cartItem = cartItemRepository.save(cartItem);
            resultMap.put("item", cartItem);
        });
        resultMap.put("message", "Success");
        return resultMap;
    }

    @PostMapping("/cart/update_qty")
    @ResponseBody
    public Map<String, Object> updateQty(@RequestParam("id") Long id, int qty) {
        Map<String, Object> resultMap = new HashMap<>();
        Optional<CartItem> optionalCartItem = cartItemRepository.findById(id);
        optionalCartItem.ifPresent(cartItem -> {
            cartItem.setQty(qty);
            cartItem = cartItemRepository.save(cartItem);
            resultMap.put("item", cartItem);
        });
        resultMap.put("message", "Success");
        return resultMap;
    }

    @PostMapping("/cart/update_price")
    @ResponseBody
    public Map<String, Object> updatePrice(@RequestParam("id") Long id, Long price) {
        Map<String, Object> resultMap = new HashMap<>();
        Optional<CartItem> optionalCartItem = cartItemRepository.findById(id);
        optionalCartItem.ifPresent(cartItem -> {
            cartItem.setPrice(price);
            cartItem = cartItemRepository.save(cartItem);
            resultMap.put("item", cartItem);
        });
        resultMap.put("message", "Success");
        return resultMap;
    }

    @PostMapping("/cart/reset")
    @ResponseBody
    public Map<String, String> reset() {
        cartItemRepository.deleteAll();
        Map<String, String> resultMap = new HashMap<>();
        resultMap.put("message", "Success");
        return resultMap;
    }
}
