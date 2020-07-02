<%@ page pageEncoding="UTF-8" %>
<!doctype html>
<html>
    <head>
        <style>
            #menuBox ul li{
                margin: 5px;
                list-style: none;
            }
            #menuBox span{
                cursor: pointer;
            }
            #menuBox span:hover{
                background-color: rgba(0,140,140,0.5);
            }
        </style>
        <script src="js/jquery-3.5.1.min.js"></script>
        <script>
            $(function () {
                //ajax请求获取并展示菜单列表
                $.post('menuList.do',{},function (menus) {
                    /**
                     * 函数：用于展示一级子菜单
                     * @param p 父级菜单编号
                     * @param $position 展示的位置（一个jQuery对象）
                     */
                    function showOneLevelChildMenu(pno,$position) {
                        var ul = $('<ul>');
                        $position.append(ul);
                        for (var i = 0; i < menus.length; i++) {
                            var menu = menus[i];
                            if(menu.pno == pno){
                                var li = $('<li>');
                                ul.append(li);
                                li.append('<input type="checkbox" value="'+menu.mno+'"><span>'+menu.mname+'</span>');

                                showOneLevelChildMenu(menu.mno, li);
                            }
                        }
                    }
                    //起始调用
                    showOneLevelChildMenu(-1,$('#menuBox td'));

                    //添加展开合并动作
                    $('#menuBox span').click(function () {
                        $(this).next().toggle(500);
                    });

                    /*
                    全选：
                    选中父级，自动选中子集
                    选掉父级，自动选掉子集
                    选中子集，自动选中父级
                    选掉子集，自动选掉父级（没有其他子集选中时，需要选掉父级）
                     */
                    $('#menuBox input:checkbox').click(function () {
                        var flag = $(this).prop('checked');
                        if(flag){
                            //选中状态
                            //1.选中子集
                            function checkChildren ($parent) {
                                var inputs = $parent.next().next().children().children('input:checkbox');
                                if(inputs.length == 0) return;
                                inputs.prop('checked',flag);//选中子菜单
                                checkChildren(inputs);//递归调用 选中子菜单的子菜单
                            }
                            checkChildren($(this));

                            //2.选中父级
                            function checkParent($children) {
                                var input = $children.parent().parent().prev().prev();
                                if(input.length == 0){
                                    return;
                                }
                                input.prop('checked',flag);//选中父菜单
                                checkParent(input);//递归调用 选中父菜单的父菜单
                            }
                            checkParent($(this));

                        }else{
                            //1.选掉子菜单
                            function uncheckChildren ($parent) {
                                var inputs = $parent.next().next().children().children('input:checkbox');
                                if(inputs.length == 0) return;
                                inputs.prop('checked', flag);
                                uncheckChildren(inputs);
                            }
                            uncheckChildren($(this));

                            //2.选掉父菜单
                            function uncheckParent ($children) {
                                //获取父菜单
                                var input = $children.parent().parent().prev().prev();
                                if(input.length == 0) return;//没有父级菜单
                                //获取其他（状态为选中的）子菜单
                                var inputs = $children.parent().parent().children().children('input:checked');
                                if(inputs.length > 0) return;//说明其他子菜单还有选中的 此时不能选掉父菜单

                                input.prop('checked', flag);
                                uncheckParent(input);
                            }
                            uncheckParent($(this));
                        }
                    });

                    //ajax请求获取该角色已经拥有的菜单 并把勾选
                    $.post('ownMenus.do',{'rno':$('#rno').val()},function (mnos){
                        //后端响应一个菜单编号集合
                        for (var i = 0; i < mnos.length; i++) {
                            var mno = mnos[i];
                            $('#menuBox input[value="'+mno+'"]').prop('checked',true);
                        }
                    },'json');

                },'json');

                //给保存按钮添加事件
                $('#saveBtn').click(function () {
                    //1.获取选中的复选框
                    var inputs = $('#menuBox input:checked');
                    //2.拼接选中的菜单编号
                    var mnos = '';
                    inputs.each(function (i,e) {
                        //checkbox中的value属性存着对应的菜单编号
                        var mno = $(e).val();
                        mnos += mno + ',';
                    });
                    //3.发送Ajax请求 保存本次选中的菜单
                    $.post('setMenus.do',{'rno':$('#rno').val(),'mnos':mnos},function () {
                        alert('保存成功');
                    });
                });

            });
        </script>
    </head>
    <body>
        <input type="hidden" id="rno" value="${param.rno}">
        <h2 align="center">给【${param.rname}】分配菜单</h2>
        <p align="center"><button id="saveBtn">保存</button></p>
        <table style="" id="menuBox" align="center">
            <tr>
                <td>
                    <!--
                    <ul>
                        <li>
                            <input type="checkbox"><span mno="1">权限管理</span>
                            <ul>
                                <li>
                                    <input type="checkbox"><span mno="2">用户管理</span>
                                    <ul></ul>
                                </li>
                                <li>
                                    <input type="checkbox"><span mno="3">角色管理</span>
                                    <ul></ul>
                                </li>
                                <li>
                                    <input type="checkbox"><span mno="4">菜单管理</span>
                                    <ul></ul>
                                </li>
                            </ul>
                        </li>
                        <li>
                            input type="checkbox"><span mno="5">基本信息管理</span>
                            <ul>
                                <li>
                                    <input type="checkbox"><span mno="6">商品管理</span>
                                    <ul></ul>
                                </li>
                                <li>
                                    <input type="checkbox"><span mno="7">供应商管理</span>
                                    <ul></ul>
                                </li>
                                <li>
                                    <input type="checkbox"><span mno="8">库房管理</span>
                                    <ul></ul>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <input type="checkbox"><span mno="9">系统管理</span>
                            <ul></ul>
                        </li>
                        <li>
                            <input type="checkbox"><span mno="16">学生管理</span>
                            <ul></ul>
                        </li>
                    </ul>
                    -->
                </td>
            </tr>
        </table>
    </body>
</html>