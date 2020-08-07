package com.pando.subalzu.repository;

import com.pando.subalzu.model.Shop;
import com.pando.subalzu.model.Transaction;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

public interface TransactionRepository extends PagingAndSortingRepository<Transaction, Long>, JpaSpecificationExecutor<Transaction> {
    @Query("SELECT SUM(funds) FROM Transaction")
    Long sumAmount();

    @Query("SELECT SUM(t.funds) FROM Transaction t WHERE t.transactionType = 'update'")
    Long sumUpdateAmount();

    @Query("SELECT SUM(t.funds) FROM Transaction t WHERE t.transactionType = 'input'")
    Long sumInputAmount();

    @Query("SELECT SUM(t.funds) FROM Transaction t WHERE t.shop = :shop")
    Double sumShopAmount(Shop shop);
}
