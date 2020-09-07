package com.pando.subalzu.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import javax.persistence.*;
import java.io.File;
import java.time.LocalDateTime;
import java.util.Iterator;
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

    @Column(nullable = false)
    int deliveryType = 0; // 0 : 전체, 1: 직배송, 2: 택배 배송

    @Column(nullable = false)
    String shippingMethod = "manual"; // manual : 수동발주, automatic : 자동발주

    @ManyToOne
    @JoinColumn(name="supplier_id")
    @JsonManagedReference
    Supplier supplier;

    @Column(nullable = false)
    Long buyPrice = 0L;

    @Column(nullable = false)
    double qty = 0.0;

    boolean status = true;

    @CreationTimestamp
    @Column(updatable = false)
    @JsonFormat(pattern="yyyy-MM-dd")
    private LocalDateTime createdAt;

    @UpdateTimestamp
    private LocalDateTime updatedAt;

    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL)
    @JsonManagedReference
    Set<ShopProductPrice> shopPrices;

    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL)
    @JsonIgnore
    Set<ProductRecord> productRecords;

    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL)
    @JsonBackReference
    Set<OrderProduct> orderProducts;

    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL)
    @JsonIgnore
    Set<SupplyOrderProduct> supplyOrderProducts;

    @OneToMany(mappedBy = "product", cascade = CascadeType.REMOVE)
    @JsonManagedReference
    Set<ProductPrice> productPrices;

    @Transient
    Long pt;

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

    public Supplier getSupplier() {
        return supplier;
    }

    public void setSupplier(Supplier supplier) {
        this.supplier = supplier;
    }

    public Long getBuyPrice() {
        return buyPrice;
    }

    public void setBuyPrice(Long buyPrice) {
        this.buyPrice = buyPrice;
    }

    public Long getSellPrice() {
        for (ProductPrice productPrice : this.productPrices) {
            String priceGroupName = productPrice.getPriceGroup().getName();
            if (priceGroupName.equalsIgnoreCase("main")) {
                return productPrice.getPrice();
            }
        }
        return 0L;
    }

    public Long getDirectPrice() {
        for (ProductPrice productPrice : this.productPrices) {
            String priceGroupName = productPrice.getPriceGroup().getName();
            if (priceGroupName.equalsIgnoreCase("direct")) {
                return productPrice.getPrice();
            }
        }
        return 0L;
    }

    public Long getParcelPrice() {
        for (ProductPrice productPrice : this.productPrices) {
            String priceGroupName = productPrice.getPriceGroup().getName();
            if (priceGroupName.equalsIgnoreCase("parcel")) {
                return productPrice.getPrice();
            }
        }
        return 0L;
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
        Long price = 0L;
        while (iterator.hasNext()) {
            ShopProductPrice shopProductPrice = iterator.next();
            if (shopId.equals(shopProductPrice.getShop().getId())) {
                return shopProductPrice.getPrice();
            }
        }
        return price;
    }

    public double getQty() {
        return qty;
    }

    public void setQty(double qty) {
        this.qty = qty;
    }

    public Set<ProductRecord> getProductRecords() {
        return productRecords;
    }

    public void setProductRecords(Set<ProductRecord> productRecords) {
        this.productRecords = productRecords;
    }

    public Set<OrderProduct> getOrderProducts() {
        return orderProducts;
    }

    public void setOrderProducts(Set<OrderProduct> orderProducts) {
        this.orderProducts = orderProducts;
    }

    public Set<SupplyOrderProduct> getSupplyOrderProducts() {
        return supplyOrderProducts;
    }

    public void setSupplyOrderProducts(Set<SupplyOrderProduct> supplyOrderProducts) {
        this.supplyOrderProducts = supplyOrderProducts;
    }

    public Long getPt() {
        return pt;
    }

    public void setPt(Long pt) {
        this.pt = pt;
    }

    public Set<ProductPrice> getProductPrices() {
        return productPrices;
    }

    public void setProductPrices(Set<ProductPrice> productPrices) {
        this.productPrices = productPrices;
    }
}
