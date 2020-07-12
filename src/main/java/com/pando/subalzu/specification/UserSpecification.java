package com.pando.subalzu.specification;

import com.pando.subalzu.model.Shop;
import com.pando.subalzu.model.User;
import org.springframework.data.jpa.domain.Specification;

import javax.persistence.criteria.*;

public class UserSpecification implements Specification<User> {

    private final SearchCriteria criteria;

    public UserSpecification(SearchCriteria criteria) {
        this.criteria = criteria;
    }

    @Override
    public Predicate toPredicate(Root<User> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder builder) {
        if (criteria.getOperation().equalsIgnoreCase(":")) {
            if (criteria.getKey().equalsIgnoreCase("shopName")) {
                if (criteria.getValue() == null || criteria.getValue().isEmpty()) {
                    return builder.like(root.<String>get("username"), "%%");
                } else {
                    return builder.like(root.<Shop>get("ownShop").get("name"), "%" + criteria.getValue() + "%");
                }
            } else {
                if (root.get(criteria.getKey()).getJavaType() == String.class) {
                    return builder.like(root.<String>get(criteria.getKey()), "%" + criteria.getValue() + "%");
                } else {
                    return builder.equal(root.get(criteria.getKey()), criteria.getValue());
                }
            }
        }
        return null;
    }
}
