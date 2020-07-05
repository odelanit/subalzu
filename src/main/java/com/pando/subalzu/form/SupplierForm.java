package com.pando.subalzu.form;

import com.pando.subalzu.model.Supplier;
import com.pando.subalzu.model.User;

public class SupplierForm {

    User user;

    Supplier supplier;

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Supplier getSupplier() {
        return supplier;
    }

    public void setSupplier(Supplier supplier) {
        this.supplier = supplier;
    }
}
