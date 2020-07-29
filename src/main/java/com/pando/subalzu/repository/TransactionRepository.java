package com.pando.subalzu.repository;

import com.pando.subalzu.model.Shop;
import com.pando.subalzu.model.Transaction;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

public interface TransactionRepository extends PagingAndSortingRepository<Transaction, Long>, JpaSpecificationExecutor<Transaction> {
    @Query("SELECT SUM(amount) FROM Transaction")
    Long sumAmount();

    @Query("SELECT SUM(t.amount) FROM Transaction t WHERE t.transactionType = 'update'")
    Long sumUpdateAmount();

    @Query("SELECT SUM(t.amount) FROM Transaction t WHERE t.transactionType = 'input'")
    Long sumInputAmount();

    @Query("SELECT SUM(t.amount) FROM Transaction t WHERE t.shop = :shop")
    Long sumShopAmount(Shop shop);
}
