package com.pando.subalzu.repository;

import com.pando.subalzu.model.ShopOwner;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface ShopOwnerRepository extends JpaRepository<ShopOwner, Long> {
    Optional<ShopOwner> findByUsername(String username);
}
