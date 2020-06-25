<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
    <head>
        <style>
            table tr{
                height: 30px;
            }
            #roleListBox{
                margin-top: 30px;
            }
            #keywordsSearchBtns input{
                width: 110px;
            }
        </style>
        <script>
            window.onload = function () {
                var tbody = document.getElementById("roleTableBody");
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

                //行数（下拉列表）改变时重新查角色列表
                var rowsSelectEle = document.getElementById('rows');
                rowsSelectEle.onchange = function () {
                    getRoleList();
                }

                //给每一个关键词输入框绑定'回车事件'
                var searchBtns = document.getElementById('keywordsSearchBtns');
                var inputs = searchBtns.getElementsByTagName('input');
                for (var i = 0; i < inputs.length; i++) {
                    inputs[i].onkeydown = function (e) {
                        var e = e || window.event;
                        if(e.keyCode == 13){
                            getRoleList();
                        }
                    }
                }

                var clearBtnEle = document.getElementById('clearBtn');
                clearBtnEle.onclick = function () {
                    document.getElementById('rno').value = '';
                    document.getElementById('rname').value = '';
                    document.getElementById('description').value = '';
                    getRoleList();
                }
            }

            //定义一个是否确认删除的函数  点击删除连接时会调用此函数
            function confirmDelete(uno){
                var res = confirm('确认删除该用户吗？');
                if(!res)return;
                location.href = 'deleteUser.do?uno='+uno;
            }

            //函数：用于发送获取角色列表的请求
            function getRoleList () {
                //1.获取查询时所有可能的条件
                var rows = document.getElementById('rows').value;
                var page = document.getElementById('page').value;
                var rno = document.getElementById('rno').value;
                var rname = document.getElementById('rname').value;
                var description = document.getElementById('description').value;
                //2.拼接条件作为参数交给服务器
                location.href = 'roleList.do?rows='+rows+'&page='+page+'&rno='+rno+'&rname='+rname+'&description='+description;
            }

            //函数：通过页码查询（首页/上一页/下一页/尾页）
            function findByPage(page) {
                document.getElementById('page').value = page;
                getRoleList();
            }
        </script>
    </head>
    <body>
        <div id="roleListBox">
            <h2 align="center">角色列表</h2>
            <%-- 模糊查询输入框表格 --%>
            <table id="keywordsSearchBtns" align="center" width="60%">
                <tr>
                    <td>
                        请输入关键词按回车搜索：
                        <input id="rno" placeholder="角色编号" value="${rno}">
                        <input id="rname" placeholder="角色名称" value="${rname}">
                        <input id="description" placeholder="角色描述" value="${description}">
                        <button id="clearBtn">清空关键词</button>
                    </td>
                </tr>
            </table>
            <%-- 处理每条数据的表格 --%>
            <table border="1" width="60%" align="center" cellspacing="0">
                <thead>
                    <tr>
                        <th>全选<input id="allSelect" type="checkbox"></th>
                        <th>角色编号</th>
                        <th>角色名称</th>
                        <th>角色描述</th>
                        <th>操作选项</th>
                    </tr>
                </thead>
                <tbody id="roleTableBody">
                    <c:forEach items="${roleList}" var="role">
                        <tr align="center">
                            <td><input type="checkbox"></td>
                            <td>${role.rno}</td>
                            <td>${role.rname}</td>
                            <td>${role.description}</td>
                            <td><a href="">删除</a> | <a href="">编辑</a></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <%-- 分页表格 --%>
            <table width="60%" align="center">
                <tr>
                    <td align="left">
                        请选择行数：
                        <select id="rows">
                            <option>3</option>
                            <option>5</option>
                            <option>7</option>
                            <option selected>${rows}</option>
                        </select>
                        <input type="hidden" id="page" value="${page}">
                        第${page}页/共${maxPage}页
                    </td>
                    <td align="right">
                        <c:if test="${page == 1}">
                            首页&nbsp;&nbsp;上一页
                        </c:if>
                        <c:if test="${page != 1}">
                            <a href="javascript:findByPage(1)">首页</a>&nbsp;&nbsp;<a href="javascript:findByPage(${page-1})">上一页</a>
                        </c:if>
                        &nbsp;&nbsp;
                        <c:if test="${page == maxPage}">
                            下一页&nbsp;&nbsp;尾页
                        </c:if>
                        <c:if test="${page != maxPage}">
                            <a href="javascript:findByPage(${page+1})">下一页</a>&nbsp;&nbsp;<a href="javascript:findByPage(${maxPage})">尾页</a>
                        </c:if>
                    </td>
                </tr>
            </table>
        </div>
    </body>
</html>