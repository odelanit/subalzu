package com.pando.subalzu.repository;

import com.pando.subalzu.model.Supplier;
import com.pando.subalzu.model.SupplierTransaction;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

public interface SupplierTransactionRepository extends JpaRepository<SupplierTransaction, Long>, JpaSpecificationExecutor<SupplierTransaction> {

    @Query("SELECT SUM(funds) FROM Transaction")
    Long sumAmount();

    @Query("SELECT SUM(t.amount) FROM SupplierTransaction t WHERE t.type = 'update'")
    Long sumUpdateAmount();

    @Query("SELECT SUM(t.amount) FROM SupplierTransaction t WHERE t.type = 'output'")
    Long sumOutputAmount();

    @Query("SELECT SUM(t.amount) FROM SupplierTransaction t WHERE t.type = 'order'")
    Long sumOrderAmount();

    @Query("SELECT SUM(t.amount) FROM SupplierTransaction t WHERE t.supplier = :supplier")
    Long sumSupplierAmount(Supplier supplier);
}
