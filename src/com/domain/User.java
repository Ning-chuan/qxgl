package com.domain;

import java.util.List;

public class User {
    private Integer uno;
    private String uname;
    private String upass;
    private String truename;
    private Integer age;
    private String sex;
    private String phone;
    private String yl1;
    private String yl2;

    private List<Role> roleList;//用户有哪些角色

    public User() {
    }

    public User(Integer uno, String uname, String upass, String truename, Integer age, String sex, String phone) {
        this.uno = uno;
        this.uname = uname;
        this.upass = upass;
        this.truename = truename;
        this.age = age;
        this.sex = sex;
        this.phone = phone;
    }

    public Integer getUno() {
        return uno;
    }

    public void setUno(Integer uno) {
        this.uno = uno;
    }

    public String getUname() {
        return uname;
    }

    public void setUname(String uname) {
        this.uname = uname;
    }

    public String getUpass() {
        return upass;
    }

    public void setUpass(String upass) {
        this.upass = upass;
    }

    public String getTruename() {
        return truename;
    }

    public void setTruename(String truename) {
        this.truename = truename;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getYl1() {
        return yl1;
    }

    public void setYl1(String yl1) {
        this.yl1 = yl1;
    }

    public String getYl2() {
        return yl2;
    }

    public void setYl2(String yl2) {
        this.yl2 = yl2;
    }

    public List<Role> getRoleList() {
        return roleList;
    }

    public void setRoleList(List<Role> roleList) {
        this.roleList = roleList;
    }
}