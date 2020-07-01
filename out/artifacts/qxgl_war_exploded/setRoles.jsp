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
            #linkBox ul>li{
                padding: 5px;
                cursor: pointer;
            }
            #linkBox ul>li:hover{
                background-color: rgba(0,140,140,0.5);
            }
            #tip{
                height: 30px;
                margin-bottom: 6px;
                margin-left: 250px;
            }
            #linkBox #unlinkedRoles{
                width: 256px;
                height:350px;
                background-color: whitesmoke;
                border-radius: 10px;
                color: #008c8c;
                float:left;
            }
            #linkBox #linkedRoles{
                width: 256px;
                height:350px;
                background-color: whitesmoke;
                border-radius: 10px;
                color: #008c8c;

                float:right;
            }
            h4{
                margin: 15px auto;
            }
            #btns{
                width: 95px;
                float:left;

            }
            #btns button{
                width: 90px;
                margin-top:100px;
                margin-left: 45px;
            }

        </style>
        <script src="js/jquery-3.5.1.min.js"></script>
        <script>
            $(function () {
                //jquery入口函数

                //ajax（post）请求寻找未分配的角色
                $.post('findUnlinkedRoles.do',{'uno':$('#uno').val()},function (roles) {
                    //把角色装进ul里
                    var ul = $('#unlinkedRoles ul');
                    for (var i = 0; i < roles.length; i++) {
                        //alert(roles.length);
                        var role = roles[i];
                        ul.append('<li rno="'+role.rno+'">' + role.rname + '</li>');

                    }

                    //添加双击‘右移’事件
                    addDblclickToRight();
                },'json');

                //ajax请求寻找已经分配的角色
                $.ajax({
                    url:'findLinkedRoles.do',
                    data:{uno: $('#uno').val()},
                    type:'post',
                    dataType: 'json',
                    success:function (roles) {
                        var ul = $('#linkedRoles ul');
                        for (var i = 0; i < roles.length; i++) {
                            var role = roles[i];
                            ul.append('<li rno="'+role.rno+'">'+role.rname+'</li>')
                        }

                        //添加双击‘左移’事件
                        addDblclickToLeft();
                    },
                    error:function () {
                        alert('error');
                    }
                });

                //给 全部赋予>> 按钮添加事件
                $('#allToRight').click(function (){
                    $('#unlinkedRoles ul li').appendTo($('#linkedRoles ul'));

                    //给右边每个li重新添加双击‘左移’事件
                    addDblclickToLeft();
                });
                //给 <<全部移除 按钮添加事件
                $('#allToLeft').click(function () {
                    $('#linkedRoles ul li').appendTo($('#unlinkedRoles ul'));

                    //给左边每个li重新添加双击‘右移’事件
                    addDblclickToRight();
                });

                //给保存按钮添加事件
                $('#saveBtn').click(function () {
                    //获取右边li里的每个rno属性值 即要分配的所有角色编号 最终用逗号拼接成一个字符串，发送给后台
                    var lis = $('#linkedRoles ul li');
                    var rnos = '';
                    lis.each(function (i,e) {
                        var rno = $(e).attr('rno');
                        rnos += rno + ',';
                    });
                    $.post('setRoles.do',{'uno':$('#uno').val(),'rnos':rnos},function () {
                        alert('保存成功！');
                    });
                });
            });

            //函数：双击赋予角色（去右边展示）
            function addDblclickToRight () {
                $('#unlinkedRoles ul li').off('dblclick').dblclick(function () {
                    $(this).appendTo($('#linkedRoles ul'));

                    //给右边每个li重新添加双击‘左移’事件
                    addDblclickToLeft();
                });
            }
            //函数：双击移除角色（去左边展示）
            function addDblclickToLeft() {
                $('#linkedRoles ul li').off('dblclick').dblclick(function () {
                    $(this).appendTo($('#unlinkedRoles ul'));

                    //给左边每个li重新添加双击‘右移’事件
                    addDblclickToRight();
                });
            }
        </script>
    </head>
    <body>
        <input type="hidden" id="uno" value="${param.uno}">
        <div id="linkBox">
            <h2 align="center" style="margin: 10px">给【${param.truename}】分配角色</h2>
            <div id="tip">(双击角色项可以单个移动)</div>
            <div id="unlinkedRoles">
                <h4 align="center">未分配的角色</h4>
                <ul>
<%--                    <li>系统管理员</li>--%>
<%--                    <li>普通管理员</li>--%>
                </ul>
            </div>
            <div id="btns">
                <button id="allToRight" type="button">全部赋予&gt;&gt;</button>
                <button id="allToLeft" type="button">&lt;&lt;全部移除</button>
                <button id="saveBtn" type="button">保存</button>
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