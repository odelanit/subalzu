package com.pando.subalzu.model;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.*;

@Entity
@Table(name = "orders")
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String orderCode;

    @ManyToOne
    @JoinColumn(name="shop_id")
    private Shop shop;

    @Column(nullable = false)
    private String deliveryType = "direct"; //direct, parcel

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern="yyyy-MM-dd")
    Date requestDate;

    @ManyToOne
    @JoinColumn(name="deliverer_id")
    User deliverer;

    @ManyToOne
    @JoinColumn(name="sales_man_id")
    User salesMan;

    @Column(columnDefinition = "TEXT")
    String requestMemo;

    @Column(columnDefinition = "TEXT")
    String memo;

    @CreationTimestamp
    @Column(updatable = false)
    @JsonFormat(pattern="yyyy-MM-dd")
    private LocalDateTime createdAt;

    @UpdateTimestamp
    private LocalDateTime updatedAt;

    private LocalDateTime returnedAt;

    @OneToMany(mappedBy = "order")
    @JsonManagedReference
    Set<OrderProduct> orderProducts;

    Long totalAmount;

    Long returnAmount = 0L;

    @Column(columnDefinition = "TEXT")
    String releaseCancelMemo;

    String orderStatus = "completed" ; // completed, modified, canceled,

    String releaseStatus = "progress"; // completed, progress, rejected,

    public Order() {
        Calendar calendar = GregorianCalendar.getInstance();
        calendar.setTime(new Date());
        calendar.add(Calendar.DATE, 1);
        calendar.set(Calendar.HOUR_OF_DAY, 23);
        calendar.set(Calendar.MINUTE, 59);
        calendar.set(Calendar.SECOND, 59);
        calendar.set(Calendar.MILLISECOND, 0);
        requestDate = calendar.getTime();
    }

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

    public String getDeliveryType() {
        return deliveryType;
    }

    public void setDeliveryType(String deliveryType) {
        this.deliveryType = deliveryType;
    }

    public Date getRequestDate() {
        return requestDate;
    }

    public void setRequestDate(Date requestDate) {
        this.requestDate = requestDate;
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

    public String getRequestMemo() {
        return requestMemo;
    }

    public void setRequestMemo(String requestMemo) {
        this.requestMemo = requestMemo;
    }

    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
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

    public Set<OrderProduct> getOrderProducts() {
        return orderProducts;
    }

    public void setOrderProducts(Set<OrderProduct> orderProducts) {
        this.orderProducts = orderProducts;
    }

    public Long getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(Long totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getOrderCode() {
        return orderCode;
    }

    public void setOrderCode(String orderCode) {
        this.orderCode = orderCode;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public String getReleaseStatus() {
        return releaseStatus;
    }

    public void setReleaseStatus(String releaseStatus) {
        this.releaseStatus = releaseStatus;
    }

    public String getReleaseCancelMemo() {
        return releaseCancelMemo;
    }

    public void setReleaseCancelMemo(String releaseCancelMemo) {
        this.releaseCancelMemo = releaseCancelMemo;
    }

    public Long getReturnAmount() {
        return returnAmount;
    }

    public void setReturnAmount(Long returnAmount) {
        this.returnAmount = returnAmount;
    }

    public LocalDateTime getReturnedAt() {
        return returnedAt;
    }

    public void setReturnedAt(LocalDateTime returnedAt) {
        this.returnedAt = returnedAt;
    }

    public Set<OrderProduct> getReturnOrderProducts() {
        Set<OrderProduct> returnOrderProducts = new HashSet<>();
        for (OrderProduct orderProduct : this.orderProducts) {
            if (orderProduct.getReturnQty() > 0) {
                returnOrderProducts.add(orderProduct);
            }
        }
        return returnOrderProducts;
    }
}
