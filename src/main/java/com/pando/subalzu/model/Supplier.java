package com.pando.subalzu.model;

import com.fasterxml.jackson.annotation.JsonBackReference;

import javax.persistence.*;
import java.util.Set;

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

    @Transient
    private String fullName;

    @Transient
    private String phone;

    @Transient
    private String username;

    @Transient
    private String password;

    @Transient
    private String passwordConfirm;

    @Transient
    private String bio;

    @OneToMany(mappedBy = "supplier")
    @JsonBackReference
    private Set<Product> products;

    @OneToMany(mappedBy = "supplier")
    @JsonBackReference
    private Set<Balance> balances;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
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

    public Set<Product> getProducts() {
        return products;
    }

    public void setProducts(Set<Product> products) {
        this.products = products;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPasswordConfirm() {
        return passwordConfirm;
    }

    public void setPasswordConfirm(String passwordConfirm) {
        this.passwordConfirm = passwordConfirm;
    }

    public String getBio() {
        return bio;
    }

    public void setBio(String bio) {
        this.bio = bio;
    }

    public Set<Balance> getBalances() {
        return balances;
    }

    public void setBalances(Set<Balance> balances) {
        this.balances = balances;
    }
}
