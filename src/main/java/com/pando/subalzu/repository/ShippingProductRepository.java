package com.pando.subalzu.repository;

import com.pando.subalzu.model.SupplyOrderProduct;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ShippingProductRepository extends JpaRepository<SupplyOrderProduct, Long> {
}
