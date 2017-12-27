<%--
  Created by IntelliJ IDEA.
  User: CHEN JX
  Date: 2017/12/26
  Time: 15:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/static/layui/css/layui.css" media="all">
</head>
<body>
<table class="layui-hide" id="test" lay-filter="demo"></table>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>

</script>
</body>
<script src="<%=path%>/static/layui/layui.all.js"></script>
<script src="<%=path%>/static/js/layer.js"></script>
<script>
    layui.use([ 'laypage', 'layer', 'table', 'element'], function(){
        var laypage = layui.laypage //分页
        layer = layui.layer //弹层
            ,table = layui.table //表格
            ,element = layui.element; //元素操作
        //执行一个 table 实例
        table.render({
            elem: '#test'
            ,height: 332
            ,url: '/letter/data/json/pager' //数据接口
            ,page: true //开启分页
            ,limit:5//每页显示多少个
            ,response: {
                statusName: 'status'
                ,statusCode: 0
                ,msgName: 'message'
                ,countName: 'total'
                ,dataName: 'rows'
            }
            ,cols: [[ //表头
                {field: 'lid', title: 'ID', width:80, sort: true, fixed: 'left'}
                ,{field: 'title', title: '标题', width:120}
                ,{field: 'content', title: '内容', width:120}
                ,{field: 'createdTime', title: '添加时间', width:100}
                ,{field: 'status', title: '状态', width:100}
                ,{fixed: 'right', width: 165, align:'center', toolbar: '#barDemo'}

            ]]
        });
        //监听工具条
        table.on('tool(demo)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
            var data = obj.data //获得当前行数据
                ,layEvent = obj.event; //获得 lay-event 对应的值
            if(layEvent === 'detail'){
                layer.msg('查看操作');
            } else if(layEvent === 'del'){
                layer.confirm('真的删除行么', function(index){
                    obj.del(); //删除对应行（tr）的DOM结构
                    layer.close(index);
                    //向服务端发送删除指令
                });
            } else if(layEvent === 'edit'){
               alert(data.title);
            }
        });
    });
</script>
</html>