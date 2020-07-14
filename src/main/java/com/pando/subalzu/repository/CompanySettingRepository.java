package com.pando.subalzu.repository;

import com.pando.subalzu.model.CompanySetting;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface CompanySettingRepository extends JpaRepository<CompanySetting, Long> {
    Optional<CompanySetting> findByCompany_Id(Long id);
}
