package com.pando.subalzu.specification;

import com.pando.subalzu.model.Order;
import org.springframework.data.jpa.domain.Specification;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

public class OrderSpecification implements Specification<Order> {

    private final SearchCriteria criteria;

    public OrderSpecification(SearchCriteria criteria) {
        this.criteria = criteria;
    }

    @Override
    public Predicate toPredicate(Root<Order> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
        if (criteria.getOperation().equalsIgnoreCase(":")) {
            if (criteria.getKey().equalsIgnoreCase("shopName")) {
                return criteriaBuilder.like(root.get("shop").get("name"), "%" + criteria.getValue() + "%");
            } else if(criteria.getKey().equalsIgnoreCase("orderStatus")) {
                return criteriaBuilder.equal(root.get(criteria.getKey()), criteria.getValue());
            } else if(criteria.getKey().equalsIgnoreCase("releaseStatus")) {
                return criteriaBuilder.equal(root.get(criteria.getKey()), criteria.getValue());
            } else {
                if (root.get(criteria.getKey()).getJavaType() == String.class) {
                    return criteriaBuilder.like(root.<String>get(criteria.getKey()), "%" + criteria.getValue() + "%");
                } else {
                    return criteriaBuilder.equal(root.get(criteria.getKey()), criteria.getValue());
                }
            }
        }
        return null;
    }
}
