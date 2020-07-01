package com.dao;

import com.domain.Role;
import com.domain.User;
import orm.annotation.Delete;
import orm.annotation.Insert;
import orm.annotation.Select;
import orm.annotation.Update;

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

    @Update("UPDATE T_USER SET UNAME=#{uname},TRUENAME=#{truename},AGE=#{age},SEX=#{sex},PHONE=#{phone} WHERE(UNO=#{uno})")
    void userUpdate(User user);

    @Select("SELECT * FROM T_ROLE WHERE RNO NOT IN (SELECT RNO FROM T_USER_ROLE WHERE UNO=#{uno})")
    List<Role> selectUnlinkedRoles(int uno);

    @Select("SELECT * FROM T_ROLE WHERE RNO IN (SELECT RNO FROM T_USER_ROLE WHERE UNO=#{uno})")
    List<Role> selectLinkedRoles(int uno);

    @Delete("DELETE FROM T_USER_ROLE WHERE UNO=#{uno}")
    void deleteAllRoles(int uno);

    @Insert("INSERT INTO T_USER_ROLE VALUES(#{uno},#{rno})")
    void addUserRole(Map<String, Integer> param);
}
