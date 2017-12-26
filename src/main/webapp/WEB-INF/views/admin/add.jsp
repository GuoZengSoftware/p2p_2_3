<%--
  Created by IntelliJ IDEA.
  User: Animo
  Date: 2017-12-21
  Time: 8:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
    <title>添加管理员</title>
    <link rel="stylesheet" href="<%=path%>/static/css/style.css"/>

</head>
<body>
<div class="login">
    <ul class="login-list">
        <p class="error-msg icon icon-error"></p>
        <form id="addAdmin" method="post">
            <div class="from">
                <li><input type="text" id="phone" name="phone" placeholder="请输入手机号码" onblur="checkPhone(this);"></li>
            </div>
            <div class="from">
                <li><input type="text" id="rname" name="rname" placeholder="请输入昵称"></li>
            </div>
            <div class="from">
                <li><input type="password" id="pwd" name="resstr1" placeholder="请输入密码"></li>
            </div>

            <li><input type="button" class="btn" onclick="add();" value="添加"></li>
        </form>
    </ul>
</div>
<script src="<%=path%>/static/js/jquery.min.js"></script>
<script>
    //错误提示
    function showError(msg,obj){
        $('.error-msg').text(msg).addClass('show');
        obj.parent('.from').addClass('error');
        obj.focus(function(){
            obj.parent('.from').removeClass('error');
            $('.error-msg').removeClass('show');
        });
    }

    function checkPhone(phone) {
        var phone = $("#phone").val();
        if(phone == ''){
            showError('请输入手机号码',$(phone));
            return;
        }else if(phone.length != 11){
            showError('请输入正确手机号',$(phone));
            return;
        };
        $.post( '/admin/data/json/getByPhone/'+phone,
            function (data) {
                if (data.message === 'success') {

                } else {
                    showError('该手机号已存在',$(phone));
                    return;
                }
            },
            'json'
        );
    }
</script>
<script>
    function add(){
        var rname = $("#rname").val();
        var phone = $("#phone").val();
        var pwd = $("#pwd").val();
        if(rname=='') {
            showError('请输入昵称',$(rname));
            return;
        }else if(phone==''){
            showError('请输入手机号',$(phone));
            return;
        }else if(phone.length != 11){
            showError('请输入正确手机号',$(phone));
            return;
        };
        if(pwd==''){
            showError('请输入登录密码',$(pwd));
            return;
        };
        $.post('/admin/data/json/add',
            $("#addAdmin").serialize(),
            function (data) {
                if (data.message === 'success') {
                    alert("添加成功");
                    $(":text").val("");
                    $(":password").val("");
                } else {
                    alert(data.message);
                }
            },
            'json'
        );
    }
</script>
</body>
</html>
