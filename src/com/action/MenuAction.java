package com.action;

import com.domain.Menu;
import com.service.impl.MenuServiceImpl;
import mymvc.Param;
import mymvc.RequestMapping;
import mymvc.ResponseBody;

import java.util.List;

public class MenuAction {

    private MenuServiceImpl service = MenuServiceImpl.getMenuService();

    @RequestMapping("menuList.do")
    @ResponseBody
    public List<Menu> menuList(){
        return service.getMenuList();
    }

    @RequestMapping("saveMenu.do")
    @ResponseBody
    public int saveMenu(Menu menu){
        return service.addMenu(menu);
    }

    @RequestMapping("findOneMenu.do")
    @ResponseBody
    public Menu findOneMenu(@Param("mno") Integer mno) {
        return service.findOneMenuByMno(mno);
    }

    @RequestMapping("updateMenu.do")
    public void updateMenu(Menu menu){
        service.updateMenu(menu);
    }

    @RequestMapping("deleteMenu.do")
    public void deleteMenu(@Param("mno")Integer mno){
        service.deleteMenuByMno(mno);
    }

    @RequestMapping("userMenus.do")
    public List<Menu> userMenus(@Param("uno") int uno){
        return service.getUserMenusByUno(uno);
    }
}
