<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>主页</title>
    <style>
        *{
            margin: 0;
            /*padding: 0;*/
        }
        html,body{
            width: 100%;
            height: 100%;
        }
        #top{
            border-color: chocolate;
            height: 20%;
            width: 100%;
            border-bottom: 2px solid chocolate;
            box-sizing: border-box;
        }
        #left{
            height: 80%;
            width:20%;
            border-right: 2px solid chocolate;
            box-sizing: border-box;
            float: left;
        }
        #right{
            height:80%;
            width:80%;
            float:left;
        }
        #menuBox{
            margin-top: 10%;
            margin-left: 10%;
        }
        #menuBox li{
            list-style: none;
            margin: 2%;
        }
        #menuBox li span{
            cursor: pointer;

        }
        #menuBox li ul>li>span:hover{
            background-color: rgba(0,140,140,0.5);
        }
        #loginMsg{
            position: relative;
            top: 35%;
            left: 18%;
            font-size: large;
        }
    </style>
</head>
<body>
    <div id="top">
        <span id="loginMsg">欢迎【${sessionScope.loginUser.truename}】登录</span>
    </div>
    <div id="left">
        <ul id="menuBox">
            <li>
                <span>权限管理</span>
                <ul>
                    <li><span><a href="userList.do" target="right">用户管理</a></span></li>
                    <li><span><a href="roleList.do" target="right">角色管理</a></span></li>
                    <li><span>菜单管理</span></li>
                </ul>
            </li>
            <li>
                <span>基本信息管理</span>
                <ul>
                    <li><span>商品管理</span></li>
                    <li><span>供应商管理</span></li>
                    <li><span>库房管理</span></li>
                </ul>
            </li>
            <li>
                <span>系统管理</span>
                <ul>
                    <li><span>修改密码</span></li>
                    <li><span>注销</span></li>
                </ul>
            </li>
        </ul>
    </div>
    <div id="right">
        <iframe name="right" width="100%" height="100%" frameborder="0"></iframe>
    </div>
</body>
</html>
