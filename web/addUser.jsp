<%@ page contentType="text/html; charset=UTF-8" %>
<html>
    <head>
        <style>
            #addUserBox{
                width:480px;
                height:500px;
                background-color:rgba(1,140,140,0.8);
                color: whitesmoke;
                margin:30px auto;
                padding-right: 30px;
                border: 0;
                border-radius: 5%;
                padding-top: 5px;
            }
            #addUserForm ul>li{
                font-size: 20px;
                margin-bottom: 13px;

                text-align: center;
                list-style: none;
            }
            #addUserForm input{
                width:230px;
                height: 40px;
                margin-left: 3px;
                border: 0;
                border-radius: 3%;
            }
            #addUserForm button{
                width: 75px;
                height: 33px;
                font-size: 22px;
                border: 0;
                border-radius: 3%;
                color:rgba(1,140,140,0.8);
            }
        </style>
        <script>
            window.onload = function () {
                var userFormEle = document.getElementById("addUserForm");
                userFormEle.onsubmit = function () {
                    var upassEle = document.getElementById("upass");
                    var repassEle = document.getElementById("repass");
                    if(upassEle.value == repassEle.value){
                        return true;
                    }else{
                        alert('两次密码输入不一致');
                        return false;
                    }
                }
            }
        </script>
    </head>
    <body>
        <div id="addUserBox">
            <h2 align="center">信息填写</h2>
            <form id="addUserForm" action="addUser.do" method="post">
                <ul>
                    <li>用户名称：<input type="text" name="uname" required></li>
                    <li>用户密码：<input type="password" id="upass" name="upass" required></li>
                    <li>确认密码：<input type="password" id="repass" required></li>
                    <li>真实名字：<input type="text" name="truename" required></li>
                    <li>用户年龄：<input type="number" name="age" required></li>
                    <li>用户性别：<input type="text" name="sex" list="sexList">
                        <datalist id="sexList">
                            <option>男</option>
                            <option>女</option>
                        </datalist>
                    </li>
                    <li>电话号码：<input type="text" name="phone" required></li>
                    <li><button>保存</button></li>
                </ul>
            </form>
        </div>
    </body>
</html>