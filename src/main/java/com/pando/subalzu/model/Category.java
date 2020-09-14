package com.pando.subalzu.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.Set;

@Entity
@Table(name = "categories")
public class Category {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;

    private int level = 0;

    private boolean useIndividual;

    @ManyToOne
    @JoinColumn(name="parent_id")
    @JsonBackReference
    private Category parent;

    @OneToMany(mappedBy = "parent", cascade = CascadeType.REMOVE)
    @JsonManagedReference
    private Set<Category> children;

    @OneToMany(mappedBy = "category", cascade = CascadeType.REMOVE)
    @JsonIgnore
    Set<Product> products;

    @OneToMany(mappedBy = "subCategory", cascade = CascadeType.REMOVE)
    @JsonIgnore
    Set<Product> products_of_subcategory;

    @OneToMany(mappedBy = "category", cascade = CascadeType.REMOVE)
    @JsonIgnore
    Set<FixedPriceRate> fixedPriceRates;

    @CreationTimestamp
    private LocalDateTime createdAt;

    @UpdateTimestamp
    private LocalDateTime updatedAt;

    public Category() {
    }

    public Category(String name) {
        this.name = name;
    }

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

    public boolean getUseIndividual() {
        return useIndividual;
    }

    public void setUseIndividual(boolean usedIndividual) {
        this.useIndividual = usedIndividual;
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

    public int getLevel() {
        return level;
    }

    public void setLevel(int level) {
        this.level = level;
    }

    public Category getParent() {
        return parent;
    }

    public void setParent(Category parent) {
        this.parent = parent;
    }

    public Set<Category> getChildren() {
        return children;
    }

    public void setChildren(Set<Category> children) {
        this.children = children;
    }

    public Set<Product> getProducts() {
        return products;
    }

    public void setProducts(Set<Product> products) {
        this.products = products;
    }

    public Set<FixedPriceRate> getFixedPriceRates() {
        return fixedPriceRates;
    }

    public void setFixedPriceRates(Set<FixedPriceRate> fixedPriceRates) {
        this.fixedPriceRates = fixedPriceRates;
    }

    public Set<Product> getProducts_of_subcategory() {
        return products_of_subcategory;
    }

    public void setProducts_of_subcategory(Set<Product> products_of_subcategory) {
        this.products_of_subcategory = products_of_subcategory;
    }
}
