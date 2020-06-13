package com.pando.subalzu.service;

public interface SecurityService {
    String findLoggedInUsername();

    void autoLogin(String username, String password);
}
