package com.pando.subalzu.model;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
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
    Supplier supplier;

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    User user;

    @Column(nullable = false)
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    Date deliverBy;

    @Column(columnDefinition = "TEXT")
    String description;

    @Column(nullable = false)
    Long totalAmount = 0L;

    String shippingStatus = "standby"; // standby: 발주 대기, completed: 발주 완료, canceled: 발주 취소

    String inputStatus = "standby"; // standby: 입고 대기, completed: 입고 완료.

    @CreationTimestamp
    @Column(updatable = false)
    private LocalDateTime createdAt;

    @UpdateTimestamp
    private LocalDateTime updatedAt;

    @OneToMany(mappedBy = "supplyOrder")
    Set<SupplyOrderProduct> supplyOrderProducts;

    public SupplyOrder() {
        Calendar calendar = GregorianCalendar.getInstance();
        calendar.setTime(new Date());
        calendar.add(Calendar.DATE, 1);
        calendar.set(Calendar.HOUR_OF_DAY, 23);
        calendar.set(Calendar.MINUTE, 59);
        calendar.set(Calendar.SECOND, 59);
        calendar.set(Calendar.MILLISECOND, 0);
        deliverBy = calendar.getTime();
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

    public Date getDeliverBy() {
        return deliverBy;
    }

    public void setDeliverBy(Date deliverBy) {
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

    public Long getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(Long totalAmount) {
        this.totalAmount = totalAmount;
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
}
