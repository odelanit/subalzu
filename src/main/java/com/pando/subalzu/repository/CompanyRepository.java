package com.pando.subalzu.repository;

import com.pando.subalzu.model.Company;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface CompanyRepository extends JpaRepository<Company, Long> {
    Optional<Company> findByUserUsername(String username);
}
