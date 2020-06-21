package com.pando.subalzu.model;

import javax.persistence.*;

@Entity
@Table(name = "suppliers")
public class Supplier {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    private String code;

    private String ownerRegNo;

    private String representName;

    private String representPhone;

    private String supplyCategory;

    private String supplySubcategory;

    private String fax;

    private String email;

    private String addressCode;

    private String addressLine1;

    private String addressLine2;

    @OneToOne
    private User owner;

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

    public String getOwnerRegNo() {
        return ownerRegNo;
    }

    public void setOwnerRegNo(String ownerRegNo) {
        this.ownerRegNo = ownerRegNo;
    }

    public String getRepresentName() {
        return representName;
    }

    public void setRepresentName(String representName) {
        this.representName = representName;
    }

    public String getRepresentPhone() {
        return representPhone;
    }

    public void setRepresentPhone(String representPhone) {
        this.representPhone = representPhone;
    }

    public String getSupplyCategory() {
        return supplyCategory;
    }

    public void setSupplyCategory(String supplyCategory) {
        this.supplyCategory = supplyCategory;
    }

    public String getSupplySubcategory() {
        return supplySubcategory;
    }

    public void setSupplySubcategory(String supplySubcategory) {
        this.supplySubcategory = supplySubcategory;
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

    public String getAddressCode() {
        return addressCode;
    }

    public void setAddressCode(String addressCode) {
        this.addressCode = addressCode;
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

    public User getOwner() {
        return owner;
    }

    public void setOwner(User owner) {
        this.owner = owner;
    }
}
