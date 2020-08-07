package com.pando.subalzu.form;

import java.util.Set;

public class OrderForm {
    Long id;

    Long shopId;

    String deliveryType;

    String requestDate;

    Long delivererId;

    Long salesmanId;

    String requestMemo;

    String memo;

    Set<OrderProductForm> orderProducts;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getShopId() {
        return shopId;
    }

    public void setShopId(Long shopId) {
        this.shopId = shopId;
    }

    public String getDeliveryType() {
        return deliveryType;
    }

    public void setDeliveryType(String deliveryType) {
        this.deliveryType = deliveryType;
    }

    public String getRequestDate() {
        return requestDate;
    }

    public void setRequestDate(String requestDate) {
        this.requestDate = requestDate;
    }

    public Long getDelivererId() {
        return delivererId;
    }

    public void setDelivererId(Long delivererId) {
        this.delivererId = delivererId;
    }

    public Long getSalesmanId() {
        return salesmanId;
    }

    public void setSalesmanId(Long salesmanId) {
        this.salesmanId = salesmanId;
    }

    public String getRequestMemo() {
        return requestMemo;
    }

    public void setRequestMemo(String requestMemo) {
        this.requestMemo = requestMemo;
    }

    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }

    public Set<OrderProductForm> getOrderProducts() {
        return orderProducts;
    }

    public void setOrderProducts(Set<OrderProductForm> orderProducts) {
        this.orderProducts = orderProducts;
    }
}
