package com.pando.subalzu.repository;

import com.pando.subalzu.model.Order;
import com.pando.subalzu.model.User;
import org.springframework.data.jpa.datatables.repository.DataTablesRepository;

public interface OrderDataRepository extends DataTablesRepository<Order, Long> {
}
