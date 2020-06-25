package com.action;

import com.domain.Menu;
import com.service.impl.MenuServiceImpl;
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
}
