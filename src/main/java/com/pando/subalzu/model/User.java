package com.pando.subalzu.model;

import com.fasterxml.jackson.annotation.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import javax.persistence.*;
import java.time.LocalDateTime;
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
    private String password;

    @Column(nullable = false)
    private String phone;

    @Column(nullable = false, columnDefinition = "NVARCHAR(64)")
    private String fullName;

    @Column(columnDefinition = "TEXT")
    private String bio;

    @CreationTimestamp
    @Column(updatable = false)
    private LocalDateTime createdAt;

    @UpdateTimestamp
    private LocalDateTime updatedAt;

    @Transient
    private String passwordConfirm;

    @ManyToMany
    private Set<Role> roles;

    @OneToOne(mappedBy = "user")
    private Company company;

    @OneToMany(mappedBy = "user")
    @JsonBackReference
    private Set<Supplier> suppliers;

    @OneToMany(mappedBy = "salesman")
    @JsonBackReference
    private Set<Shop> salesShops;

    @OneToMany(mappedBy = "deliverer")
    @JsonBackReference
    private Set<Shop> deliverShops;

    @OneToOne(mappedBy = "owner")
    @JsonBackReference
    private Shop ownShop;

    @ManyToMany
    private Set<Permission> permissions;

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

    public Set<Permission> getPermissions() {
        return permissions;
    }

    public void setPermissions(Set<Permission> permissions) {
        this.permissions = permissions;
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

    public Company getCompany() {
        return company;
    }

    public void setCompany(Company company) {
        this.company = company;
    }

    public Set<Supplier> getSuppliers() {
        return suppliers;
    }

    public void setSuppliers(Set<Supplier> suppliers) {
        this.suppliers = suppliers;
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

    public Shop getOwnShop() {
        return ownShop;
    }

    public void setOwnShop(Shop ownShop) {
        this.ownShop = ownShop;
    }

    public void setRole(Role role) {
        Set<Role> roles = new HashSet<>();
        roles.add(role);
        this.roles = roles;
    }

    public void setPermission(Permission permission) {
        Set<Permission> permissions = new HashSet<>();
        permissions.add(permission);
        this.permissions = permissions;
    }
}
