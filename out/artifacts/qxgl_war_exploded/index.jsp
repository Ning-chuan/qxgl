<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录</title>
    <style type="text/css">
        #loginBox{
            width:420px;
            background:rgba(0,140,140,0.8) ;
            border-radius:20px;
            margin:150px auto ;
            color: whitesmoke;
            padding: 10px;
        }
        #loginBox input{
            width:250px;
            height:38px;
            color: black;
            padding-left:4px;
            border: 0;
            border-radius: 5px;
        }
        #loginBox tr{
            height:50px ;
            color: whitesmoke;
            font-size:17px;
        }

        #loginBox button{
            width:60px;
            height:35px;
            font-size:17px;
            color: rgba(0,140,140,0.8);
            border: 0;
            border-radius: 5px;
        }
        #msg{
            color: #ff4200 ;
            text-align:center ;
            font-size:14px ;
            height:14px;
        }
    </style>
</head>
<body>
    <div id="loginBox">
        <h2 align="center">用户登录</h2>
        <div id="msg">
            ${flag=='9'?'用户名或密码错误':''}
        </div>
        <form action="login.do" method="post">
            <table align="center">
                <tr>
                    <td>账号：</td>
                    <td><input type="text" name="uname" required></td>
                </tr>
                <tr>
                    <td>密码：</td>
                    <td><input type="password" name="upass" required></td>
                </tr>
                <tr>
                    <td colspan="2" align="center"><button>登录</button></td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>
