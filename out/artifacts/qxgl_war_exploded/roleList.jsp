<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
    <head>

    </head>
    <body>
        <div id="roleListBox">
            <h2 align="center">角色列表</h2>
            <table>
                <thead>
                    <tr>
                        <th>全选<input type="checkbox"></th>
                        <th>角色编号</th>
                        <th>角色名称</th>
                        <th>角色描述</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${roleList}" var="role">
                        <tr>
                            <td><input type="checkbox"></td>
                            <td>${role.rno}</td>
                            <td>${role.rname}</td>
                            <td>${role.description}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </body>
</html>