package com.pando.subalzu.web;

import com.pando.subalzu.form.ShopSearchForm3;
import com.pando.subalzu.model.*;
import com.pando.subalzu.repository.*;
import com.pando.subalzu.specification.SearchCriteria;
import com.pando.subalzu.specification.ShopSpecification;
import com.pando.subalzu.validator.ShopValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Controller
public class ShopController {
    @Autowired
    ShopRepository clientRepository;

    @Autowired
    BusinessRepository businessRepository;

    @Autowired
    UserRepository userRepository;

    @Autowired
    PriceGroupRepository priceGroupRepository;

    @Autowired
    ShopGradeRepository shopGradeRepository;

    @Autowired
    AssigneeTypeRepository assigneeTypeRepository;

    @Autowired
    ShopRepository shopRepository;

    @Autowired
    ShopValidator shopValidator;

    @Autowired
    BCryptPasswordEncoder bCryptPasswordEncoder;

    @Autowired
    private RoleRepository roleRepository;

    @Autowired
    private PermissionRepository permissionsRepository;

    @ModelAttribute("businesses")
    List<Business> businessList() {
        return businessRepository.findAll();
    }

    @ModelAttribute("deliverers")
    List<User> delivererList() {
        return userRepository.findByRoleName("deliverer");
    }

    @ModelAttribute("salesMans")
    List<User> salesManList() {
        return userRepository.findByRoleName("sales");
    }

    @ModelAttribute("priceGroups")
    List<PriceGroup> priceGroupList() {
        return priceGroupRepository.findAll();
    }

    @ModelAttribute("shopGrades")
    List<ShopGrade> shopGradeList() {
        return shopGradeRepository.findAll();
    }

    @ModelAttribute("assigneeTypes")
    List<AssigneeType> assigneeTypeList() {
        return assigneeTypeRepository.findAll();
    }

    @ModelAttribute("localDateTimeFormat")
    DateTimeFormatter localDateTimeFormat() {
        return DateTimeFormatter.ofPattern("yyyy-MM-dd");
    }

    @GetMapping("/shops")
    public String index(@ModelAttribute("form") ShopSearchForm3 form, Model model) {
        Page<Shop> shopPage;
        String field = form.getField();
        String keyword = form.getKeyword();
        String deliveryType = form.getDeliveryType();
        User deliverer = form.getDeliverer();
        User salesman = form.getDeliverer();
        String dealStatus = form.getDealStatus();
        int page = form.getPage();

        Pageable pageable = PageRequest.of(page - 1, 50);
        shopPage = shopRepository.findAll(pageable);
        List<Shop> shops = shopPage.getContent();

        model.addAttribute("shopPage", shopPage);
        model.addAttribute("currentPage", page);
        model.addAttribute("shops", shops);

        return "shop_list";
    }

    @PostMapping("/shops/get_shops")
    @ResponseBody
    public Map<String, Object> getShops(@RequestParam("keyword") String keyword) {
        Map<String, Object> resultMap = new HashMap<>();
        ShopSpecification spec = new ShopSpecification(new SearchCriteria("name", ":", keyword));
        List<Shop> shops = shopRepository.findAll(spec);
        resultMap.put("shops", shops);
        resultMap.put("message", "Success");
        return resultMap;
    }

    @GetMapping("/shops/create")
    public String create(Model model) {
        model.addAttribute("shopForm", new Shop());
        return "shop_create";
    }

    @PostMapping("/shops/create")
    public String store(@ModelAttribute("shopForm")Shop shopForm, BindingResult bindingResult, Model model) {
        shopValidator.validate(shopForm, bindingResult);
        if (bindingResult.hasErrors()) {
            return "shop_create";
        }

        Role customerRole = roleRepository.findByName("customer");
        Permission chargePermission = permissionsRepository.findByName("in_charge");
        String username = shopForm.getOwnerUsername();
        User user = new User();
        user.setFullName(shopForm.getOwnerFullname());
        user.setUsername(username);
        user.setPhone(shopForm.getOwnerPhone());
        user.setPassword(bCryptPasswordEncoder.encode(username));
        user.setRole(customerRole);
        user.setPermission(chargePermission);
        User savedUser = userRepository.save(user);
        shopForm.setOwner(savedUser);
        shopRepository.save(shopForm);
        model.addAttribute("success", true);
        return "shop_create";
    }

    @GetMapping("/shops/{id}/edit")
    public String edit(Model model, @PathVariable Long id) {
        Optional<Shop> optionalShop = shopRepository.findById(id);
        if (optionalShop.isPresent()) {
            Shop shop = optionalShop.get();
            shop.setOwnerUsername(shop.getOwner().getUsername());
            shop.setOwnerFullname(shop.getOwner().getFullName());
            shop.setOwnerPhone(shop.getOwner().getPhone());
            model.addAttribute("shopForm", shop);
            return "shop_edit";
        } else {
            return "redirect:/shops";
        }
    }

    @PostMapping("/shops/{id}/edit")
    public String update(@PathVariable Long id, @ModelAttribute("shopForm") Shop shopForm, BindingResult bindingResult, Model model, RedirectAttributes redirectAttributes) {
        Optional<Shop> optionalShop = shopRepository.findById(id);
        if (optionalShop.isPresent()) {
            shopValidator.validate(shopForm, bindingResult);
            if (bindingResult.hasErrors()) {
                return "shop_edit";
            }
            String ownerFullname = shopForm.getOwnerFullname();
            String ownerPhone = shopForm.getOwnerPhone();

            User owner = shopForm.getOwner();
            owner.setFullName(ownerFullname);
            owner.setPhone(ownerPhone);
            userRepository.save(owner);

            shopRepository.save(shopForm);
            redirectAttributes.addFlashAttribute("message", "Shop Updated");
        }
        return "redirect:/shops";
    }

    @PostMapping("/shops/update_status")
    @ResponseBody
    public Map<String, String> updateStatus(@RequestParam("id") Long id, @RequestParam("action") String action) {
        Optional<Shop> shopOptional = shopRepository.findById(id);
        if (shopOptional.isPresent()) {
            Shop shop = shopOptional.get();
            if (action.equalsIgnoreCase("stop")) {
                shop.setDealStatus(false);
                shop.setStoppedAt(LocalDateTime.now());
            } else if (action.equalsIgnoreCase("start")) {
                shop.setDealStatus(true);
                shop.setStoppedAt(null);
            }
            shopRepository.save(shop);
        }
        Map<String, String> resultMap = new HashMap<>();
        resultMap.put("message", "Success");
        return resultMap;
    }

    @PostMapping("/shops/reset_owner_password")
    @ResponseBody
    public Map<String, String> resetOwnerPassword(@RequestParam("id") Long id) {
        Optional<Shop> optionalShop = shopRepository.findById(id);
        if (optionalShop.isPresent()) {
            Shop shop = optionalShop.get();
            User owner = shop.getOwner();
            owner.setPassword(bCryptPasswordEncoder.encode(owner.getUsername()));
            userRepository.save(owner);
        }
        Map<String, String> resultMap = new HashMap<>();
        resultMap.put("message", "Success");
        return resultMap;
    }
}
