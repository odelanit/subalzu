package com.pando.subalzu.model;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.Set;

@Entity
@Table(name = "supply_orders")
public class SupplyOrder {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    String orderCode;

    @ManyToOne
    @JoinColumn(name = "supplier_id", nullable = false)
    @JsonManagedReference
    Supplier supplier;

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    @JsonManagedReference
    User user;

    @Column(nullable = false)
    @JsonFormat(pattern = "yyyy-MM-dd")
    LocalDateTime deliverBy;

    @Column(columnDefinition = "TEXT")
    String description;

    String shippingStatus = "standby"; // standby: 발주 대기, completed: 발주 완료, canceled: 발주 취소

    String inputStatus = "standby"; // standby: 입고 대기, completed: 입고 완료.

    @CreationTimestamp
    @Column(updatable = false)
    private LocalDateTime createdAt;

    @UpdateTimestamp
    private LocalDateTime updatedAt;

    @OneToMany(mappedBy = "supplyOrder", cascade = CascadeType.ALL)
    @JsonManagedReference
    Set<SupplyOrderProduct> supplyOrderProducts;

    public SupplyOrder() {
        deliverBy = LocalDateTime.now().plusDays(1);
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Supplier getSupplier() {
        return supplier;
    }

    public void setSupplier(Supplier supplier) {
        this.supplier = supplier;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public LocalDateTime getDeliverBy() {
        return deliverBy;
    }

    public void setDeliverBy(LocalDateTime deliverBy) {
        this.deliverBy = deliverBy;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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

    public Set<SupplyOrderProduct> getSupplyOrderProducts() {
        return supplyOrderProducts;
    }

    public void setSupplyOrderProducts(Set<SupplyOrderProduct> supplyOrderProducts) {
        this.supplyOrderProducts = supplyOrderProducts;
    }

    public String getOrderCode() {
        return orderCode;
    }

    public void setOrderCode(String shippingCode) {
        this.orderCode = shippingCode;
    }

    public String getShippingStatus() {
        return shippingStatus;
    }

    public void setShippingStatus(String shippingStatus) {
        this.shippingStatus = shippingStatus;
    }

    public String getInputStatus() {
        return inputStatus;
    }

    public void setInputStatus(String inputStatus) {
        this.inputStatus = inputStatus;
    }

    public Double getTotalQty() {
        double totalQty = 0;
        for (SupplyOrderProduct orderProduct : supplyOrderProducts) {
            totalQty += orderProduct.getQty();
        }
        return totalQty;
    }

    public Double getTotalFunds() {
        double totalFunds = 0;
        for (SupplyOrderProduct orderProduct : supplyOrderProducts) {
            totalFunds += orderProduct.getQty() * orderProduct.getPrice();
        }
        return totalFunds;
    }
}
