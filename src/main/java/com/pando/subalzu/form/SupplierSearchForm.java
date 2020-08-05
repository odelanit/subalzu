package com.pando.subalzu.form;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class SupplierSearchForm {
    String type;

    String keyword;

    String dateFrom;

    String dateTo;

    int page = 1;

    int period = 1;

    public SupplierSearchForm() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDateTime now = LocalDateTime.now();
        dateFrom = now.withDayOfMonth(1).format(formatter);
        dateTo = now.withDayOfMonth(now.toLocalDate().lengthOfMonth()).format(formatter);
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
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

    public int getPeriod() {
        return period;
    }

    public void setPeriod(int period) {
        this.period = period;
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
}
