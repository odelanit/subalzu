package com.pando.subalzu.repository;

import com.pando.subalzu.model.Order;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.time.LocalDateTime;
import java.util.List;

public interface OrderRepository extends JpaRepository<Order, Long>, JpaSpecificationExecutor<Order> {
    Long countByReleaseStatus(String releaseStatus);

    List<Order> findByCreatedAtBetween(LocalDateTime createdAt, LocalDateTime createdAt2);
}
