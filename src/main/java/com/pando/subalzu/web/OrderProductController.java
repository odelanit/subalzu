package com.pando.subalzu.web;

import com.google.common.base.Strings;
import com.pando.subalzu.form.OrderProductSearchForm;
import com.pando.subalzu.model.Category;
import com.pando.subalzu.model.Order;
import com.pando.subalzu.model.OrderProduct;
import com.pando.subalzu.repository.CategoryRepository;
import com.pando.subalzu.repository.OrderProductRepository;
import com.pando.subalzu.specification.OrderProductSpecification;
import com.pando.subalzu.specification.OrderSpecification;
import com.pando.subalzu.specification.ProductSpecification;
import com.pando.subalzu.specification.SearchCriteria;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.util.Pair;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/order_products")
public class OrderProductController {

    @Autowired
    OrderProductRepository orderProductRepository;

    @Autowired
    CategoryRepository categoryRepository;

    @ModelAttribute("categories")
    List<Category> categories() {
        return categoryRepository.findByParentNull(Sort.by("name"));
    }

    @GetMapping("")
    public String index(@ModelAttribute("form")OrderProductSearchForm form, Model model) throws ParseException {
        String dateField = form.getDateField();
        String strDateFrom = form.getDateFrom();
        String strDateTo = form.getDateTo();
        String shopKeyword = form.getShopKeyword();
        String field = form.getField();
        String keyword = form.getKeyword();
        String deliveryType = form.getDeliveryType();
        String orderStatus = form.getOrderStatus();
        Category category = form.getCategory();
        int page = form.getPage();

        Specification<OrderProduct> spec = new OrderProductSpecification(new SearchCriteria(field, ":", keyword));
        if (!Strings.isNullOrEmpty(deliveryType)) {
            spec = Specification.where(spec).and(new OrderProductSpecification(new SearchCriteria("order_deliveryType", ":", deliveryType)));
        }
        if (!Strings.isNullOrEmpty(orderStatus)) {
            spec = Specification.where(spec).and(new OrderProductSpecification(new SearchCriteria("order_orderStatus", ":", orderStatus)));
        }
        if (category != null) {
            List<Category> subcategories = categoryRepository.findByParent(category);
            model.addAttribute("subcategories", subcategories);
            spec = Specification.where(spec).and(new OrderProductSpecification(new SearchCriteria("product_category", ":", category)));

            Category subcategory = form.getSubcategory();
            if (subcategory != null) {
                spec = Specification.where(spec).and(new OrderProductSpecification(new SearchCriteria("product_subCategory", ":", subcategory)));
            }
        } else {
            form.setSubcategory(null);
        }

        if (!Strings.isNullOrEmpty(strDateFrom) && !Strings.isNullOrEmpty(strDateTo)) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDateTime dateFrom = LocalDate.parse(strDateFrom, formatter).atStartOfDay();
            LocalDateTime dateTo = LocalDate.parse(strDateTo, formatter).atTime(23, 59, 59);
            Pair<LocalDateTime, LocalDateTime> dateTimePair = Pair.of(dateFrom, dateTo);
            spec = Specification.where(spec).and(new OrderProductSpecification(new SearchCriteria(dateField, "<>", dateTimePair)));
        }

        Pageable pageable = PageRequest.of(page - 1, 50, Sort.by("order.createdAt").descending());
        Page<OrderProduct> orderProductPage = orderProductRepository.findAll(spec, pageable);
        List<OrderProduct> orderProducts = orderProductPage.getContent();
        model.addAttribute("orderProductPage", orderProductPage);
        model.addAttribute("orderProducts", orderProducts);
        model.addAttribute("currentPage", page);
        model.addAttribute("localDateTimeFormat", DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss"));
        model.addAttribute("localDateTimeFormat2", DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        return "orders_per_product";
    }
}
