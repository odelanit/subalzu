package com.pando.subalzu.repository;

import com.pando.subalzu.model.User;
import org.springframework.data.jpa.datatables.repository.DataTablesRepository;

public interface UserDataRepository extends DataTablesRepository<User, Long> {
}
