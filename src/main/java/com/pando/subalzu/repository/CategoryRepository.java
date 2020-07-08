package com.pando.subalzu.repository;

import com.pando.subalzu.model.Category;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CategoryRepository extends JpaRepository<Category, Long> {
}
