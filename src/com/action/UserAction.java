package com.action;

import com.domain.User;
import com.service.UserService;
import com.service.impl.UserServiceImpl;
import mymvc.ModelAndView;
import mymvc.Param;
import mymvc.RequestMapping;
import mymvc.SessionAttributes;

import java.util.List;

@SessionAttributes("loginUser")
public class UserAction {

    private UserService service = UserServiceImpl.getUserService();

    @RequestMapping("login.do")
    public ModelAndView login(@Param("uname")String uname, @Param("upass")String upass){
        User user = service.checkLogin(uname, upass);

        ModelAndView mv = new ModelAndView();
        if(user == null){
            //没有查到 登陆失败 返回登录页面，同时加上错误提示
            mv.setViewName("index.jsp");
            mv.addAttribute("flag",9);
        }else{
            //登陆成功，返回主页面
            mv.setViewName("main.jsp");
            mv.addAttribute("loginUser",user);
        }
        return mv;
    }

    @RequestMapping("userList.do")
    public ModelAndView userList(){
        List<User> userList = service.getAllUser();
        ModelAndView mv = new ModelAndView();
        mv.setViewName("userList.jsp");
        mv.addAttribute("userList",userList);
        return mv;
    }


}
