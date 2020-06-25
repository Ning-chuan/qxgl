package com.dao;

import com.domain.Menu;
import orm.annotation.Select;

import java.util.List;

public interface MenuDao {
    @Select("SELECT * FROM T_MENU")
    List<Menu> menuList();
}
