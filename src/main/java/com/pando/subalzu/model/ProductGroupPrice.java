package com.pando.subalzu.model;

import javax.persistence.*;

@Entity
@Table(name = "product_group_prices")
public class ProductGroupPrice {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    int price = 0;

    @ManyToOne
    @JoinColumn(name="product_id")
    Product product;

    @ManyToOne
    @JoinColumn(name="price_group_id")
    PriceGroup priceGroup;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
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
}
