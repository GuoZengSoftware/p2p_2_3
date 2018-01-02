<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/12/25
  Time: 10:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%>
<html>
<head>
    <title>所有角色</title>
    <!--引入css文件-->
    <%@include file="role-head.jsp" %>
</head>
<body>
<div id="app">

    <div class="layui-row">
        <div class="layui-col-xs6">
            <div>
                <button class="layui-btn" @click="showAddRole">添加角色</button>
                <button class="layui-btn" @click="showAddRole">角色分配</button>
            </div>
            <!--角色zTree的显示容器-->
            <div>
                <ul id="roleTree" class="ztree" style="width:auto; overflow:auto;"></ul>
            </div>
        </div>
        <div class="layui-col-xs6">
            <!--详情和编辑-->
            <div style="width: 90%;">
                <div style="text-align: center;"><h3>角色详情</h3></div>
                <form class="layui-form">
                    <div class="layui-form-item">
                        <label class="layui-form-label">角色名称：</label>
                        <label class="layui-form-label" v-model="roleDel" style="color: #00a0e9">{{roleDel.rname}}</label>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">角色描述：</label>
                        <label class="layui-form-label" v-model="roleDel" style="color: #00a0e9">{{roleDel.content}}</label>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">所属部门：</label>
                        <label class="layui-form-label" v-model="roleDel" style="color: #00a0e9">{{roleDel.dep}}</label>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">权限配置：</label>
                        <label class="layui-form-label" v-model="roleDel" style="color: #00a0e9">{{roleDel.jur}}</label>
                    </div>

                    <div>
                        <button class="layui-btn" @click="showAddRole">修改详情</button>
                    </div>
                </form>
            </div>
        </div>
    </div>




    <!--添加窗口-->
    <div id="addWin" style="display: none">
        <form class="layui-form">
            <div class="layui-form-item">
                <label class="layui-form-label">角色名称</label>
                <div class="layui-input-block">
                    <input type="text" v-model="role.rname" required lay-verify="required" placeholder="请输入角色名称"
                           autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">角色描述</label>
                <div class="layui-input-block">
                    <input type="text" v-model="role.content" required lay-verify="required" placeholder="请输入角色描述"
                           autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">所属部门</label>
                <!--角色zTree的显示容器-->
                <ul id="roleDepTree" class="ztree" style="width:auto; height: 100px; overflow:auto;"></ul>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">权限配置</label>
                <!--权限树的显示容器-->
                <ul id="roleJurTree" class="ztree" style="width:auto; height: 100px; overflow:auto;"></ul>
            </div>

            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-submit lay-filter="formDemo" @click="save">保存</button>
                    <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                </div>
            </div>

        </form>
    </div>


</div>
</body>
<!--引入js文件-->
<%@include file="role-foot.jsp" %>
<script type="text/javascript">
    var vue = new Vue({
        el: "#app",
        data: {
            role: {
                rid: '',
                rname: '',
                content: '',
                pid: ''
            },
            roleDel:{
                rid:'',
                rname: '',
                content: '',
                dep:'',
                jur:''
            }
        },
        created() {
            //初始化树
            initTreeRole();
        },
        methods: {
            save: function () {
                var jurString = nodeJurOnCheck();
                var  params = new URLSearchParams();
                params.append('jurString',jurString);
                console.log(jurString);
                if (this.role.pid.length != 0) {
                    axios.post(' /role/data/json/save', Qs.stringify(this.role)).then((response) => {
                        layer.msg(response.data.message);
                        console.log(this.role);
                    }, (error) => {
                        layer.alert("请求失败");
                    });
                } else {
                    layer.msg("请选择部门");
                }
            },
            showAddRole: function () {
                showAddRole();
            }
        }
    })
</script>
</html>
