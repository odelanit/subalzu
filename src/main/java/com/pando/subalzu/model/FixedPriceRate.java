package com.pando.subalzu.model;

import javax.persistence.*;

@Entity
@Table(name = "fixed_price_rates")
public class FixedPriceRate {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "category_id")
    Category category;

    @ManyToOne
    @JoinColumn(name = "price_group_id")
    PriceGroup priceGroup;

    String unit = "p"; // p: %, w: 원

    Double rate = 0.0;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public PriceGroup getPriceGroup() {
        return priceGroup;
    }

    public void setPriceGroup(PriceGroup priceGroup) {
        this.priceGroup = priceGroup;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public Double getRate() {
        return rate;
    }

    public void setRate(Double rate) {
        this.rate = rate;
    }
}
