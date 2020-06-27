package com.dao;

import com.domain.Menu;
import orm.annotation.Delete;
import orm.annotation.Insert;
import orm.annotation.Select;
import orm.annotation.Update;

import java.util.List;

public interface MenuDao {
    @Select("SELECT * FROM T_MENU")
    List<Menu> menuList();

    @Insert("INSERT INTO T_MENU VALUES(NULL,#{mname},#{mhref},#{mtarget},#{pno},#{yl1},#{yl2})")
    void addMenu(Menu menu);

    @Select("SELECT MNO FROM T_MENU WHERE MNAME=#{mname}")
    int findIdByMname(String mname);


    @Select("SELECT * FROM T_MENU WHERE MNO=#{mno}")
    Menu selectOneMenuByMno(Integer mno);

    @Update("UPDATE T_MENU SET MNAME=#{mname},MHREF=#{mhref},MTARGET=#{mtarget} WHERE MNO=#{mno}")
    void updateOneMenu(Menu menu);


    @Delete("DELETE FROM T_MENU WHERE MNO=#{mno}")
    void deleteOneMenu(Integer mno);
}
