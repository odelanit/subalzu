package com.pando.subalzu.form;

import java.util.Set;

public class SupplyOrderForm {
    Long id;

    Long supplierId;

    String deliverBy;

    Long salesmanId;

    String description;

    Set<SupplyOrderProductForm> orderProducts;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getSupplierId() {
        return supplierId;
    }

    public void setSupplierId(Long supplierId) {
        this.supplierId = supplierId;
    }

    public String getDeliverBy() {
        return deliverBy;
    }

    public void setDeliverBy(String deliverBy) {
        this.deliverBy = deliverBy;
    }

    public Long getSalesmanId() {
        return salesmanId;
    }

    public void setSalesmanId(Long salesmanId) {
        this.salesmanId = salesmanId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Set<SupplyOrderProductForm> getOrderProducts() {
        return orderProducts;
    }

    public void setOrderProducts(Set<SupplyOrderProductForm> orderProducts) {
        this.orderProducts = orderProducts;
    }
}
