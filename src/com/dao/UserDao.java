package com.dao;

import com.domain.User;
import orm.annotation.Select;

import java.util.List;
import java.util.Map;

public interface UserDao {

    @Select("SELECT * FROM T_USER WHERE UNAME=#{uname} AND UPASS=#{upass}")
    User findUserByNameAndPass(Map<String,String> params);

    @Select("SELECT * FROM T_USER")
    List<User> selectAllUser();
}
