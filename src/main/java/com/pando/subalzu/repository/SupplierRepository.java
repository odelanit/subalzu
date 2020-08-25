package com.pando.subalzu.repository;

import com.pando.subalzu.model.Supplier;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

import java.util.Optional;

public interface SupplierRepository extends JpaRepository<Supplier, Long>, JpaSpecificationExecutor<Supplier> {
    Optional<Supplier> findByName(String name);

    @Query("SELECT SUM(prevTotalFunds) FROM Supplier ")
    Long sumPrevTotal();
}
