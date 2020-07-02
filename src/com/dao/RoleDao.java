package com.dao;

import com.domain.Role;

import java.util.List;
import java.util.Map;

public interface RoleDao {
    List<Role> selectRoles(Map<String,Object> params);

    Integer totalRecord(Map<String, Object> params);

    void deleteAllMenusByRno(int rno);

    void addMenuToRole(int rno, int mno);

    List<Integer> findMenusByRno(int rno);
}
