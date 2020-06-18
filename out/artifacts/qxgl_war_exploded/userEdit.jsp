<%@ page contentType="text/html; charset=UTF-8" %>
<html>
    <head>
        <style>
            #userEditBox{
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
            #userEditForm ul>li{
                font-size: 20px;
                margin-bottom: 13px;

                text-align: center;
                list-style: none;
            }
            #userEditForm input{
                width:230px;
                height: 40px;
                margin-left: 3px;
                border: 0;
                border-radius: 3%;
            }
            #userEditForm button{
                width: 120px;
                height: 33px;
                font-size: 22px;
                border: 0;
                border-radius: 3%;
                color:rgba(1,140,140,0.8);
            }
        </style>
        <script>
            window.onload = function () {
                var userEditFormEle = document.getElementById("userEditForm");
                userEditFormEle.onsubmit = function () {
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
        <div id="userEditBox">
            <h2 align="center">请填写需要修改项</h2>
            <form id="userEditForm" action="updateUser.do" method="post">
                <ul>
                    <li>用户名称：<input type="text" name="uname" required value="${user.uname}"></li>
                    <li>用户密码：<input type="password" id="upass" name="upass" value="${user.upass}" required></li>
                    <li>确认密码：<input type="password" id="repass" required></li>
                    <li>真实名字：<input type="text" name="truename" value="${user.truename}" required></li>
                    <li>用户年龄：<input type="number" name="age" value="${user.age}" required></li>
                    <li>用户性别：<input type="text" name="sex" value="${user.sex}" list="sexList">
                        <datalist id="sexList">
                            <option>男</option>
                            <option>女</option>
                        </datalist>
                    </li>
                    <li>电话号码：<input type="text" name="phone" value="${user.phone}" required></li>
                    <li><button>提交修改</button></li>
                </ul>
            </form>
        </div>
    </body>
</html>