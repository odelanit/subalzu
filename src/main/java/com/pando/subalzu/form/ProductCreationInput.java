package com.pando.subalzu.form;

import java.util.Set;

public class ProductCreationInput {
    private Long id;

    String erpCode;

    String name;

    Long categoryId;

    Long subcategoryId;

    String makerName;

    String country;

    String standard;

    String unit;

    boolean tax;

    boolean useDecimal;

    String imageUrl;

    String message;

    int deliveryType; // 0 : 전체, 1: 직배송, 2: 택배 배송

    String shippingMethod; // manual : 수동발주, automatic : 자동발주

    Long supplierId;

    Long buyPrice;

    Long sellPrice; // 기본 단가

    Long directPrice; // 직배송 단가

    Long parcelPrice; // 택배 배송 단가

    Set<ProductGroupPriceInput> groupPrices;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getErpCode() {
        return erpCode;
    }

    public void setErpCode(String erpCode) {
        this.erpCode = erpCode;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Long getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Long categoryId) {
        this.categoryId = categoryId;
    }

    public Long getSubcategoryId() {
        return subcategoryId;
    }

    public void setSubcategoryId(Long subcategoryId) {
        this.subcategoryId = subcategoryId;
    }

    public String getMakerName() {
        return makerName;
    }

    public void setMakerName(String makerName) {
        this.makerName = makerName;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getStandard() {
        return standard;
    }

    public void setStandard(String standard) {
        this.standard = standard;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public boolean getTax() {
        return tax;
    }

    public void setTax(boolean tax) {
        this.tax = tax;
    }

    public boolean getUseDecimal() {
        return useDecimal;
    }

    public void setUseDecimal(boolean useDecimal) {
        this.useDecimal = useDecimal;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public int getDeliveryType() {
        return deliveryType;
    }

    public void setDeliveryType(int deliveryType) {
        this.deliveryType = deliveryType;
    }

    public String getShippingMethod() {
        return shippingMethod;
    }

    public void setShippingMethod(String shippingMethod) {
        this.shippingMethod = shippingMethod;
    }

    public Long getSupplierId() {
        return supplierId;
    }

    public void setSupplierId(Long supplierId) {
        this.supplierId = supplierId;
    }

    public Long getBuyPrice() {
        return buyPrice;
    }

    public void setBuyPrice(Long buyPrice) {
        this.buyPrice = buyPrice;
    }

    public Long getSellPrice() {
        return sellPrice;
    }

    public void setSellPrice(Long sellPrice) {
        this.sellPrice = sellPrice;
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

    public Set<ProductGroupPriceInput> getGroupPrices() {
        return groupPrices;
    }

    public void setGroupPrices(Set<ProductGroupPriceInput> groupPrices) {
        this.groupPrices = groupPrices;
    }
}
