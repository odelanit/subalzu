package com.pando.subalzu.model;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import javax.persistence.*;
import java.io.File;
import java.time.LocalDateTime;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

@Entity
@Table(name = "products")
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    String erpCode;

    @Column(nullable = false)
    String name;

    @ManyToOne
    @JoinColumn(name="category_id")
    @JsonManagedReference
    Category category;

    @ManyToOne
    @JoinColumn(name="subcategory_id")
    @JsonManagedReference
    Category subCategory;

    String makerName;

    String country;

    String standard;

    String unit;

    @Column(nullable = false)
    boolean tax = true;

    boolean useDecimal = false;

    String imageUrl;

    @Transient
    File image;

    String message;

    @ElementCollection
    List<String> deliveryTypes;

    @Column(nullable = false)
    String shippingMethod = "manual";

    @ManyToOne
    @JoinColumn(name="supplier_id")
    @JsonManagedReference
    Supplier supplier;

    int buyPrice = 0;

    Long sellPrice;

    int directPrice = 0;

    int parcelPrice = 0;

    int qty = 0;

    boolean status = true;

    @CreationTimestamp
    @Column(updatable = false)
    @JsonFormat(pattern="yyyy-MM-dd")
    private LocalDateTime createdAt;

    @UpdateTimestamp
    private LocalDateTime updatedAt;

    @OneToMany(mappedBy = "product")
    @JsonIgnore
    Set<ProductGroupPrice> groupPrices;

    @OneToMany(mappedBy = "product")
    @JsonIgnore
    Set<ShopProductPrice> shopPrices;

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

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
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

    public void setTax(boolean taxType) {
        this.tax = taxType;
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

    public List<String> getDeliveryTypes() {
        return deliveryTypes;
    }

    public void setDeliveryTypes(List<String> deliveryTypes) {
        this.deliveryTypes = deliveryTypes;
    }

    public String getShippingMethod() {
        return shippingMethod;
    }

    public void setShippingMethod(String shippingMethod) {
        this.shippingMethod = shippingMethod;
    }

    public Supplier getSupplier() {
        return supplier;
    }

    public void setSupplier(Supplier supplier) {
        this.supplier = supplier;
    }

    public int getBuyPrice() {
        return buyPrice;
    }

    public void setBuyPrice(int buyPrice) {
        this.buyPrice = buyPrice;
    }

    public Long getSellPrice() {
        return sellPrice;
    }

    public void setSellPrice(Long sellPrice) {
        this.sellPrice = sellPrice;
    }

    public int getDirectPrice() {
        return directPrice;
    }

    public void setDirectPrice(int directPrice) {
        this.directPrice = directPrice;
    }

    public int getParcelPrice() {
        return parcelPrice;
    }

    public void setParcelPrice(int parcelPrice) {
        this.parcelPrice = parcelPrice;
    }

    public Set<ProductGroupPrice> getGroupPrices() {
        return groupPrices;
    }

    public void setGroupPrices(Set<ProductGroupPrice> groupPrices) {
        this.groupPrices = groupPrices;
    }

    public File getImage() {
        return image;
    }

    public void setImage(File image) {
        this.image = image;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    public Category getSubCategory() {
        return subCategory;
    }

    public void setSubCategory(Category subCategory) {
        this.subCategory = subCategory;
    }

    public boolean getStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public Set<ShopProductPrice> getShopPrices() {
        return shopPrices;
    }

    public void setShopPrices(Set<ShopProductPrice> shopPrices) {
        this.shopPrices = shopPrices;
    }

    public Long getShopPrice(Long shopId) {
        Iterator<ShopProductPrice> iterator = shopPrices.iterator();
        Long price = Long.valueOf(0);
        while (iterator.hasNext()) {
            ShopProductPrice shopProductPrice = iterator.next();
            if (shopId.equals(shopProductPrice.getShop().getId())) {
                return shopProductPrice.getPrice();
            }
        }
        return price;
    }

    public int getQty() {
        return qty;
    }

    public void setQty(int qty) {
        this.qty = qty;
    }
}
