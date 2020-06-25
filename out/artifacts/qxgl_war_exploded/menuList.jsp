<%@ page pageEncoding="UTF-8" %>
<!doctype html>
<html>
    <head>
        <script src="js/jquery-3.5.1.min.js"></script>
        <script>
            $(function () {
                //使用jQuery封装的函数发送ajax请求
                $.post(
                    'menuList.do',
                    {uname:'zhangsan',upass:'333'},
                    function (data) {
                        console.log(data);
                        alert(data.length);
                    },
                    'json'
                );
            });
        </script>
    </head>
    <body>
        菜单列表
    </body>
</html>
