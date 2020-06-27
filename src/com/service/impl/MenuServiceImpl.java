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

    @Override
    public int addMenu(Menu menu) {
        dao.addMenu(menu);
        return dao.findIdByMname(menu.getMname());
    }

    @Override
    public Menu findOneMenuByMno(Integer mno) {
        return dao.selectOneMenuByMno(mno);
    }

    public void updateMenu(Menu menu) {
        dao.updateOneMenu(menu);
    }

    @Override
    public void deleteMenuByMno(Integer mno) {
        List<Menu> menuList = getMenuList();
        deleteMenu(mno,menuList);
    }
    private void deleteMenu(Integer mno,List<Menu> menuList){
        for (int i = 0; i < menuList.size(); i++) {
            Menu menu = menuList.get(i);
            if(menu.getPno() == mno){
                deleteMenu(menu.getMno(),menuList);
            }
        }
        dao.deleteOneMenu(mno);
    }
}
