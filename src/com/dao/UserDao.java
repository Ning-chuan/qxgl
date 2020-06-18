package com.dao;

import com.domain.User;
import orm.annotation.Delete;
import orm.annotation.Insert;
import orm.annotation.Select;

import java.util.List;
import java.util.Map;

public interface UserDao {

    @Select("SELECT * FROM T_USER WHERE UNAME=#{uname} AND UPASS=#{upass}")
    User findUserByNameAndPass(Map<String,String> params);

    @Select("SELECT * FROM T_USER")
    List<User> selectAllUser();

    @Insert("INSERT INTO T_USER VALUES(null,#{uname},#{upass},#{truename},#{age},#{sex},#{phone},null,null);")
    void userAdd(User user);

    @Delete("DELETE FROM T_USER WHERE UNO=#{uno}")
    void userDelete(Integer uno);

    @Select("SELECT * FROM T_USER WHERE UNO=#{uno}")
    User selectUserById(Integer uno);
}
