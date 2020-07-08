package com.pando.subalzu.repository;

import com.pando.subalzu.model.AssigneeType;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AssigneeTypeRepository extends JpaRepository<AssigneeType, Long> {
    AssigneeType findByName(String name);
}
