package com.pando.subalzu.repository;

import com.pando.subalzu.model.CartItem;
import com.pando.subalzu.model.Product;
import com.pando.subalzu.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface CartItemRepository extends JpaRepository<CartItem, Long> {
    Optional<CartItem> findByUserAndProduct(User user, Product product);

    List<CartItem> findByUser(User user);
}
