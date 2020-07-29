package com.pando.subalzu.form;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.pando.subalzu.model.Product;

public class PriceUpdateForm {

    Long product;

    Long buyPrice;

    Long directPrice;

    Long parcelPrice;

    Long sellPrice;

    public Long getProduct() {
        return product;
    }

    public void setProduct(Long product) {
        this.product = product;
    }

    public Long getBuyPrice() {
        return buyPrice;
    }

    public void setBuyPrice(Long buyPrice) {
        this.buyPrice = buyPrice;
    }

    public Long getDirectPrice() {
        return directPrice;
    }

    public void setDirectPrice(Long directPrice) {
        this.directPrice = directPrice;
    }

    public Long getParcelPrice() {
        return parcelPrice;
    }

    public void setParcelPrice(Long parcelPrice) {
        this.parcelPrice = parcelPrice;
    }

    public Long getSellPrice() {
        return sellPrice;
    }

    public void setSellPrice(Long sellPrice) {
        this.sellPrice = sellPrice;
    }
}
