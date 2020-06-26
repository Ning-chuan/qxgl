<%@ page pageEncoding="UTF-8" %>
<!doctype html>
<html>
    <head>
        <style>
            ul li{
                list-style:none;
                margin:6px 0px;

            }
            ul li span{
                cursor:pointer;
            }
            ul li span:hover{
                background-color: rgba(0,140,140,0.5);
            }
            ul:first-child{
                margin-top: 50px;
                margin-left:100px;
            }
        </style>
        <script src="js/jquery-3.5.1.min.js"></script>
        <script>
            $(function () {
                //使用jQuery封装的函数发送ajax请求
                $.post(
                    'menuList.do',
                    {uname:'zhangsan',upass:'333'},
                    function (data) {
                        //将data中装载的菜单信息显示在页面上
                        //data中的菜单信息是独立存放的
                        //但我们希望可以按照子父关系显示
                        //我们就需要一层一层的显示
                        //如果要将第一层菜单显示完整
                        //就必须先将第二层菜单显示完整。
                        //* 第一层菜单不仅包括自己的信息，还包括子菜单信息
                        //如果要将第二层菜单显示完整，就必须先将第三层显示完整
                        //无论显示哪一层菜单，显示机制都是一样
                        //所以需要递归

                        //在指定的位置显示某一层的子菜单
                        function showOneChildMenu (pno,$position) {
                            var ul = $('<ul>');
                            $position.append(ul);// 将ul装入指定的父级标签
                            //遍历所有菜单 找到父菜单的子菜单
                            for (var i = 0; i < data.length; i++) {
                                var menu = data[i];
                                if(menu.pno == pno){
                                    //找到之后创建li>span展示
                                    var li = $('<li>');
                                    ul.append(li);
                                    var span = $('<span>'+menu.mname+'</span>');
                                    li.append(span);
                                    //展示完毕之后递归调用此方法 寻找当前菜单的子菜单展示
                                    showOneChildMenu(menu.mno,li);
                                }
                            }
                        };
                        showOneChildMenu(-1,$('body'));

                        //菜单栏的展开和合并
                        $('li>span').click(function () {
                            //span的下一个ul绑定：
                            $(this).next().slideToggle(500);//1秒完成上下滑动展开
                        });
                    },
                    'json'
                );
            });
        </script>
    </head>
    <body>
    <%--
        <ul>
            <li>
                <span>权限管理</span>
                <ul>
                    <li>
                        <span>用户管理</span>
                    </li>
                    <li><span>角色管理</span></li>
                    <li><span>菜单管理</span></li>
                </ul>
            </li>
            <li><span>基本信息管理</span></li>
            <li><span>系统管理</span></li>
        </ul>
    --%>
    </body>
</html>
