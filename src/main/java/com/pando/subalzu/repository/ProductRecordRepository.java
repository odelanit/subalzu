package com.pando.subalzu.repository;

import com.pando.subalzu.model.ProductRecord;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface ProductRecordRepository extends JpaRepository<ProductRecord, Long>, JpaSpecificationExecutor<ProductRecord> {

}
