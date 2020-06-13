package com.pando.subalzu.service;

import com.pando.subalzu.model.User;

public interface UserService {
    void save(User user);

    User findByUsername(String username);
}
