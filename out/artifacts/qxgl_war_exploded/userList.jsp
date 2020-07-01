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

                //实现全选功能
                //1.获取全选按钮
                var allSelectEle = document.getElementById('allSelect');
                //  获取tbody下的input标签
                var inputs = tbody.getElementsByTagName('input');
                //2.给全选按钮绑定事件
                allSelectEle.onclick = function () {
                    //3.循环把每一个勾选框的状态设置为全选按钮的状态
                    for(var i = 0;i < inputs.length;i++){
                        //赋值之前做一个严谨的判断（本页面可以省略此判断）
                        if(inputs[i].type == 'checkbox')inputs[i].checked = this.checked;
                    }
                }
                //完善全选功能，即实现以下两个需求：
                //  1.手动点击实现全选时，全选框的状态应该是选中状态
                //  2.只要有一个勾选框不为选中状态，全选框也不应该为选中状态
                for(var i = 0;i < inputs.length;i++){
                    //给每一个普通勾选框都绑定点击事件
                    inputs[i].onclick = function () {
                        //点击时查看每一个普通勾选框的勾选状态
                        for(var j = 0;j < inputs.length;j++){
                            if(!inputs[j].checked){
                                //只要发现有一个勾选框没有选中 就把全选框状态设置为false
                                allSelectEle.checked = false;
                                //直接返回（不需要继续遍历，后面的语句也不需要执行了）
                                return;
                            }
                        }
                        //如果循环结束都没有返回 说明所有勾选框都为选中状态
                        allSelectEle.checked = true;
                    }
                }

                //点击数据行时勾选复选框
                for (var i = 0;i < tbodyRows.length;i++){
                    var row = tbodyRows[i];
                    //点击数据行时勾选复选框
                    row.onclick = function () {
                        var checkBoxEle = this.getElementsByTagName('input')[0];
                        checkBoxEle.checked = ! checkBoxEle.checked;

                    }
                    //取消勾选框的事件冒泡 （避免bug）
                    var checkBoxEle = row.getElementsByTagName('input')[0];
                    checkBoxEle.onclick = function (event) {
                        var e = window.event || event;
                        e.stopPropagation();
                    }
                }
            }

            //定义一个是否确认删除的函数  点击删除连接时会调用此函数
            function confirmDelete(uno){
                var res = confirm('确认删除该用户吗？');
                if(!res)return;
                location.href = 'deleteUser.do?uno='+uno;
            }

            function deleteUsers(){
                var unos = '';
                var tbody = document.getElementById("userTableBody");
                // 获取tbody下的input标签(所有勾选框)
                var inputs = tbody.getElementsByTagName('input');
                //遍历所有勾选框
                for(var i = 0;i < inputs.length;i++){
                    //如果勾选框时选中状态 找到其对应的用户编号 追加到unos上
                    if(inputs[i].checked){
                        var uno = inputs[i].parentElement.nextElementSibling.innerHTML;
                        unos += uno+',';
                    }
                    //console.log(unos);测试语句
                }
                if(unos == ''){
                    alert('您尚未选择记录。')
                }else{
                    var res = confirm('确认删除这些用户吗？');
                    if(!res)return;
                    //发送请求
                    location.href = 'deleteUsers.do?unos='+unos;
                }
            }
        </script>
    </head>
    <body>
        <h2 align="center" style="margin-top: 40px">用户列表</h2>
        <p align="center">
            <a href="addUser.jsp">新建用户</a> |
            <a href="javascript:deleteUsers()">批量删除</a> |
            <a href="importUsers.jsp">批量导入</a>
        </p>
        <table border="1" width="75%" align="center" cellspacing="0">
            <thead>
            <tr>
                <th>全选<input id="allSelect" type="checkbox"></th>
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
                        <td><input type="checkbox"></td>
                        <td>${user.uno}</td>
                        <td>${user.uname}</td>
                        <td>${user.upass}</td>
                        <td>${user.truename}</td>
                        <td>${user.age}</td>
                        <td>${user.sex}</td>
                        <td>${user.phone}</td>
                        <td>
                            <a href="javascript:confirmDelete(${user.uno})">删除</a>|
                            <a href="editUser.do?uno=${user.uno}">编辑</a>|
                            <a href="setRoles.jsp?uno=${user.uno}&truename=${user.truename}">分配角色</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </body>
</html>