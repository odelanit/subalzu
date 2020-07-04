package com.pando.subalzu.repository;

import com.pando.subalzu.model.Permission;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PermissionRepository extends JpaRepository<Permission, Long> {
    Permission findByName(String name);
}
