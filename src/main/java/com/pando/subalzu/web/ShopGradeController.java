package com.pando.subalzu.web;

import com.pando.subalzu.model.ShopGrade;
import com.pando.subalzu.repository.ShopGradeDataRepository;
import com.pando.subalzu.repository.ShopGradeRepository;
import com.pando.subalzu.validator.ShopGradeValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.DefaultMessageSourceResolvable;
import org.springframework.data.jpa.datatables.mapping.DataTablesInput;
import org.springframework.data.jpa.datatables.mapping.DataTablesOutput;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

@Controller
public class ShopGradeController {

    @Autowired
    ShopGradeDataRepository shopGradeDataRepository;

    @Autowired
    ShopGradeRepository shopGradeRepository;

    @Autowired
    ShopGradeValidator validator;

    @GetMapping("/shop_grades")
    public String index(Model model) {
        model.addAttribute("shopGradeForm", new ShopGrade());
        return "shop_grade_list";
    }

    @PostMapping("/data/shop_grades")
    @ResponseBody
    public DataTablesOutput<ShopGrade> getShopGradeData(@Valid @RequestBody DataTablesInput input) {
        return shopGradeDataRepository.findAll(input);
    }

    private Map<String, Object> storeOrUpdate(ShopGrade shopGrade, BindingResult bindingResult, HttpServletResponse response) {
        validator.validate(shopGrade, bindingResult);
        Map<String, Object> resultMap = new HashMap<>();
        if (bindingResult.hasErrors()) {
            List<FieldError> errors = bindingResult.getFieldErrors();
            Map<String, String> messageMap = new HashMap<>();
            for (FieldError oe: errors) {
                messageMap.put(oe.getField(), oe.getDefaultMessage());
            }
            resultMap.put("error", messageMap);
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return resultMap;
        }
        shopGradeRepository.save(shopGrade);
        resultMap.put("message", "Success");
        return resultMap;
    }

    @PostMapping("/shop_grades/store")
    @ResponseBody
    public Map<String, Object> store(@ModelAttribute("shopGrade") ShopGrade shopGrade, BindingResult bindingResult, HttpServletResponse response) {
        return storeOrUpdate(shopGrade, bindingResult, response);
    }

    @PostMapping("/shop_grades/{id}")
    @ResponseBody
    public Map<String, Object> update(@ModelAttribute("shopGrade") ShopGrade shopGrade, BindingResult bindingResult, HttpServletResponse response) {
        return storeOrUpdate(shopGrade, bindingResult, response);
    }

    @GetMapping("/shop_grades/{id}")
    @ResponseBody
    public Map<String, String> delete(@PathVariable Long id, HttpServletResponse response) {
        Map<String, String> resultMap = new HashMap<>();
        Optional<ShopGrade> optionalShopGrade = shopGradeRepository.findById(id);
        if (optionalShopGrade.isPresent()) {
            ShopGrade shopGrade = optionalShopGrade.get();
            shopGradeRepository.delete(shopGrade);
            resultMap.put("message", "Success");
            return resultMap;
        } else {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            resultMap.put("error", "Not Found");
            return resultMap;
        }
    }
}
