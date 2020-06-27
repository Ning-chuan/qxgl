package com.service;

import com.domain.Menu;

import java.util.List;

public interface MenuService {
    List<Menu> getMenuList();

    int addMenu(Menu menu);

    Menu findOneMenuByMno(Integer mno);

    void updateMenu(Menu menu);

    void deleteMenuByMno(Integer mno);
}
