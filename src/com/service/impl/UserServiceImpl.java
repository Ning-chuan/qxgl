package com.service.impl;

import com.dao.UserDao;
import com.domain.Role;
import com.domain.User;
import com.service.UserService;
import orm.SqlSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class UserServiceImpl implements UserService {

    //单列模式
    private UserServiceImpl(){}
    private static final UserServiceImpl userService = new UserServiceImpl();
    public static UserServiceImpl getUserService(){
        return userService;
    }

    private UserDao userDao = new SqlSession().getMapper(UserDao.class);

    @Override
    public User checkLogin(String uname,String upass) {
        Map<String,String> params = new HashMap<>();
        params.put("uname", uname);
        params.put("upass", upass);
        return userDao.findUserByNameAndPass(params);
    }

    public List<User> getAllUser(){
        return userDao.selectAllUser();
    }

    public void addUser(User user){
        userDao.userAdd(user);
    }

    @Override
    public void userDelete(Integer uno) {
        userDao.userDelete(uno);
    }

    public User findUserById(Integer uno){
        return userDao.selectUserById(uno);
    }

    public void userUpdate(User user){
        userDao.userUpdate(user);
    }

    @Override
    public List<Role> findUnlinkedRolesByUno(int uno) {
        return userDao.selectUnlinkedRoles(uno);
    }

    @Override
    public List<Role> findLinkedRolesByUno(int uno) {
        return userDao.selectLinkedRoles(uno);
    }

    @Override
    public void setRolesToUser(int uno, String rnos) {
        //删除之前的角色
        userDao.deleteAllRoles(uno);
        //添加现在的角色
        if(rnos == null || "".equals(rnos)){
            return;
        }
        String[] rnoArray = rnos.split(",");
        for(String rno : rnoArray){
            Map<String, Integer> param = new HashMap<>();
            param.put("uno", uno);
            param.put("rno", Integer.parseInt(rno));
            userDao.addUserRole(param);
        }
    }
}
