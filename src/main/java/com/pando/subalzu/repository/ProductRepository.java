package com.pando.subalzu.repository;

import com.pando.subalzu.model.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

public interface ProductRepository extends JpaRepository<Product, Long>, JpaSpecificationExecutor<Product> {
    @Query("SELECT COUNT (p) FROM Product p WHERE p.qty < 0")
    Long countQtyInsufficient();
}
