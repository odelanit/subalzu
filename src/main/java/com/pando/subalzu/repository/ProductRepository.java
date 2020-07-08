package com.pando.subalzu.repository;

import com.pando.subalzu.model.Product;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProductRepository extends JpaRepository<Product, Long> {
}
