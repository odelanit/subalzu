package com.pando.subalzu.repository;

import com.pando.subalzu.model.CompanyConfig;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface CompanyConfigRepository extends JpaRepository<CompanyConfig, Long> {
    Optional<CompanyConfig> findByKey(String key);
}
