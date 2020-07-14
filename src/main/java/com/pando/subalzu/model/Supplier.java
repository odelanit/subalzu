package com.pando.subalzu.model;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;

@Entity
@Table(name = "suppliers")
public class Supplier { // 매입처
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    private String code;

    private String regNo;

    private String ownerName;

    private String businessTel;

    private String businessItem;

    private String businessConditions;

    private String fax;

    private String email;

    private String zipCode;

    private String addressLine1;

    private String addressLine2;

    @OneToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "user_id", nullable = false)
    @JsonIgnore
    private User user;

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

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getRegNo() {
        return regNo;
    }

    public void setRegNo(String ownerRegNo) {
        this.regNo = ownerRegNo;
    }

    public String getOwnerName() {
        return ownerName;
    }

    public void setOwnerName(String representName) {
        this.ownerName = representName;
    }

    public String getBusinessTel() {
        return businessTel;
    }

    public void setBusinessTel(String representPhone) {
        this.businessTel = representPhone;
    }

    public String getBusinessItem() {
        return businessItem;
    }

    public void setBusinessItem(String supplyCategory) {
        this.businessItem = supplyCategory;
    }

    public String getBusinessConditions() {
        return businessConditions;
    }

    public void setBusinessConditions(String supplySubcategory) {
        this.businessConditions = supplySubcategory;
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

    public String getZipCode() {
        return zipCode;
    }

    public void setZipCode(String addressCode) {
        this.zipCode = addressCode;
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

    public User getUser() {
        return user;
    }

    public void setUser(User owner) {
        this.user = owner;
    }
}
