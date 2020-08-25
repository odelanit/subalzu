package com.pando.subalzu.model;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "transactions")
public class Transaction {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name="shop_id", nullable = false)
    Shop shop;

    @Column(nullable = false)
    String transactionType; // input: 입금, sale: 매출, update: 수정

    @Column(nullable = false)
    String processingMethod; // manual_minus: 직접 입금, fund_minus: 금액 차감, fund_plus: 금액 추가, order_minus: 주문 완료

    @Column(nullable = false)
    Double funds = 0.0; // 한개 트랜잭션 자금

    @Column(nullable = false)
    Double totalFunds = 0.0; // 누적 트랜잭션 자금

    @Column(columnDefinition = "TEXT")
    String description;

    @CreationTimestamp
    @Column(updatable = false)
    private LocalDateTime createdAt;

    @UpdateTimestamp
    private LocalDateTime updatedAt;

    @Transient
    Double prevTotal;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Shop getShop() {
        return shop;
    }

    public void setShop(Shop shop) {
        this.shop = shop;
    }

    public String getTransactionType() {
        return transactionType;
    }

    public void setTransactionType(String transactionType) {
        this.transactionType = transactionType;
    }

    public String getProcessingMethod() {
        return processingMethod;
    }

    public void setProcessingMethod(String processingMethod) {
        this.processingMethod = processingMethod;
    }

    public Double getFunds() {
        return funds;
    }

    public void setFunds(Double amount) {
        this.funds = amount;
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

    public Double getTotalFunds() {
        return totalFunds;
    }

    public void setTotalFunds(Double totalAmount) {
        this.totalFunds = totalAmount;
    }

    public Double getPrevTotal() {
        return prevTotal;
    }

    public void setPrevTotal(Double prevTotal) {
        this.prevTotal = prevTotal;
    }
}
