package com.pando.subalzu.form;

import java.util.Set;

public class OrderReturnFom {
    Long id;

    Set<OrderProductForm> orderProducts;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Set<OrderProductForm> getOrderProducts() {
        return orderProducts;
    }

    public void setOrderProducts(Set<OrderProductForm> orderProducts) {
        this.orderProducts = orderProducts;
    }
}
