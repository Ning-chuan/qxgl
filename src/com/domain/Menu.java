package com.domain;

import java.util.List;

public class Menu {
    private Integer mno;
    private String mname;
    private String mhref;
    private String target;
    private Integer pno;//父级菜单编号


    private Menu parent;//父级菜单对象
    private List<Menu> children;//子菜单列表

    public Menu() {
    }

    public Menu(Integer mno, String mname, String mhref, String target) {
        this.mno = mno;
        this.mname = mname;
        this.mhref = mhref;
        this.target = target;
    }

    public Integer getMno() {
        return mno;
    }

    public void setMno(Integer mno) {
        this.mno = mno;
    }

    public String getMname() {
        return mname;
    }

    public void setMname(String mname) {
        this.mname = mname;
    }

    public String getMhref() {
        return mhref;
    }

    public void setMhref(String mhref) {
        this.mhref = mhref;
    }

    public String getTarget() {
        return target;
    }

    public void setTarget(String target) {
        this.target = target;
    }

    public Integer getPno() {
        return pno;
    }

    public void setPno(Integer pno) {
        this.pno = pno;
    }

    public Menu getParent() {
        return parent;
    }

    public void setParent(Menu parent) {
        this.parent = parent;
    }

    public List<Menu> getChildren() {
        return children;
    }

    public void setChildren(List<Menu> children) {
        this.children = children;
    }
}
