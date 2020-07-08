package com.pando.subalzu.repository;

import com.pando.subalzu.model.Shop;
import org.springframework.data.jpa.datatables.repository.DataTablesRepository;

public interface ShopDataRepository extends DataTablesRepository<Shop, Long> {
}
