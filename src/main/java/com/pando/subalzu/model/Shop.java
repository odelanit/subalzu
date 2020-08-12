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
@Table(name = "shops")
public class Shop { // 거래처
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    String name;

    String erpCode;

    @ManyToOne
    @JoinColumn(name="business_id")
    @JsonManagedReference
    Business business;

    @Column(nullable = false)
    String zipCode;

    @Column(nullable = false)
    String addressLine1;

    @Column(nullable = false)
    String addressLine2;

    @Column(nullable = false)
    int deliveryType = 0; // 0: 직배송 + 택배배송, 1: 직배송, 2: 택배배송

    String fax;

    String email;

    @Transient
    String ownerUsername;

    @Transient
    String ownerFullname;

    @Transient
    String ownerPhone;

    @ManyToOne
    @JoinColumn(name="deliverer_id", nullable = false)
    @JsonManagedReference(value = "deliver_shops")
    User deliverer;

    @ManyToOne
    @JoinColumn(name="salesman_id")
    @JsonManagedReference(value = "sales_shops")
    User salesman;

    @OneToOne
    @JoinColumn(name="owner_id")
    @JsonManagedReference
    ShopOwner shopOwner;

    @ManyToOne
    @JoinColumn(name="price_group_id")
    @JsonManagedReference
    PriceGroup priceGroup;

    @ManyToOne
    @JoinColumn(name="shop_grade_id")
    @JsonBackReference
    ShopGrade shopGrade;

    String paymentMethod = "credit"; // credit, prepaid

    boolean isCreditBalanceLimit = false;

    Long creditBalanceLimit;

    boolean businessLicense = true;

    boolean dealStatus = true;

    @Column(columnDefinition = "TEXT")
    String memo;

    @Column(nullable = false)
    Long prevTotalBalance = 0L;

    @ManyToOne
    @JoinColumn(name="assignee_type_id")
    AssigneeType assigneeType;

    @CreationTimestamp
    @Column(updatable = false)
    @JsonFormat(pattern="yyyy-MM-dd hh:mm:ss")
    private LocalDateTime createdAt;

    @UpdateTimestamp
    @JsonIgnore
    private LocalDateTime updatedAt;

    private LocalDateTime stoppedAt;

    private LocalDateTime dealtAt;

    @OneToMany(mappedBy = "shop")
    @JsonBackReference(value = "shop")
    private Set<Order> orders;

    @ManyToMany(mappedBy = "shops")
    @JsonManagedReference
    private Set<Notice> notices;

    @OneToMany(mappedBy = "shop")
    @JsonIgnore
    private Set<Transaction> transactions;

    @OneToMany(mappedBy = "shop")
    @JsonIgnore
    private Set<ShopProductPrice> shopPrices;

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

    public String getErpCode() {
        return erpCode;
    }

    public void setErpCode(String erpCode) {
        this.erpCode = erpCode;
    }

    public Business getBusiness() {
        return business;
    }

    public void setBusiness(Business business) {
        this.business = business;
    }

    public String getZipCode() {
        return zipCode;
    }

    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
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

    public String getOwnerUsername() {
        return ownerUsername;
    }

    public void setOwnerUsername(String ownerUsername) {
        this.ownerUsername = ownerUsername;
    }

    public String getOwnerFullname() {
        return ownerFullname;
    }

    public void setOwnerFullname(String ownerFullname) {
        this.ownerFullname = ownerFullname;
    }

    public String getOwnerPhone() {
        return ownerPhone;
    }

    public void setOwnerPhone(String ownerPhone) {
        this.ownerPhone = ownerPhone;
    }

    public User getDeliverer() {
        return deliverer;
    }

    public void setDeliverer(User deliverer) {
        this.deliverer = deliverer;
    }

    public User getSalesman() {
        return salesman;
    }

    public void setSalesman(User salesMan) {
        this.salesman = salesMan;
    }

    public ShopOwner getShopOwner() {
        return shopOwner;
    }

    public void setShopOwner(ShopOwner shopOwner) {
        this.shopOwner = shopOwner;
    }

