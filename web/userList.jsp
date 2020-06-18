<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <style>
            table tr{
                height: 30px;
            }
        </style>
        <script>
            window.onload = function () {
                var tbody = document.getElementById("userTableBody");
                var tbodyRows = tbody.getElementsByTagName("tr");
                //斑马条纹
                for(var i = 0;i < tbodyRows.length;i++){
                    var row = tbodyRows[i];
                    if(i%2 != 0) {
                        row.style.background = '#acc8d3';
                    }
                }
                //鼠标移动时背景处理
                for(var i = 0;i < tbodyRows.length;i++){
                    tbodyRows[i].onmouseenter = function () {
                        var oldColor = this.style.background;
                        this.style.background = "#e2b382";
                        this.onmouseleave = function () {
                            this.style.background = oldColor;
                        }
                    }
                }
            }

            function confirmDelete(uno){
                var res = confirm('确认删除该用户吗？');
                if(!res)return;
                location.href = 'deleteUser.do?uno='+uno;
            }
        </script>
    </head>
    <body>
        <h2 align="center" style="margin-top: 40px">用户列表</h2>
        <p align="center"><a href="addUser.jsp">新建用户</a></p>
        <table border="1" width="75%" align="center" cellspacing="0">
            <thead>
            <tr>
                <th>用户编号</th>
                <th>用户账号</th>
                <th>用户密码</th>
                <th>真实姓名</th>
                <th>用户年龄</th>
                <th>用户性别</th>
                <th>用户电话</th>
                <th>操作选项</th>
            </tr>
            </thead>
            <tbody id="userTableBody">
                <c:forEach items="${userList}" var="user">
                    <tr align="center">
                        <td>${user.uno}</td>
                        <td>${user.uname}</td>
                        <td>${user.upass}</td>
                        <td>${user.truename}</td>
                        <td>${user.age}</td>
                        <td>${user.sex}</td>
                        <td>${user.phone}</td>
                        <td>
                            <a href="javascript:confirmDelete(${user.uno})">删除</a>
                            |
                            <a href="editUser.do?uno=${user.uno}">编辑</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </body>
</html>