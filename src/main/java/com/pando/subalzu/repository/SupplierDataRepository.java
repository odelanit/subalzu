package com.pando.subalzu.repository;

import com.pando.subalzu.model.Supplier;
import org.springframework.data.jpa.datatables.mapping.DataTablesOutput;
import org.springframework.data.jpa.datatables.repository.DataTablesRepository;

public interface SupplierDataRepository extends DataTablesRepository<Supplier, Long> {
//    DataTablesOutput<Supplier> findAllByCompanyId(long id);
}
