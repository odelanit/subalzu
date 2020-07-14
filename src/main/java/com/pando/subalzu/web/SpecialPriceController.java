package com.pando.subalzu.web;

import com.pando.subalzu.form.ProductSearchForm;
import com.pando.subalzu.form.ShopSearchForm;
import com.pando.subalzu.form.ShopSearchForm2;
import com.pando.subalzu.form.UserSearchForm;
import com.pando.subalzu.model.Shop;
import com.pando.subalzu.model.User;
import com.pando.subalzu.repository.ShopRepository;
import com.pando.subalzu.specification.SearchCriteria;
import com.pando.subalzu.specification.ShopSpecification;
import com.pando.subalzu.specification.UserSpecification;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;
import java.util.Optional;

@Controller
public class SpecialPriceController {

    @Autowired
    ShopRepository shopRepository;

    @GetMapping("/special-prices")
    public String index(@ModelAttribute("form") ShopSearchForm2 form, Model model) {
        String field = form.getField();
        String keyword = form.getKeyword();
        int page = form.getPage();
        Page<Shop> shopPage;
        if (field != null && keyword != null) {
            ShopSpecification spec = new ShopSpecification(new SearchCriteria(field, ":", keyword));
            Pageable pageable = PageRequest.of(page - 1, 50);
            shopPage = shopRepository.findAll(spec, pageable);
        } else {
            Pageable pageable = PageRequest.of(page - 1, 50);
            shopPage = shopRepository.findAll(pageable);
        }
        List<Shop> shops = shopPage.getContent();

        model.addAttribute("shopPage", shopPage);
        model.addAttribute("shops", shops);
        model.addAttribute("currentPage", page);
        return "special_price_list";
    }

    @GetMapping("/special-prices/{id}")
    public String edit(@PathVariable Long id, Model model) {
        Optional<Shop> optionalShop = shopRepository.findById(id);
        if (optionalShop.isPresent()) {
            Shop shop = optionalShop.get();
            model.addAttribute("shop", shop);

            ProductSearchForm form = new ProductSearchForm();
            model.addAttribute("form", form);
            return "special_price_edit";
        }
        return "redirect:/special-prices";
    }
}
