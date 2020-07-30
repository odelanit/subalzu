package com.pando.subalzu.repository;

import com.pando.subalzu.model.OrderProduct;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface OrderProductRepository extends JpaRepository<OrderProduct, Long>, JpaSpecificationExecutor<OrderProduct> {
}
