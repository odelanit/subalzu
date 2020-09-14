package com.pando.subalzu.specification;

import com.pando.subalzu.model.OrderProduct;
import com.pando.subalzu.model.Product;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.util.Pair;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.time.LocalDateTime;
import java.util.Date;

public class OrderProductSpecification implements Specification<OrderProduct> {
    private final SearchCriteria criteria;

    public OrderProductSpecification(SearchCriteria criteria) {
        this.criteria = criteria;
    }

    @Override
    public Predicate toPredicate(Root<OrderProduct> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
        if (criteria.getOperation().equalsIgnoreCase(":")) {
            String key = criteria.getKey();
            if (key.contains("_")) {
                String[] keyStrings = key.split("_");
                if (keyStrings.length == 2) {
                    String key0 = keyStrings[0];
                    String key1 = keyStrings[1];
                    if (root.get(key0).get(key1).getJavaType() == String.class) {
                        return criteriaBuilder.like(root.get(key0).get(key1), "%" + criteria.getValue() + "%");
                    } else {
                        return criteriaBuilder.equal(root.get(key0).get(key1), criteria.getValue());
                    }
                } else if (keyStrings.length == 3) {
                    String key0 = keyStrings[0];
                    String key1 = keyStrings[1];
                    String key2 = keyStrings[2];
                    if (root.get(key0).get(key1).get(key2).getJavaType() == String.class) {
                        return criteriaBuilder.like(root.get(key0).get(key1).get(key2), "%" + criteria.getValue() + "%");
                    } else {
                        return criteriaBuilder.equal(root.get(key0).get(key1).get(key2), criteria.getValue());
                    }
                }

            } else {
                if (root.get(criteria.getKey()).getJavaType() == String.class) {
                    return criteriaBuilder.like(root.<String>get(criteria.getKey()), "%" + criteria.getValue() + "%");
                } else {
                    return criteriaBuilder.equal(root.get(criteria.getKey()), criteria.getValue());
                }
            }
        } else if (criteria.getOperation().equalsIgnoreCase("<>")) {
            String key = criteria.getKey();
            if (key.contains("_")) {
                String[] keyStrings = key.split("_");
                String key0 = keyStrings[0];
                String key1 = keyStrings[1];
                if (root.get(key0).get(key1).getJavaType() == LocalDateTime.class) {
                    Pair<LocalDateTime, LocalDateTime> dateTimePair = (Pair<LocalDateTime, LocalDateTime>) criteria.getValue();
                    LocalDateTime startDate = dateTimePair.getFirst();
                    LocalDateTime endDate = dateTimePair.getSecond();
                    return criteriaBuilder.between(root.get(key0).get(key1), (startDate), (endDate));
                } else if (root.get(key0).get(key1).getJavaType() == Date.class) {
                    Pair<Date, Date> dateTimePair = (Pair<Date, Date>) criteria.getValue();
                    Date startDate = dateTimePair.getFirst();
                    Date endDate = dateTimePair.getSecond();
                    return criteriaBuilder.between(root.get(key0).get(key1), (startDate), (endDate));
                }
                else {
                    return null;
                }
            } else {
                return null;
            }
        }
        return null;
    }
}
