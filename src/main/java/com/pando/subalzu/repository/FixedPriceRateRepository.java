package com.pando.subalzu.repository;

import com.pando.subalzu.model.Category;
import com.pando.subalzu.model.FixedPriceRate;
import com.pando.subalzu.model.PriceGroup;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface FixedPriceRateRepository extends JpaRepository<FixedPriceRate, Long> {
    Optional<FixedPriceRate> findByCategoryAndPriceGroup(Category category, PriceGroup priceGroup);
}
