package com.pando.subalzu.web;

import com.pando.subalzu.model.PriceGroup;
import com.pando.subalzu.repository.PriceGroupRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.persistence.EntityNotFoundException;
import java.util.HashMap;
import java.util.Map;

@Controller
public class PriceGroupController {
    @Autowired
    PriceGroupRepository priceGroupRepository;

    @GetMapping("/price-groups")
    public String index(Model model) {
        model.addAttribute("priceGroupForm", new PriceGroup());
        model.addAttribute("priceGroups", priceGroupRepository.findAll());
        return "price_group_list";
    }

    @GetMapping("/price-groups/data")
    @ResponseBody
    public Map<String, Object> getPriceGroups() {
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("priceGroups", priceGroupRepository.findAll());
        return resultMap;
    }

    @PostMapping("/price-groups/store")
    public String store(@ModelAttribute("priceGroupForm") PriceGroup priceGroupForm, BindingResult bindingResult) {
        priceGroupRepository.save(priceGroupForm);
        return "redirect:/price-groups";
    }

    @PostMapping("/price-groups/{id}/update")
    public String update(@PathVariable(value = "id") long id, @RequestParam("name") String name) {
        PriceGroup priceGroup = priceGroupRepository.findById(id).orElseThrow(EntityNotFoundException::new);
        priceGroup.setName(name);
        priceGroupRepository.save(priceGroup);
        return "redirect:/price-groups";
    }

    @GetMapping("/price-groups/{id}/delete")
    public String delete(@PathVariable(value = "id") long id) {
        priceGroupRepository.deleteById(id);
        return "redirect:/price-groups";
    }
}
