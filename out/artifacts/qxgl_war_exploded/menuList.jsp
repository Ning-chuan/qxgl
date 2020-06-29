<%@ page pageEncoding="UTF-8" %>
<!doctype html>
<html>
    <head>
        <style>
            #options{
                margin-top: 20px ;
                margin-left: 20px;
            }
            #menuBox{
                margin-left: 100px;
                margin-top: 30px;
            }
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
            #mname,#mhref,#mtarget{
                width:100px;
                margin-right: 15px;
            }
            #active{
                color: whitesmoke;
                background-color: steelblue;
            }
            ul a{
                padding: 8px;
                margin-right: 5px;
            }
            ul a.open{
                background: url('images/open.png') no-repeat 0 12px;
            }
            ul a.close{
                background: url('images/close.png') no-repeat 0 12px;
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
                                    //下面span添加了一个mno自定义属性 为了后面给其添加子菜单的时候使用
                                    var span = $('<span mno="'+menu.mno+'">'+menu.mname+'</span>');
                                    li.append(span);
                                    //展示完毕之后递归调用此方法 寻找当前菜单的子菜单展示
                                    showOneChildMenu(menu.mno,li);
                                }
                            }
                        };
                        showOneChildMenu(-1,$('#menuBox'));

                        /*
                        //菜单栏的展开和合并
                        $('li>span').click(function () {
                            //span的下一个ul绑定：
                            $(this).next().slideToggle(500);//1秒完成上下滑动展开
                        });
                        */

                        //给span增加点击（选中）状态  点击之后颜色改变
                        $('span').click(function () {
                            $('#active').attr('id','');//清空之前span的选中状态
                            $(this).attr('id', 'active');
                        });

                        //添加双击修改事件
                        addMenuDoubleClick($('span'));

                        //增加展开收起图标
                        $('ul span').before('<a>');
                        //i是索引 e是每一个元素
                        $('li a').each(function (i,e) {
                            var ul = $(e).parent().children('ul');
                            if(ul.children().length > 0){
                                //有子菜单 添加图标 默认是展开
                                $(e).addClass('open');
                            }
                        })
                        $('li a').click(function () {
                            var flag = $(this).attr('class');
                            //alert(flag);
                            if(flag == 'open'){
                                $(this).removeClass('open');
                                $(this).addClass('close');
                                $(this).next().next().toggle('500');
                            }else if(flag == 'close'){
                                $(this).removeClass('close');
                                $(this).addClass('open');
                                $(this).next().next().toggle('500');
                            }
                        });
                    },
                    'json'
                );
            });
            //函数：点击添加根菜单的时候调用
            function addRootMenu () {
                if($('#mname').length != 0){
                    return;
                }
                $('ul:first').append('<li><input id="mname" placeholder="菜单名称"><input id="mhref" placeholder="菜单链接"><input id="mtarget" placeholder="显示位置"><button id="saveBtn">保存</button></li>')
                $('#saveBtn').click(function () {
                    saveMenu(-1);
                });
            }

            //函数：点击添加子菜单时调用
            function addChildMenu () {
                var parentMenu = $('#active');
                if(parentMenu.length == 0){
                    //说明还没有选择菜单
                    alert('请先选择父级菜单。')
                    return;
                }

                if($('#mname').length != 0){
                    //说明已经存在输入框了
                    return;
                }
                var ul = $('#active').next();
                ul.append('<li><input id="mname" placeholder="菜单名称"><input id="mhref" placeholder="菜单链接"><input id="mtarget" placeholder="显示位置"><button id="saveBtn">保存</button></li>')
                $('#saveBtn').click(function () {
                    var pno = $(this).parent().parent().prev().attr('mno');
                    saveMenu(pno);
                });
            }

            //函数：用于保存一个新添加的菜单 需要父级菜单编号作为参数
            function saveMenu (pno) {
                var mname = $('#mname').val();
                var mhref = $('#mhref').val();
                var mtarget = $('#mtarget').val();
                if(mname == ''){
                    alert('请填写菜单名称');
                    return;
                }
                $.ajax({
                    url: 'saveMenu.do',
                    data: {'mname': mname, 'mhref': mhref, 'mtarget': mtarget,'pno':pno},
                    type:'post',
                    success:function (mno) {
                        alert('添加成功')
                        //添加成功之后让其显示在当前菜单列表中
                        //         input  -->  li
                        var li = $('#mname').parent();
                        li.empty().append('<span mno="'+mno+'">' + mname + '</span>');

                        //给新增的span增加点击事件
                        li.children().click(function () {
                            $('#active').attr('id','');//清空之前span的选中状态
                            $(this).attr('id', 'active');
                        });

                        //给新增的span添加点击事件
                        addMenuDoubleClick(li.children());
                    },
                    error:function () {
                        alert('error!')
                    }
                });
            }
            //函数：双击菜单（span）时修改菜单
            function addMenuDoubleClick ($menus) {
                $menus.dblclick(function () {
                    if($('#mname').length != 0){
                        //已经有输入框在操作中了
                        return;
                    }
                    var span = $(this);
                    span.empty();

                    var mno = span.attr('mno');
                    $.post(
                        'findOneMenu.do',
                        {'mno': mno},
                        function (menu) {
                            var mhref = '';
                            if(menu.mhref){
                                mhref = menu.mhref;
                            }
                            var mtarget = '';
                            if(menu.mtarget){
                                mtarget = menu.mtarget;
                            }
                            span.append('<input id="mno" value="' + menu.mno + '" type="hidden" >');
                            span.append('<input id="mname" value="' + menu.mname + '">');
                            span.append('<input id="mhref" value="' + mhref + '">');
                            span.append('<input id="mtarget" value="' + mtarget + '">');
                            span.append('<button id="updateBtn">提交修改</button>');
                            $('#updateBtn').click(function () {
                                var mno = $('#mno').val();
                                var mname = $('#mname').val();
                                var mhref = $('#mhref').val();
                                var mtarget = $('#mtarget').val();
                                $.post(
                                    'updateMenu.do',
                                    {'mno':mno,'mname':mname,'mhref':mhref,'mtarget':mtarget},
                                    function () {
                                        alert('修改成功！');
                                        var span = $('#mname').parent();
                                        span.empty().append(mname);
                                    }
                                );
                            });
                        },
                        'json'
                    );

                });
            }

            //函数：用于删除一个菜单
            function deleteMenu () {
                var span = $('#active');
                if(span.length == 0){
                    alert('请选择要删除的菜单');
                    return;
                }
                var res = confirm('确认要删除吗？')
                if(!res){
                    return;
                }
                var mno = span.attr('mno');
                $.post(
                    'deleteMenu.do',
                    {'mno':mno},
                    function () {
                        alert('删除成功。')
                        span.parent().remove();
                    }
                );
            }
        </script>
    </head>
    <body>
        <div id="options">
            菜单操作：
            <a href="javascript:addRootMenu();">添加根菜单</a>|
            <a href="javascript:addChildMenu();">添加子菜单</a>|
            <a href="javascript:deleteMenu();">删除菜单</a>
        </div>
        <div id="menuBox">
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
        </div>
    </body>
</html>
