package com.pando.subalzu.form;

public class OrderProductForm {
    Long id;

    Long productId;

    Long priceGroupId;

    Long orderId;

    Double qty;

    Double reQty;

    Long price;

    Double funds;

    Double refunds;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getProductId() {
        return productId;
    }

    public void setProductId(Long productId) {
        this.productId = productId;
    }

    public Long getPriceGroupId() {
        return priceGroupId;
    }

    public void setPriceGroupId(Long priceGroupId) {
        this.priceGroupId = priceGroupId;
    }

    public Long getOrderId() {
        return orderId;
    }

    public void setOrderId(Long orderId) {
        this.orderId = orderId;
    }

    public Double getQty() {
        return qty;
    }

    public void setQty(Double qty) {
        this.qty = qty;
    }

    public Double getReQty() {
        return reQty;
    }

    public void setReQty(Double reQty) {
        this.reQty = reQty;
    }

    public Long getPrice() {
        return price;
    }

    public void setPrice(Long price) {
        this.price = price;
    }

    public Double getFunds() {
        return funds;
    }

    public void setFunds(Double funds) {
        this.funds = funds;
    }

    public Double getRefunds() {
        return refunds;
    }

    public void setRefunds(Double refunds) {
        this.refunds = refunds;
    }
}
