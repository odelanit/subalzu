package com.pando.subalzu.web;

import com.pando.subalzu.model.Notice;
import com.pando.subalzu.model.Permission;
import com.pando.subalzu.model.Role;
import com.pando.subalzu.model.User;
import com.pando.subalzu.repository.NoticeDataRepository;
import com.pando.subalzu.repository.NoticeRepository;
import com.pando.subalzu.validator.NoticeValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.datatables.mapping.DataTablesInput;
import org.springframework.data.jpa.datatables.mapping.DataTablesOutput;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Controller
public class NoticeController {
    @Autowired
    NoticeRepository noticeRepository;

    @Autowired
    NoticeDataRepository noticeDataRepository;

    @Autowired
    NoticeValidator noticeValidator;

    @GetMapping("/notices")
    public String index(Model model) {
        return "notice_list";
    }

    @RequestMapping(value = "/data/notices", method = RequestMethod.POST)
    @ResponseBody
    public DataTablesOutput<Notice> dataUsers(@Valid @RequestBody DataTablesInput input) {
        return noticeDataRepository.findAll(input);
    }

    @GetMapping("/notices/create")
    public String create(Model model) {
        model.addAttribute("noticeForm", new Notice());
        return "notice_edit";
    }

    @PostMapping("/notices/create")
    public String store(@ModelAttribute("noticeForm") Notice noticeForm, BindingResult bindingResult) {
        noticeValidator.validate(noticeForm, bindingResult);

        if (bindingResult.hasErrors()) {
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
            model.addAttribute("noticeForm", notice);
            return "notice_edit";
        } else {
            return "redirect:/notices";
        }
    }

    @PostMapping("/notices/{id}")
    public String update(@ModelAttribute("noticeForm") Notice noticeForm, BindingResult bindingResult, RedirectAttributes redirectAttributes) {
        noticeValidator.validate(noticeForm, bindingResult);
        if (bindingResult.hasErrors()) {
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
}
