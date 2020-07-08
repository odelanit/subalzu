package com.pando.subalzu.repository;

import com.pando.subalzu.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface UserRepository extends JpaRepository<User, Long>, JpaSpecificationExecutor<User> {
    User findByUsername(String username);

    @Query("SELECT u FROM User u JOIN u.roles r WHERE r.name=:roleName")
    List<User> findByRoleName(String roleName);
}
