package com.service;

import com.domain.Role;

import java.util.List;

public interface RoleService {
    List<Role> getRoleList(Integer page,Integer rows,Integer rno,String rname,String description);

    Integer getTotalRecord(Integer rno,String rname,String description);
}
