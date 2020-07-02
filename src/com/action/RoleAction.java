package com.action;

import com.domain.Role;
import com.service.impl.RoleServiceImpl;
import mymvc.ModelAndView;
import mymvc.Param;
import mymvc.RequestMapping;
import mymvc.ResponseBody;
import orm.SqlSession;

import java.util.List;

public class RoleAction {

    private RoleServiceImpl roleService = new RoleServiceImpl();

    @RequestMapping("roleList.do")
    public ModelAndView roleList(@Param("page") Integer page,@Param("rows") Integer rows,@Param("rno")Integer rno, @Param("rname") String rname, @Param("description") String description){
        if(page == null){
            page = 1;//默认显示第一页
        }
        if(rows == null){
            rows = 3;//默认每页显示三行记录
        }
        List<Role> roleList = roleService.getRoleList(page, rows, rno, rname, description);
        Integer totalRecord = roleService.getTotalRecord(rno, rname, description);//获取记录总数 用于计算最大页码
        int maxPage = totalRecord%rows==0 ? totalRecord/rows : totalRecord/rows+1;
        ModelAndView mv = new ModelAndView();
        mv.setViewName("roleList.jsp");
        mv.addAttribute("roleList",roleList);
        mv.addAttribute("page",page);
        mv.addAttribute("rows",rows);
        mv.addAttribute("maxPage",maxPage);
        mv.addAttribute("rno",rno);
        mv.addAttribute("rname",rname);
        mv.addAttribute("description",description);
        return mv;
    }

    @RequestMapping("setMenus.do")
    @ResponseBody
    public void setMenus(@Param("rno") int rno,@Param("mnos")String mnos){
        roleService.setMenusToRole(rno,mnos);
    }

    @RequestMapping("ownMenus.do")
    @ResponseBody
    public List<Integer> ownMenus(@Param("rno") int rno){
        return roleService.getOwnMenusByRno(rno);
    }
}
