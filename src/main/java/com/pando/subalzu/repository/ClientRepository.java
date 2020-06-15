package com.pando.subalzu.repository;

import com.pando.subalzu.model.Client;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ClientRepository extends JpaRepository<Client, Long> {
}
