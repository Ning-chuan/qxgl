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

    public void setMenusToRole(int rno, String mnos) {
        //1.删该角色之前拥有的菜单
        roleDao.deleteAllMenusByRno(rno);
        //2.给该角色添加本次传递的菜单
        if(mnos == null || "".equals(mnos)) return;//说明此次没有选中任何菜单
        String[] mnoArray = mnos.split(",");
        for(String mno : mnoArray){
            roleDao.addMenuToRole(rno,Integer.parseInt(mno));
        }
    }

    @Override
    public List<Integer> getOwnMenusByRno(int rno) {
        return roleDao.findMenusByRno(rno);
    }
}