    public PriceGroup getPriceGroup() {
        return priceGroup;
    }

    public void setPriceGroup(PriceGroup priceGroup) {
        this.priceGroup = priceGroup;
    }

    public ShopGrade getShopGrade() {
        return shopGrade;
    }

    public void setShopGrade(ShopGrade shopGrade) {
        this.shopGrade = shopGrade;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public boolean getIsCreditBalanceLimit() {
        return isCreditBalanceLimit;
    }

    public void setIsCreditBalanceLimit(boolean creditBalanceLimit) {
        isCreditBalanceLimit = creditBalanceLimit;
    }

    public Long getCreditBalanceLimit() {
        return creditBalanceLimit;
    }

    public void setCreditBalanceLimit(Long creditBalanceLimit) {
        this.creditBalanceLimit = creditBalanceLimit;
    }

    public boolean getBusinessLicense() {
        return businessLicense;
    }

    public void setBusinessLicense(boolean businessLicense) {
        this.businessLicense = businessLicense;
    }

    public AssigneeType getAssigneeType() {
        return assigneeType;
    }

    public void setAssigneeType(AssigneeType assigneeType) {
        this.assigneeType = assigneeType;
    }

    public boolean getDealStatus() {
        return dealStatus;
    }

    public void setDealStatus(boolean dealStatus) {
        this.dealStatus = dealStatus;
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

    public Set<Notice> getNotices() {
        return notices;
    }

    public void setNotices(Set<Notice> notices) {
        this.notices = notices;
    }

    public LocalDateTime getStoppedAt() {
        return stoppedAt;
    }

    public void setStoppedAt(LocalDateTime stopedAt) {
        this.stoppedAt = stopedAt;
    }

    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }

    public int getDeliveryType() {
        return deliveryType;
    }

    public void setDeliveryType(int deliveryType) {
        this.deliveryType = deliveryType;
    }

    public Set<Transaction> getTransactions() {
        return transactions;
    }

    public void setTransactions(Set<Transaction> transactions) {
        this.transactions = transactions;
    }

    public Set<ShopProductPrice> getShopPrices() {
        return shopPrices;
    }

    public void setShopPrices(Set<ShopProductPrice> shopPrices) {
        this.shopPrices = shopPrices;
    }

    public double getTotalBalance() {
        Iterator<Transaction> iterator = this.transactions.iterator();
        double total = 0.0;
        while (iterator.hasNext()) {
            Transaction transaction = iterator.next();
            total += transaction.getFunds();
        }
        return total;
    }

    public double getTotalInput() {
        Iterator<Transaction> iterator = this.transactions.iterator();
        double total = 0L;
        while (iterator.hasNext()) {
            Transaction transaction = iterator.next();
            if (transaction.getTransactionType().equalsIgnoreCase("input"))
                total += transaction.getFunds();
        }
        return total;
    }

    public double getTotalUpdate() {
        Iterator<Transaction> iterator = this.transactions.iterator();
        double total = 0.0;
        while (iterator.hasNext()) {
            Transaction transaction = iterator.next();
            if (transaction.getTransactionType().equalsIgnoreCase("update"))
                total += transaction.getFunds();
        }
        return total;
    }

    public double getTotalSales() {
        Iterator<Transaction> iterator = this.transactions.iterator();
        double total = 0.0;
        while (iterator.hasNext()) {
            Transaction transaction = iterator.next();
            if (transaction.getTransactionType().equalsIgnoreCase("sale"))
                total += transaction.getFunds();
        }
        return total;
    }

    public Long getPrevTotalBalance() {
        return prevTotalBalance;
    }

    public void setPrevTotalBalance(Long prevTotalBalance) {
        this.prevTotalBalance = prevTotalBalance;
    }

    public LocalDateTime getDealtAt() {
        return dealtAt;
    }

    public void setDealtAt(LocalDateTime dealtAt) {
        this.dealtAt = dealtAt;
    }

    public Set<Order> getOrders() {
        return orders;
    }

    public void setOrders(Set<Order> orders) {
        this.orders = orders;
    }
}
