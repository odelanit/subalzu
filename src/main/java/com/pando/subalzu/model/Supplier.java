package com.pando.subalzu.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.Iterator;
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

    private Long totalPrevBalance = 0L;

    @CreationTimestamp
    @Column(updatable = false)
    @JsonFormat(pattern="yyyy-MM-dd")
    private LocalDateTime createdAt;

    @UpdateTimestamp
    private LocalDateTime updatedAt;

    private LocalDateTime dealtAt;

    @Transient
    @JsonIgnore
    private String fullName;

    @Transient
    @JsonIgnore
    private String phone;

    @Transient
    @JsonIgnore
    private String username;

    @Transient
    @JsonIgnore
    private String password;

    @Transient
    @JsonIgnore
    private String passwordConfirm;

    @Transient
    @JsonIgnore
    private String bio;

    @OneToMany(mappedBy = "supplier")
    @JsonBackReference
    private Set<Product> products;

    @OneToMany(mappedBy = "supplier")
    @JsonBackReference
    private Set<SupplierTransaction> supplierTransactions;

    @OneToOne
    @JoinColumn(name = "owner_id")
    @JsonManagedReference
    private SupplyOwner owner;

    @OneToMany(mappedBy = "supplier")
    @JsonBackReference
    Set<SupplyOrder> supplyOrders;

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

    public Set<SupplierTransaction> getSupplierTransactions() {
        return supplierTransactions;
    }

    public void setSupplierTransactions(Set<SupplierTransaction> supplierTransactions) {
        this.supplierTransactions = supplierTransactions;
    }

    public SupplyOwner getOwner() {
        return owner;
    }

    public void setOwner(SupplyOwner owner) {
        this.owner = owner;
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

    public LocalDateTime getDealtAt() {
        return dealtAt;
    }

    public void setDealtAt(LocalDateTime dealtAt) {
        this.dealtAt = dealtAt;
    }

    public Long getTotalPrevBalance() {
        return totalPrevBalance;
    }

    public void setTotalPrevBalance(Long totalPrevFunds) {
        this.totalPrevBalance = totalPrevFunds;
    }

    public double getTotalFunds() {
        Iterator<SupplierTransaction> iterator = this.supplierTransactions.iterator();
        double total = 0;
        while (iterator.hasNext()) {
            SupplierTransaction supplierTransaction = iterator.next();
            total += supplierTransaction.getAmount();
        }
        return total;
    }

    public double getTotalInputFunds() {
        Iterator<SupplierTransaction> iterator = this.supplierTransactions.iterator();
        double total = 0;
        while (iterator.hasNext()) {
            SupplierTransaction supplierTransaction = iterator.next();
            if (supplierTransaction.getType().equalsIgnoreCase("shipping"))
                total += supplierTransaction.getAmount();
        }
        return total;
    }

    public double getTotalOutputFunds() {
        Iterator<SupplierTransaction> iterator = this.supplierTransactions.iterator();
        double total = 0;
        while (iterator.hasNext()) {
            SupplierTransaction supplierTransaction = iterator.next();
            if (supplierTransaction.getType().equalsIgnoreCase("output"))
                total += supplierTransaction.getAmount();
        }
        return total;
    }

    public double getTotalUpdateFunds() {
        Iterator<SupplierTransaction> iterator = this.supplierTransactions.iterator();
        double total = 0;
        while (iterator.hasNext()) {
            SupplierTransaction supplierTransaction = iterator.next();
            if (supplierTransaction.getType().equalsIgnoreCase("update"))
                total += supplierTransaction.getAmount();
        }
        return total;
    }

    public Long getProductsCount() {
        return (long) this.products.size();
    }

    public Set<SupplyOrder> getSupplyOrders() {
        return supplyOrders;
    }

    public void setSupplyOrders(Set<SupplyOrder> supplyOrders) {
        this.supplyOrders = supplyOrders;
    }
}
