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

    String method; // shipping: 일반 발주, addition: 금액 추가, subtraction: 금액 차감, withdraw: 직접 출금,

    String type; // 매입: shipping, 수정: correction, 출금: withdraw

    @Column(nullable = false)
    Long amount = 0L;

    Long totalAmount = 0L;

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

    public Long getAmount() {
        return amount;
    }

    public void setAmount(Long funds) {
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

    public Long getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(Long totalAmount) {
        this.totalAmount = totalAmount;
    }
}
