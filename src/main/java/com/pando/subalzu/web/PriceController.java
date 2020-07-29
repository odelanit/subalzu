package com.pando.subalzu.web;

import com.pando.subalzu.form.PriceUpdateForm;
import com.pando.subalzu.form.ProductSearchForm;
import com.pando.subalzu.model.*;
import com.pando.subalzu.repository.*;
import com.pando.subalzu.specification.ProductSpecification;
import com.pando.subalzu.specification.SearchCriteria;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Controller
@RequestMapping("/prices")
public class PriceController {

    @Autowired
    CompanyRepository companyRepository;

    @Autowired
    CompanySettingRepository companySettingRepository;

    @Autowired
    PriceGroupRepository priceGroupRepository;

    @Autowired
    ProductRepository productRepository;

    @Autowired
    CategoryRepository categoryRepository;

    @ModelAttribute("categories")
    List<Category> categories() {
        return categoryRepository.findByParentNull(Sort.by(Sort.Direction.DESC, "level"));
    }

    @GetMapping("")
    public String index(@ModelAttribute("form") ProductSearchForm form, Model model) {
        String field = form.getField();
        String keyword = form.getKeyword();
        Category category = form.getCategory();
        int page = form.getPage();

        Page<Product> productPage;
        Specification<Product> spec = new ProductSpecification(new SearchCriteria(field, ":", keyword));

        if (category != null) {
            List<Category> subcategories = categoryRepository.findByParent(category);
            model.addAttribute("subcategories", subcategories);
            spec = Specification.where(spec).and(new ProductSpecification(new SearchCriteria("category", ":", category)));

            Category subcategory = form.getSubcategory();
            if (subcategory != null) {
                spec = Specification.where(spec).and(new ProductSpecification(new SearchCriteria("subCategory", ":", subcategory)));
            }
        } else {
            form.setSubcategory(null);
        }

        Pageable pageable = PageRequest.of(page - 1, 50);
        productPage = productRepository.findAll(spec, pageable);
        List<Product> products = productPage.getContent();

        model.addAttribute("productPage", productPage);
        model.addAttribute("products", products);
        model.addAttribute("currentPage", page);

        return "price_list";
    }

    @ModelAttribute("priceGroups")
    public List<PriceGroup> priceGroupList() {
        return priceGroupRepository.findAll();
    }

    @GetMapping("/prices/fixed-price-rate")
    public String fixedRate(Principal principal, Model model) {
        Optional<Company> optionalCompany = companyRepository.findByUserUsername(principal.getName());
        if (optionalCompany.isPresent()) {
            Company company = optionalCompany.get();
            CompanySetting companySetting = company.getCompanySetting();
            if (companySetting == null) {
                return "redirect:/company";
            }
            boolean fixedRateSetting = companySetting.getFixedPriceRate();
            model.addAttribute("fixedRateSetting", fixedRateSetting);
            return "price_fixed_rate";
        } else {
            return "redirect:/company";
        }
    }

    @PostMapping("/prices/fixed-price-rate")
    public String updateRate(Principal principal, @RequestParam Map<String, String> formData) {
        Optional<Company> optionalCompany = companyRepository.findByUserUsername(principal.getName());
        if (optionalCompany.isPresent()) {
            Company company = optionalCompany.get();
            CompanySetting companySetting = company.getCompanySetting();
            boolean fixedRateSetting = Boolean.parseBoolean(formData.get("is_fixed"));
            companySetting.setFixedPriceRate(fixedRateSetting);
            companySettingRepository.save(companySetting);
            return "redirect:/prices";
        } else {
            return "redirect:/company";
        }
    }

    @PostMapping("/update")
    @ResponseBody
    public Map<String, String> updatePrice(PriceUpdateForm form) {
        Long productId = form.getProduct();
        Optional<Product> optionalProduct = productRepository.findById(productId);
        if (optionalProduct.isPresent()) {
            Product product = optionalProduct.get();
            product.setBuyPrice(form.getBuyPrice());
            product.setDirectPrice(form.getDirectPrice());
            product.setParcelPrice(form.getParcelPrice());
            product.setSellPrice(form.getSellPrice());
            productRepository.save(product);
        }
        Map<String, String> resultMap = new HashMap<>();
        resultMap.put("message", "단가 변경이 완료되었습니다.");
        return resultMap;
    }

    @PostMapping("/update_all")
    @ResponseBody
    public Map<String, String> updateAll(@RequestBody List<PriceUpdateForm> infos) {
        for (PriceUpdateForm form: infos) {
            Long productId = form.getProduct();
            Optional<Product> optionalProduct = productRepository.findById(productId);
            if (optionalProduct.isPresent()) {
                Product product = optionalProduct.get();
                product.setBuyPrice(form.getBuyPrice());
                product.setDirectPrice(form.getDirectPrice());
                product.setParcelPrice(form.getParcelPrice());
                product.setSellPrice(form.getSellPrice());
                productRepository.save(product);
            }
        }
        Map<String, String> resultMap = new HashMap<>();
        resultMap.put("message", "단가 변경이 완료되었습니다.");
        return resultMap;
    }
}
