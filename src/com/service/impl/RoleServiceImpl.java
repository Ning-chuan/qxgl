package com.service.impl;

import com.dao.RoleDao;
import com.dao.impl.RoleDaoImpl;
import com.domain.Role;
import com.service.RoleService;
import orm.SqlSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class RoleServiceImpl implements RoleService {

    private RoleDaoImpl roleDao  = new RoleDaoImpl();

    @Override
    public List<Role> getRoleList(Integer page,Integer rows,Integer rno,String rname,String description) {
        int start = (page-1)*rows;//起始记录
        int length = rows;//每页显示多少记录
        //把所有参数装进一个map里交给dao层处理
        Map<String, Object> params = new HashMap<>();
        params.put("start", start);
        params.put("length", length);
        params.put("rno", rno);
        params.put("rname", rname);
        params.put("description", description);
        return roleDao.selectRoles(params);
    }

    @Override
    public Integer getTotalRecord(Integer rno,String rname,String description) {
        Map<String, Object> params = new HashMap<>();
        params.put("rno", rno);
        params.put("rname", rname);
        params.put("description", description);
        return roleDao.totalRecord(params);
    }

}
