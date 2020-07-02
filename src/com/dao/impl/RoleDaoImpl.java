package com.dao.impl;

import com.dao.RoleDao;
import com.domain.Role;
import orm.SqlSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class RoleDaoImpl implements RoleDao {

    private SqlSession sqlSession = new SqlSession();

    @Override
    public List<Role> selectRoles(Map<String,Object> params) {
        StringBuilder sql = new StringBuilder("SELECT * FROM T_ROLE WHERE 1=1 ");
        Integer rno = (Integer) params.get("rno");
        if(rno != null){
            sql.append(" AND RNO=#{rno} ");
        }
        String rname = (String) params.get("rname");
        if(rname != null && !"".equals(rname)){
            //后模糊查询
            sql.append(" AND RNAME LIKE CONCAT(#{rname},'%') ");
        }
        String description = (String) params.get("description");
        if(description != null && !"".equals(description)){
            //前后模糊查询
            sql.append(" AND DESCRIPTION LIKE CONCAT('%',CONCAT(#{description},'%')) ");
        }
        Integer start = (Integer) params.get("start");
        Integer length = (Integer) params.get("length");
        sql.append(" LIMIT #{start},#{length}");
//        System.out.println(sql.toString());
//        System.out.println("中国");

        List<Role> roleList = sqlSession.selectList(sql.toString(), params,Role.class);
        return roleList;
    }

    public Integer totalRecord(Map<String, Object> params) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM T_ROLE WHERE 1=1");
        Integer rno = (Integer) params.get("rno");
        if(rno != null){
            sql.append(" AND RNO=#{rno}");
        }
        String rname = (String) params.get("rname");
        if(rname != null && !"".equals(rname)){
            //后模糊查询
            sql.append(" AND RNAME LIKE CONCAT(#{rname},'%')");
        }
        String description = (String) params.get("description");
        if(description != null && !"".equals(description)){
            //前后模糊查询
            sql.append(" AND DESCRIPTION LIKE CONCAT('%',CONCAT(#{description},'%'))");
        }
        Integer totalRecord = sqlSession.selectOne(sql.toString(), params,Integer.class);
        return totalRecord;
    }

    @Override
    public void deleteAllMenusByRno(int rno) {
        String sql = "DELETE FROM T_ROLE_MENU WHERE RNO=#{rno}";
        sqlSession.delete(sql,rno);
    }

    public void addMenuToRole(int rno, int mno) {
        String sql = "INSERT INTO T_ROLE_MENU VALUES(#{rno},#{mno})";
        Map<String, Integer> param = new HashMap<>();
        param.put("rno", rno);
        param.put("mno", mno);
        sqlSession.insert(sql,param);
    }

    public List<Integer> findMenusByRno(int rno) {
        return sqlSession.selectList("SELECT MNO FROM T_ROLE_MENU WHERE RNO=#{rno}", rno, Integer.class);
    }
}
