package com.pando.subalzu.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "shops")
public class Shop {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = true)
    String name;

    String erpCode;

    @ManyToOne
    @JoinColumn(name="business_id")
    @JsonManagedReference
    Business business;

    @Column(nullable = false)
    String zipCode;

    @Column(nullable = false)
    String addressLine1;

    @Column(nullable = false)
    String addressLine2;

    @ElementCollection
    List<String> deliveryTypes;

    String fax;

    String email;

    @Column(nullable = false)
    String shopTel;

    @Column(nullable = false)
    String contactName;

    @Column(nullable = false)
    String contactPhone;

    @ManyToOne
    @JoinColumn(name="deliverer_id", nullable = false)
    User deliverer;

    @ManyToOne
    @JoinColumn(name="sales_man_id")
    User salesMan;

    @ManyToOne
    @JoinColumn(name="price_group_id")
    PriceGroup priceGroup;

    @ManyToOne
    @JoinColumn(name="shop_grade_id")
    @JsonBackReference
    ShopGrade shopGrade;

    String paymentMethod = "credit"; // credit, prepaid

    boolean isCreditBalanceLimit = false;

    Long creditBalanceLimit;

    boolean businessLicense = true;

    boolean dealStatus = true;

    @ManyToOne
    @JoinColumn(name="assignee_type_id")
    AssigneeType assigneeType;

    @CreationTimestamp
    @Column(updatable = false)
    @JsonFormat(pattern="yyyy-MM-dd")
    private LocalDateTime createdAt;

    @UpdateTimestamp
    @JsonIgnore
    private LocalDateTime updatedAt;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getErpCode() {
        return erpCode;
    }

    public void setErpCode(String erpCode) {
        this.erpCode = erpCode;
    }

    public Business getBusiness() {
        return business;
    }

    public void setBusiness(Business business) {
        this.business = business;
    }

    public String getZipCode() {
        return zipCode;
    }

    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
    }

    public String getAddressLine1() {
        return addressLine1;
    }

    public void setAddressLine1(String addressLine1) {
        this.addressLine1 = addressLine1;
    }

    public String getAddressLine2() {
        return addressLine2;
    }

    public void setAddressLine2(String addressLine2) {
        this.addressLine2 = addressLine2;
    }

    public List<String> getDeliveryTypes() {
        return deliveryTypes;
    }

    public void setDeliveryTypes(List<String> deliveryTypes) {
        this.deliveryTypes = deliveryTypes;
    }

    public String getFax() {
        return fax;
    }

    public void setFax(String fax) {
        this.fax = fax;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getShopTel() {
        return shopTel;
    }

    public void setShopTel(String shopTel) {
        this.shopTel = shopTel;
    }

    public String getContactName() {
        return contactName;
    }

    public void setContactName(String contactName) {
        this.contactName = contactName;
    }

    public String getContactPhone() {
        return contactPhone;
    }

    public void setContactPhone(String contactPhone) {
        this.contactPhone = contactPhone;
    }

    public User getDeliverer() {
        return deliverer;
    }

    public void setDeliverer(User deliverer) {
        this.deliverer = deliverer;
    }

    public User getSalesMan() {
        return salesMan;
    }

    public void setSalesMan(User salesMan) {
        this.salesMan = salesMan;
    }

    public PriceGroup getPriceGroup() {
        return priceGroup;
    }

    public void setPriceGroup(PriceGroup priceGroup) {
        this.priceGroup = priceGroup;
    }

    public ShopGrade getShopGrade() {
        return shopGrade;
    }

    public void setShopGrade(ShopGrade shopGrade) {
        this.shopGrade = shopGrade;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public boolean getIsCreditBalanceLimit() {
        return isCreditBalanceLimit;
    }

    public void setIsCreditBalanceLimit(boolean creditBalanceLimit) {
        isCreditBalanceLimit = creditBalanceLimit;
    }

    public Long getCreditBalanceLimit() {
        return creditBalanceLimit;
    }

    public void setCreditBalanceLimit(Long creditBalanceLimit) {
        this.creditBalanceLimit = creditBalanceLimit;
    }

    public boolean getBusinessLicense() {
        return businessLicense;
    }

    public void setBusinessLicense(boolean businessLicense) {
        this.businessLicense = businessLicense;
    }

    public AssigneeType getAssigneeType() {
        return assigneeType;
    }

    public void setAssigneeType(AssigneeType assigneeType) {
        this.assigneeType = assigneeType;
    }

    public boolean getDealStatus() {
        return dealStatus;
    }

    public void setDealStatus(boolean dealStatus) {
        this.dealStatus = dealStatus;
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
}
