package com.pando.subalzu.web;

import com.pando.subalzu.model.*;
import com.pando.subalzu.repository.*;
import com.pando.subalzu.validator.ShopValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.datatables.mapping.DataTablesInput;
import org.springframework.data.jpa.datatables.mapping.DataTablesOutput;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.util.List;
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
    ShopDataRepository shopDataRepository;

    @Autowired
    ShopValidator shopValidator;

    @Autowired
    BCryptPasswordEncoder bCryptPasswordEncoder;

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

    @GetMapping("/shops")
    public String index(Model model) {
        return "shop_list";
    }

    @PostMapping("/data/shops")
    @ResponseBody
    public DataTablesOutput<Shop> getShopData(@RequestBody @Valid DataTablesInput input) {
        return shopDataRepository.findAll(input);
    }

    @GetMapping("/shops/create")
    public String create(Model model) {
        model.addAttribute("shopForm", new Shop());
        return "shop_create";
    }

    @PostMapping("/shops/create")
    public String store(@ModelAttribute("shopForm")Shop shopForm, BindingResult bindingResult, Model model, RedirectAttributes redirectAttributes) {
        shopValidator.validate(shopForm, bindingResult);
        if (bindingResult.hasErrors()) {
            return "shop_create";
        }

        String username = shopForm.getShopTel();
        User user = new User();
        user.setFullName(username);
        user.setUsername(username);
        user.setPhone(username);
        user.setPassword(bCryptPasswordEncoder.encode(username));
        userRepository.save(user);

        shopRepository.save(shopForm);
        redirectAttributes.addFlashAttribute("message", "Shop Created");
        return "redirect:/shops";
    }

    @GetMapping("/shops/{id}/edit")
    public String edit(Model model, @PathVariable Long id) {
        Optional<Shop> optionalShop = shopRepository.findById(id);
        if (optionalShop.isPresent()) {
            model.addAttribute("shopForm", optionalShop.get());
            return "shop_edit";
        } else {
            return "redirect:/shops";
        }
    }

    @PostMapping("/shops/{id}/edit")
    public String update(@PathVariable Long id, @ModelAttribute("shopForm") Shop shopForm, BindingResult bindingResult, Model model, RedirectAttributes redirectAttributes) {
        Optional<Shop> optionalShop = shopRepository.findById(id);
        if (optionalShop.isPresent()) {
            Shop shop = optionalShop.get();
            shopValidator.validate(shopForm, bindingResult);
            if (bindingResult.hasErrors()) {
                model.addAttribute("shopForm", optionalShop.get());
                return "shop_edit";
            }
            if (!shop.getShopTel().equals(shopForm.getShopTel())) {
                String username = shopForm.getShopTel();
                User user = new User();
                user.setFullName(username);
                user.setUsername(username);
                user.setPhone(username);
                user.setPassword(bCryptPasswordEncoder.encode(username));
                userRepository.save(user);
            }

            shopRepository.save(shopForm);
            redirectAttributes.addFlashAttribute("message", "Shop Updated");
            return "redirect:/shops";
        } else {
            return "redirect:/shops";
        }
    }
}
