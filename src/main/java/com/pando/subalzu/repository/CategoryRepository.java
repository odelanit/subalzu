package com.pando.subalzu.repository;

import com.pando.subalzu.model.Category;
import org.hibernate.boot.model.source.spi.Sortable;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

public interface CategoryRepository extends JpaRepository<Category, Long> {

    List<Category> findByParentNull(Sort sort);

    List<Category> findByParentNull();

    Optional<Category> findByName(String name);

    List<Category> findByParent(Category category);

    @Query("SELECT c from Category c WHERE c.useIndividual = true ORDER BY c.id")
    List<Category> getCategoriesByUseIndividualTrue();
}
