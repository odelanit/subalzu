package com.pando.subalzu.web;

import com.pando.subalzu.form.ProductSearchForm;
import com.pando.subalzu.form.ShopSearchForm2;
import com.pando.subalzu.model.Product;
import com.pando.subalzu.model.Shop;
import com.pando.subalzu.model.ShopProductPrice;
import com.pando.subalzu.repository.ProductRepository;
import com.pando.subalzu.repository.ShopProductPriceRepository;
import com.pando.subalzu.repository.ShopRepository;
import com.pando.subalzu.specification.ProductSpecification;
import com.pando.subalzu.specification.SearchCriteria;
import com.pando.subalzu.specification.ShopSpecification;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Controller
public class SpecialPriceController {

    @Autowired
    ShopRepository shopRepository;

    @Autowired
    ProductRepository productRepository;

    @Autowired
    ShopProductPriceRepository shopProductPriceRepository;

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
    public String edit(@PathVariable Long id, @ModelAttribute("form") ProductSearchForm form, Model model) {
        Optional<Shop> optionalShop = shopRepository.findById(id);
        if (optionalShop.isPresent()) {
            Shop shop = optionalShop.get();
            model.addAttribute("shop", shop);

            String field = form.getField();
            String keyword = form.getKeyword();
            int page = form.getPage();
            Page<Product> productPage;
            if (field != null && keyword != null) {
                ProductSpecification spec = new ProductSpecification(new SearchCriteria(field, ":", keyword));
                Pageable pageable = PageRequest.of(page - 1, 50);
                productPage = productRepository.findAll(spec, pageable);
            } else {
                Pageable pageable = PageRequest.of(page - 1, 50);
                productPage = productRepository.findAll(pageable);
            }
            List<Product> products = productPage.getContent();

            model.addAttribute("productPage", productPage);
            model.addAttribute("products", products);
            model.addAttribute("currentPage", page);

            return "special_price_edit";
        }
        return "redirect:/special-prices";
    }

    @PostMapping("/special-prices/apply")
    @ResponseBody
    public Map<String, String> applyPrice(ShopProductPrice shopProductPrice) {
        Map<String, String> resultMap = new HashMap<>();
        Optional<ShopProductPrice> optionalShopProductPrice = shopProductPriceRepository.findByShopAndProduct(shopProductPrice.getShop(), shopProductPrice.getProduct());
        if (optionalShopProductPrice.isPresent()) {
            shopProductPrice.setId(optionalShopProductPrice.get().getId());
            shopProductPriceRepository.save(shopProductPrice);
            resultMap.put("product", String.valueOf(optionalShopProductPrice.get().getId()));
        } else {
            ShopProductPrice dbPrice = shopProductPriceRepository.save(shopProductPrice);
            resultMap.put("product", String.valueOf(dbPrice.getId()));
        }
        resultMap.put("message", "Success");
        return resultMap;
    }

    @PostMapping("/special-prices/clear")
    @ResponseBody
    public Map<String, String> clearPrice(ShopProductPrice shopProductPrice) {
        Map<String, String> resultMap = new HashMap<>();
        Optional<ShopProductPrice> optionalShopProductPrice = shopProductPriceRepository.findByShopAndProduct(shopProductPrice.getShop(), shopProductPrice.getProduct());
        optionalShopProductPrice.ifPresent(productPrice -> shopProductPriceRepository.delete(productPrice));
        resultMap.put("message", "Success");
        return resultMap;
    }
}
