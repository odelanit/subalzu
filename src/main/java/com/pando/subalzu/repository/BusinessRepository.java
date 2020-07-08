package com.pando.subalzu.repository;

import com.pando.subalzu.model.Business;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BusinessRepository extends JpaRepository<Business, Long> {
    Business findByName(String name);
}
