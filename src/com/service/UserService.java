package com.service;

import com.domain.User;

import java.util.List;

public interface UserService {
    User checkLogin(String uname,String upass);
    List<User> getAllUser();
}
