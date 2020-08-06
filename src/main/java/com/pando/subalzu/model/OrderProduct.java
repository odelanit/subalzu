package com.pando.subalzu.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;

import javax.persistence.*;

@Entity
@Table(name = "order_products")
public class OrderProduct {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "product_id")
    @JsonManagedReference
    Product product;

    @ManyToOne
    @JoinColumn(name = "price_group_id")
    @JsonManagedReference
    PriceGroup priceGroup;

    @ManyToOne
    @JoinColumn(name = "order_id")
    @JsonBackReference
    Order order;

    @Column(nullable = false)
    Double qty = 0.0;

    @Column(nullable = false)
    Double reQty = 0.0;

    @Column(nullable = false)
    Long price = 0L;

    @Column(nullable = false)
    Double funds = 0.0;

    @Column(nullable = false)
    Double refunds = 0.0;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public PriceGroup getPriceGroup() {
        return priceGroup;
    }

    public void setPriceGroup(PriceGroup priceGroup) {
        this.priceGroup = priceGroup;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public Double getQty() {
        return qty;
    }

    public void setQty(Double qty) {
        this.qty = qty;
    }

    public Double getReQty() {
        return reQty;
    }

    public void setReQty(Double reQty) {
        this.reQty = reQty;
    }

    public Long getPrice() {
        return price;
    }

    public void setPrice(Long price) {
        this.price = price;
    }

    public Double getFunds() {
        return funds;
    }

    public void setFunds(Double funds) {
        this.funds = funds;
    }

    public Double getRefunds() {
        return refunds;
    }

    public void setRefunds(Double reFunds) {
        this.refunds = reFunds;
    }
}
