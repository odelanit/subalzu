package com.pando.subalzu.repository;

import com.pando.subalzu.model.PriceGroup;
import com.pando.subalzu.model.Product;
import com.pando.subalzu.model.ProductPrice;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface ProductPriceRepository extends JpaRepository<ProductPrice, Long> {
    Optional<ProductPrice> getByProductAndPriceGroup(Product product, PriceGroup priceGroup);

    List<ProductPrice> findByProduct(Product product);
}
