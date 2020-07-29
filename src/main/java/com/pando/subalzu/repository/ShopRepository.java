package com.pando.subalzu.repository;

import com.pando.subalzu.model.Shop;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ShopRepository extends JpaRepository<Shop, Long>, JpaSpecificationExecutor<Shop> {

    @Query("SELECT s.id, s.name FROM Shop s WHERE s.name LIKE %:keyword%")
    List<Object> getShopsIdAndNameByName(String keyword);

    @Query("SELECT SUM(prevTotalBalance) FROM Shop")
    Long sumPrevTotal();

    @Query("SELECT SUM(s.totalSales) FROM Shop s")
    Long sumTotalSales();
}
