package com.service;

import com.domain.User;

import java.util.List;

public interface UserService {
    User checkLogin(String uname,String upass);
    List<User> getAllUser();

    void addUser(User user);

    void userDelete(Integer uno);

    User findUserById(Integer uno);
}
