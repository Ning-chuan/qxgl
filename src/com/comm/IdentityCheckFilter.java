package com.comm;

import com.domain.Menu;
import com.domain.User;
import com.service.MenuService;
import com.service.impl.MenuServiceImpl;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

//@WebFilter("*.do")
//public class IdentityCheckFilter extends HttpFilter {
//
//    @Override
//    public void doFilter(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws IOException, ServletException {
//        response.setContentType("test/html;charset=utf-8");
//        //获取请求名
//        //                  /roleList.do            roleList.do
//        String url = request.getServletPath().replace("/","");
//        if(url.indexOf("login.do") != -1){
//            //说明此次是登录请求 不必拦截
//            filterChain.doFilter(request,response);
//            return;
//        }
//
//        HttpSession session = request.getSession();
//        User loginUser = (User) session.getAttribute("loginUser");
//        if(loginUser == null){
//            response.getWriter().write("<script>alert('尚未登录，请登录');location.href = 'index.jsp'</script>");
//            return;
//        }
//
//        List<Menu> menuList = (List<Menu>) session.getAttribute("menuList");
//        for(Menu menu : menuList){
//            if(menu.getMhref()!=null && !"".equals(menu.getMhref()) && menu.getMhref().indexOf(url) != -1){
//                //说明该请求是菜单里的请求
//
//                //找到当前登录用户的菜单列表
//                List<Menu> userMenus = (List<Menu>) session.getAttribute("userMenus");
//                for(Menu userMenu : userMenus){
//                    if(userMenu.getMhref()!=null && !"".equals(userMenu.getMhref()) && userMenu.getMhref().indexOf(url) != -1){
//                        //说明该用户拥有的菜单里的请求包含此次请求 验证通过 可以放行
//                        filterChain.doFilter(request,response);
//                        return;
//                    }
//                }
//
//                //上面循环结束 没有返回 说明当前用户所拥有的菜单的请求里并不包含此次请求 即验证不通过 不能放行
//                response.getWriter().write("<script>alert('没有该权限，请联系管理员！');</script>");
//                return;
//            }
//
//        }
//        //循环结束 一直没有返回 说明此次请求不是菜单对应的请求 不需要验证 直接放行
//        filterChain.doFilter(request,response);
//
//
//    }
//}