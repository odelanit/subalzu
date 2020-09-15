package com.pando.subalzu.model;

import com.fasterxml.jackson.annotation.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "users")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true)
    private String username;

    @Column(nullable = false)
    @JsonIgnore
    private String password;

    @Column(nullable = false)
    private String phone;

    @Column(nullable = false, columnDefinition = "NVARCHAR(64)")
    private String fullName;

    @Column(columnDefinition = "TEXT")
    private String bio;

    private boolean enabled;

    @CreationTimestamp
    @Column(updatable = false)
    private LocalDateTime createdAt;

    @UpdateTimestamp
    private LocalDateTime updatedAt;

    @Transient
    @JsonIgnore
    private String passwordConfirm;

    @ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinTable(name = "users_roles", joinColumns = @JoinColumn(name = "users_id"), inverseJoinColumns = @JoinColumn(name = "roles_id"))
    @JsonIgnore
    private Set<Role> roles;

    @ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JsonIgnore
    private Set<Permission> permissions;

    @OneToMany(mappedBy = "salesman")
    @JsonIgnore
    private Set<Shop> salesShops;

    @OneToMany(mappedBy = "deliverer")
    @JsonIgnore
    private Set<Shop> deliverShops;

    @OneToMany(mappedBy = "deliverer")
    @JsonBackReference(value = "deliverer")
    Set<Order> deliverOrders;

    @OneToMany(mappedBy = "salesMan")
    @JsonBackReference(value = "salesman")
    Set<Order> salesOrders;

    @OneToMany(mappedBy = "user")
    @JsonBackReference
    Set<SupplyOrder> supplyOrders;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPasswordConfirm() {
        return passwordConfirm;
    }

    public void setPasswordConfirm(String passwordConfirm) {
        this.passwordConfirm = passwordConfirm;
    }

    public Set<Role> getRoles() {
        return roles;
    }

    public void setRoles(Set<Role> roles) {
        this.roles = roles;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getBio() {
        return bio;
    }

    public void setBio(String bio) {
        this.bio = bio;
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

    public Set<Shop> getSalesShops() {
        return salesShops;
    }

    public void setSalesShops(Set<Shop> salesShops) {
        this.salesShops = salesShops;
    }

    public Set<Shop> getDeliverShops() {
        return deliverShops;
    }

    public void setDeliverShops(Set<Shop> deliverShops) {
        this.deliverShops = deliverShops;
    }

    public Set<Order> getDeliverOrders() {
        return deliverOrders;
    }

    public void setDeliverOrders(Set<Order> deliverOrders) {
        this.deliverOrders = deliverOrders;
    }

    public Set<Order> getSalesOrders() {
        return salesOrders;
    }

    public void setSalesOrders(Set<Order> salesOrders) {
        this.salesOrders = salesOrders;
    }

    public Set<SupplyOrder> getSupplyOrders() {
        return supplyOrders;
    }

    public void setSupplyOrders(Set<SupplyOrder> supplyOrders) {
        this.supplyOrders = supplyOrders;
    }

    public boolean getEnabled() {
        return enabled;
    }

    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }

    public Set<Permission> getPermissions() {
        return permissions;
    }

    public void setPermissions(Set<Permission> permissions) {
        this.permissions = permissions;
    }

    public boolean isDeliverer() {
        for (Role role : this.roles) {
            if (role.getName().equalsIgnoreCase("deliverer"))
                return true;
        }
        return false;
    }

    public boolean isSalesman() {
        for (Role role : this.roles) {
            if (role.getName().equalsIgnoreCase("sales"))
                return true;
        }
        return false;
    }
}
