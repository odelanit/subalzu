package com.pando.subalzu.repository;

import com.pando.subalzu.model.ShopGrade;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ShopGradeRepository extends JpaRepository<ShopGrade, Long> {
    ShopGrade findByName(String name);
}
