package com.pando.subalzu.repository;

import com.pando.subalzu.model.Product;
import com.pando.subalzu.model.Shop;
import com.pando.subalzu.model.ShopProductPrice;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface ShopProductPriceRepository extends JpaRepository<ShopProductPrice, Long> {
    Optional<ShopProductPrice> findByShopAndProduct(Shop shop, Product product);
}
