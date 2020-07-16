package com.pando.subalzu.specification;

import com.pando.subalzu.model.Notice;
import org.springframework.data.jpa.domain.Specification;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

public class NoticeSpecification implements Specification<Notice> {

    private final SearchCriteria criteria;

    public NoticeSpecification(SearchCriteria criteria) {
        this.criteria = criteria;
    }

    @Override
    public Predicate toPredicate(Root<Notice> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
        if (criteria.getOperation().equalsIgnoreCase(":")) {
            Class<?> javaType = root.get(criteria.getKey()).getJavaType();
            if (root.get(criteria.getKey()).getJavaType() == String.class) {
                return criteriaBuilder.like(root.<String>get(criteria.getKey()), "%" + criteria.getValue() + "%");
            } else if (root.get(criteria.getKey()).getJavaType() == boolean.class) {
                boolean value = "true".equalsIgnoreCase((String)criteria.getValue()) || ("false".equalsIgnoreCase((String)criteria.getValue()) ? false : false);
                return criteriaBuilder.equal(root.get(criteria.getKey()), value);
            } else {
                return criteriaBuilder.equal(root.get(criteria.getKey()), criteria.getValue());
            }
        }
        return null;
    }
}
