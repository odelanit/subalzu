package com.pando.subalzu.web;

import com.google.common.base.Strings;
import com.pando.subalzu.form.NoticeSearchForm;
import com.pando.subalzu.form.ShopSearchForm;
import com.pando.subalzu.model.Notice;
import com.pando.subalzu.repository.NoticeRepository;
import com.pando.subalzu.repository.ShopRepository;
import com.pando.subalzu.specification.NoticeSpecification;
import com.pando.subalzu.specification.SearchCriteria;
import com.pando.subalzu.validator.NoticeValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Controller
public class NoticeController {
    @Autowired
    NoticeRepository noticeRepository;

    @Autowired
    NoticeValidator noticeValidator;

    @Autowired
    private ShopRepository shopRepository;

    @GetMapping("/notices")
    public String index(@ModelAttribute("form") NoticeSearchForm form, Model model) {
        String isPopup = form.getPopup();
        String type = form.getType();
        int page = form.getPage();
        Page<Notice> noticePage;
        if (!Strings.isNullOrEmpty(type) && !Strings.isNullOrEmpty(isPopup)) {
            NoticeSpecification spec1 = new NoticeSpecification(new SearchCriteria("type", ":", type));
            NoticeSpecification spec2 = new NoticeSpecification(new SearchCriteria("popup", ":", isPopup));
            Pageable pageable = PageRequest.of(page - 1, 5);
            noticePage = noticeRepository.findAll(Specification.where(spec1).and(spec2), pageable);
        } else if (!Strings.isNullOrEmpty(type) && Strings.isNullOrEmpty(isPopup)) {
            NoticeSpecification spec1 = new NoticeSpecification(new SearchCriteria("type", ":", type));
            Pageable pageable = PageRequest.of(page - 1, 5);
            noticePage = noticeRepository.findAll(spec1, pageable);
        } else if (Strings.isNullOrEmpty(type) && !Strings.isNullOrEmpty(isPopup)) {
            NoticeSpecification spec2 = new NoticeSpecification(new SearchCriteria("popup", ":", isPopup));
            Pageable pageable = PageRequest.of(page - 1, 5);
            noticePage = noticeRepository.findAll(spec2, pageable);
        } else {
            Pageable pageable = PageRequest.of(page - 1, 5);
            noticePage = noticeRepository.findAll(pageable);
        }

        List<Notice> notices = noticePage.getContent();
        model.addAttribute("noticePage", noticePage);
        model.addAttribute("notices", notices);
        model.addAttribute("currentPage", page);
        model.addAttribute("localDateTimeFormat", DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        return "notice_list";
    }

    @GetMapping("/notices/create")
    public String create(Model model) {
        model.addAttribute("noticeForm", new Notice());
        model.addAttribute("shopSearchForm", new ShopSearchForm());
        model.addAttribute("register", true);
        return "notice_edit";
    }

    @PostMapping("/notices/create")
    public String store(@ModelAttribute("noticeForm") Notice noticeForm, BindingResult bindingResult, Model model) {
        noticeValidator.validate(noticeForm, bindingResult);

        if (bindingResult.hasErrors()) {
            model.addAttribute("shopSearchForm", new ShopSearchForm());
            model.addAttribute("register", true);
            return "notice_edit";
        }

        noticeRepository.save(noticeForm);

        return "redirect:/notices";
    }

    @GetMapping("/notices/{id}")
    public String edit(Model model, @PathVariable long id) {
        Optional<Notice> optionalNotice = noticeRepository.findById(id);
        if (optionalNotice.isPresent()) {
            Notice notice = optionalNotice.get();
            model.addAttribute("shopSearchForm", new ShopSearchForm());
            model.addAttribute("noticeForm", notice);
            model.addAttribute("register", false);
            return "notice_edit";
        } else {
            return "redirect:/notices";
        }
    }

    @PostMapping("/notices/{id}")
    public String update(@ModelAttribute("noticeForm") Notice noticeForm, BindingResult bindingResult, RedirectAttributes redirectAttributes, Model model) {
        noticeValidator.validate(noticeForm, bindingResult);
        if (bindingResult.hasErrors()) {
            model.addAttribute("shopSearchForm", new ShopSearchForm());
            model.addAttribute("register", false);
            return "notice_edit";
        }
        noticeRepository.save(noticeForm);
        redirectAttributes.addFlashAttribute("message", "Notice Updated");
        return "redirect:/notices";
    }

    @GetMapping("/notices/{id}/delete")
    public String delete(@PathVariable(value = "id") long id) {
        noticeRepository.deleteById(id);
        return "redirect:/notices";
    }

    @PostMapping("/notices/shop_list")
    @ResponseBody
    public Map<String, Object> getShopList(@ModelAttribute("shopSearchForm") ShopSearchForm form) {
        String type = form.getType();
        String keyword = form.getKeyword();
        List<Object> shops = shopRepository.getShopsIdAndNameByName(keyword);
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("rc", shops.size());
        resultMap.put("data", shops);
        return resultMap;
    }
}
