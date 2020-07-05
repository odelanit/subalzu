package com.pando.subalzu.repository;

import com.pando.subalzu.model.Notice;
import org.springframework.data.jpa.datatables.repository.DataTablesRepository;

public interface NoticeDataRepository extends DataTablesRepository<Notice, Long> {
}
