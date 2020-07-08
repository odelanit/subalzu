package com.pando.subalzu.repository;

import com.pando.subalzu.model.Product;
import org.springframework.data.jpa.datatables.repository.DataTablesRepository;

public interface ProductDataRepository extends DataTablesRepository<Product, Long> {
}
