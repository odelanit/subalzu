package com.pando.subalzu.specification;

import com.pando.subalzu.model.SupplierTransaction;
import com.pando.subalzu.model.Transaction;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.util.Pair;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.time.LocalDateTime;

public class SupplierTransactionSpecification implements Specification<SupplierTransaction> {
    private final SearchCriteria criteria;

    public SupplierTransactionSpecification(SearchCriteria criteria) {
        this.criteria = criteria;
    }

    @Override
    public Predicate toPredicate(Root<SupplierTransaction> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
        if (criteria.getOperation().equalsIgnoreCase(":")) {
            if (root.get(criteria.getKey()).getJavaType() == String.class) {
                return criteriaBuilder.like(root.<String>get(criteria.getKey()), "%" + criteria.getValue() + "%");
            } else {
                return criteriaBuilder.equal(root.get(criteria.getKey()), criteria.getValue());
            }
        } else if (criteria.getOperation().equalsIgnoreCase("<>")) {
            if (root.get(criteria.getKey()).getJavaType() == LocalDateTime.class) {
                Pair<LocalDateTime, LocalDateTime> dateTimePair = (Pair<LocalDateTime, LocalDateTime>) criteria.getValue();
                LocalDateTime startDate = dateTimePair.getFirst();
                LocalDateTime endDate = dateTimePair.getSecond();
                return criteriaBuilder.between(root.<LocalDateTime>get(criteria.getKey()), (startDate), (endDate));
            } else {
                return null;
            }
        }
        return null;
    }
}
