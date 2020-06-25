package com.service.impl;

import com.dao.MenuDao;
import com.domain.Menu;
import com.service.MenuService;
import orm.SqlSession;

import java.util.List;

public class MenuServiceImpl implements MenuService {

    //单例模式
    private MenuServiceImpl(){}
    private static final MenuServiceImpl menuService = new MenuServiceImpl();
    public static MenuServiceImpl getMenuService(){
        return menuService;
    }

    private MenuDao dao = new SqlSession().getMapper(MenuDao.class);

    @Override
    public List<Menu> getMenuList() {
        return dao.menuList();
    }
}
