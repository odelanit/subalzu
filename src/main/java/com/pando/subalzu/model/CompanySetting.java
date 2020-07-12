package com.pando.subalzu.model;

import com.fasterxml.jackson.annotation.JsonBackReference;

import javax.persistence.*;

@Entity
@Table(name = "company_settings")
public class CompanySetting {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    boolean fixedPriceRate = false;

    boolean categoryPopup = true;

    @OneToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "company_id", nullable = false)
    @JsonBackReference
    private Company company;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public boolean getFixedPriceRate() {
        return fixedPriceRate;
    }

    public void setFixedPriceRate(boolean fixedPriceRate) {
        this.fixedPriceRate = fixedPriceRate;
    }

    public Company getCompany() {
        return company;
    }

    public void setCompany(Company company) {
        this.company = company;
    }

    public boolean getCategoryPopup() {
        return categoryPopup;
    }

    public void setCategoryPopup(boolean categoryPopup) {
        this.categoryPopup = categoryPopup;
    }
}
