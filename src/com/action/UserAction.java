package com.action;

import com.domain.User;
import com.service.UserService;
import com.service.impl.UserServiceImpl;
import mymvc.*;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.poi.ss.usermodel.*;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.io.InputStream;
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

    @RequestMapping("addUser.do")
    @ResponseBody
    public String addUser(User user){
        service.addUser(user);
        return "添加成功";
    }

    //批量导入（添加）
    @RequestMapping("importUsers.do")
    public String importUsers(HttpServletRequest request) throws FileUploadException, IOException {
        //获取上传的文件
        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        List<FileItem> fileItems = upload.parseRequest(request);
        //本次请求只上传了一个文件 可以直接获取
        FileItem fileItem = fileItems.get(0);
        //通过文件元素获取输入流 之后就可以通过输入流获取文件内容了
        InputStream is = fileItem.getInputStream();

        //接下来通过poi解析获取excel表格数据
        Workbook workbook = WorkbookFactory.create(is);//jvm版的excel文件
        Sheet sheet = workbook.getSheetAt(0);//数据表
        //遍历表中的行（第0行是列名）
        for (int i = 1; i <= sheet.getLastRowNum(); i++) {
            Row row = sheet.getRow(i);
            if(row == null)continue;//严谨性判断
            //获取每个单元格对象
            Cell c1 = row.getCell(0);
            Cell c2 = row.getCell(1);
            Cell c3 = row.getCell(2);
            Cell c4 = row.getCell(3);
            Cell c5 = row.getCell(4);
            Cell c6 = row.getCell(5);
            Cell c7 = row.getCell(6);
            Cell c8 = row.getCell(7);
            //通过单元格对象获取单元格内的数据
            String uname = c1.getStringCellValue();
            String upass = (int)c2.getNumericCellValue() + "";
            String truename = c3.getStringCellValue();
            int age = (int) c4.getNumericCellValue();
            String sex = c5.getStringCellValue();
            String phone = (int) c6.getNumericCellValue() + "";
            String yl1 = null;
            String yl2 = null;
            if(c7 != null) {
                yl1 = c7.getStringCellValue();
            }
            if(c8 != null) {
                yl2 = c8.getStringCellValue();
            }
            //通过获取的数据组成User对象
            User user = new User(null,uname,upass,truename,age,sex,phone,yl1,yl2);
            //调用service层方法 添加到数据库
            service.addUser(user);
        }
        return "userList.do";
    }

    @RequestMapping("deleteUser.do")
    @ResponseBody
    public String deleteUser(@Param("uno")Integer uno){
        System.out.println(uno);
        service.userDelete(uno);
        return "删除成功";
    }

    //批量删除
    @RequestMapping("deleteUsers.do")
    public String deleteUsers(@Param("unos")String unos){
        String[] unoArray = unos.split(",");
        for (int i = 0; i < unoArray.length; i++) {
            service.userDelete(Integer.parseInt(unoArray[i]));
        }
        return "userList.do";
    }

    @RequestMapping("editUser.do")
    public ModelAndView editUser(@Param("uno")Integer uno){
        User user = service.findUserById(uno);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("userEdit.jsp");
        mv.addAttribute("user",user);
        return mv;
    }


    @RequestMapping("updateUser.do")
    public String updateUser(User user){
        service.userUpdate(user);
        //修改成功后转到用户列表页面展示修改后的信息
        return "userList.do";
    }
}
