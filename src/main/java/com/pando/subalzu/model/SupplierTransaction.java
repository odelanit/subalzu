package com.pando.subalzu.model;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "supplier_transaction")
public class SupplierTransaction {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "supplier_id")
    Supplier supplier;

    String method; // manual_order: 일반 발주, fund_plus: 금액 추가, fund_minus: 금액 차감, direct_minus: 직접 출금,

    String type; // 매입: shipping, 수정: update, 출금: output

    @Column(nullable = false)
    Double amount = 0.0;

    @Column(nullable = false)
    Double totalAmount = 0.0;

    @Column(columnDefinition = "TEXT")
    String description;

    @CreationTimestamp
    @Column(updatable = false)
    private LocalDateTime createdAt;

    @UpdateTimestamp
    private LocalDateTime updatedAt;

    @Transient
    Long prevTotal;

    public SupplierTransaction() {
    }

    public SupplierTransaction(Supplier supplier) {
        this.supplier = supplier;
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

    public String getMethod() {
        return method;
    }

    public void setMethod(String method) {
        this.method = method;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
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

    public Double getAmount() {
        return amount;
    }

    public void setAmount(Double funds) {
        this.amount = funds;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String memo) {
        this.description = memo;
    }

    public Long getPrevTotal() {
        return prevTotal;
    }

    public void setPrevTotal(Long prevTotal) {
        this.prevTotal = prevTotal;
    }

    public Double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(Double totalAmount) {
        this.totalAmount = totalAmount;
    }
}
