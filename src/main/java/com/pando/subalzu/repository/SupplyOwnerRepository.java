package com.pando.subalzu.repository;

import com.pando.subalzu.model.SupplyOwner;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface SupplyOwnerRepository extends JpaRepository<SupplyOwner, Long> {
    Optional<SupplyOwner> getSupplyOwnerByUsername(String username);
}
