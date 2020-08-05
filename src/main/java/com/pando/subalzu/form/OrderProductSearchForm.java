package com.pando.subalzu.form;

import com.pando.subalzu.model.Category;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class OrderProductSearchForm {

    String dateField = "order_createdAt";

    String field = "product_name";

    String shopKeyword = "";

    String keyword = "";

    String dateFrom;

    String dateTo;

    String deliveryType;

    String orderStatus;

    String releaseStatus;

    Category category;

    Category subcategory;

    int page = 1;

    int period = 2;

    public OrderProductSearchForm() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        dateTo = LocalDateTime.now().format(formatter);
        dateFrom = LocalDateTime.now().minusDays(1).format(formatter);
    }

    public String getField() {
        return field;
    }

    public void setField(String field) {
        this.field = field;
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public String getDateField() {
        return dateField;
    }

    public void setDateField(String dateField) {
        this.dateField = dateField;
    }

    public String getDateFrom() {
        return dateFrom;
    }

    public void setDateFrom(String dateFrom) {
        this.dateFrom = dateFrom;
    }

    public String getDateTo() {
        return dateTo;
    }

    public void setDateTo(String dateTo) {
        this.dateTo = dateTo;
    }

    public String getDeliveryType() {
        return deliveryType;
    }

    public void setDeliveryType(String deliveryType) {
        this.deliveryType = deliveryType;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public Category getSubcategory() {
        return subcategory;
    }

    public void setSubcategory(Category subcategory) {
        this.subcategory = subcategory;
    }

    public String getShopKeyword() {
        return shopKeyword;
    }

    public void setShopKeyword(String shopKeyword) {
        this.shopKeyword = shopKeyword;
    }

    public String getReleaseStatus() {
        return releaseStatus;
    }

    public void setReleaseStatus(String releaseStatus) {
        this.releaseStatus = releaseStatus;
    }

    public int getPeriod() {
        return period;
    }

    public void setPeriod(int period) {
        this.period = period;
    }
}
