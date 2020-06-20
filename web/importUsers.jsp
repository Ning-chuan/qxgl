<%@ page contentType="text/html; charset=UTF-8" %>
<html>
    <head>
        <style>
            #importBox{
                width: 400px;
                height: 200px;
                margin: 50px auto;
                background-color: #008c8c;
                border-radius: 20px;
                color: whitesmoke;
                padding-top: 10px;
            }
            #importBox input{
                font-size: 16px;
                margin: 10px 60px;
            }
        </style>
    </head>
    <body>
        <div id="importBox">
            <h2 align="center">请选择要导入的文件</h2>
            <form action="importUsers.do" method="post" enctype="multipart/form-data">
                <input type="file" required name="excel">
                <input type="submit" value="上传">
            </form>
        </div>
    </body>
</html>