package com.pando.subalzu.repository;

import com.pando.subalzu.model.Company;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CompanyRepository extends JpaRepository<Company, Long> {
}
