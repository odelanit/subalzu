package com.pando.subalzu.form;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class ShippingSearchForm {

    String field = "supplier_name";

    String keyword = "";

    String shippingStatus;

    String supplier_releaseStatus;

    String inputStatus;

    String dateFrom;

    String dateTo;

    int page = 1;

    int period = 2;

    public ShippingSearchForm() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDateTime now = LocalDateTime.now();
        dateTo = now.format(formatter);
        dateFrom = now.minusDays(1).format(formatter);
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

    public String getShippingStatus() {
        return shippingStatus;
    }

    public void setShippingStatus(String shippingStatus) {
        this.shippingStatus = shippingStatus;
    }

    public String getSupplier_releaseStatus() {
        return supplier_releaseStatus;
    }

    public void setSupplier_releaseStatus(String supplier_releaseStatus) {
        this.supplier_releaseStatus = supplier_releaseStatus;
    }

    public String getInputStatus() {
        return inputStatus;
    }

    public void setInputStatus(String inputStatus) {
        this.inputStatus = inputStatus;
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
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

    public int getPeriod() {
        return period;
    }

    public void setPeriod(int period) {
        this.period = period;
    }
}
