<%@ page pageEncoding="UTF-8" %>
<!doctype html>
<html>
    <head>
        <style>
            #linkBox{
                width: 690px;
                height: 490px;
                margin: 30px auto;
                border-radius: 35px;
                padding: 10px 100px;
                background-color: rgba(0,140,140,0.8);
                color: whitesmoke;
            }
            #linkBox #unlinkedRoles{
                width: 266px;
                height:390px;
                background-color: whitesmoke;
                border-radius: 10px;
                color: #008c8c;
                float:left;
            }
            #linkBox #linkedRoles{
                width: 266px;
                height:390px;
                background-color: whitesmoke;
                border-radius: 10px;
                color: #008c8c;

                float:right;
            }
            #btns{
                width: 95px;
                float:left;

            }
            #btns button{
                width: 90px;
                margin-top:115px;
                margin-left: 35px;
            }

        </style>
        <script src="js/jquery-3.5.1.min.js"></script>
        <script>
            $(function () {
                //jquery入口
                //ajax请求寻找未分配的角色
                $.post('findUnlinkedRoles.do',{'uno':$('#uno').val()},function (roles) {
                    //把角色装进ul里
                    var ul = $('#unlinkedRoles ul');
                    for (var i = 0; i < roles.length; i++) {
                        //alert(roles.length);
                        var role = roles[i];
                        ul.append('<li>' + role.rname + '</li>');
                    }
                },'json');
            });
        </script>
    </head>
    <body>
        <input type="hidden" id="uno" value="${param.uno}">
        <div id="linkBox">
            <h2 align="center">给【${param.truename}】分配角色</h2>
            <div id="unlinkedRoles">
                <h4 align="center">未分配的角色</h4>
                <ul>
<%--                    <li>系统管理员</li>--%>
<%--                    <li>普通管理员</li>--%>
                </ul>
            </div>
            <div id="btns">
                <button type="button">全部赋予&gt;&gt;</button>
                <button type="button">&lt;&lt;全部移除</button>
            </div>
            <div id="linkedRoles">
                <h4 align="center">已拥有的角色</h4>
                <ul>
<%--                    <li>库管员</li>--%>
                </ul>
            </div>
        </div>
    </body>
</html>