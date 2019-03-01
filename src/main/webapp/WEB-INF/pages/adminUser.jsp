<!DOCTYPE html>
<%@ page isELIgnored="false" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>Title</title>
<script type="text/javascript" src="../js/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="../js/layer.js"></script>
<link rel="stylesheet" type="text/css" href="../css/table.css" />
<script type="text/javascript">
	$(function() {
		$("#addTr").click(function() {
				var trHtml = "<tr><td><input name=\"ckb\" type=\"checkbox\"/></td><td>1</td><td>1</td></tr>";
				var tr = $("#table_1 tr").eq(-1);
				if (tr.size() == 0) {
					alert("指定的table id或行数不存在！");
					return;
				}
				tr.after(trHtml);
			});
		//删除行
		$("#deleteTr").click(function() {
			//获取选中的复选框，然后循环遍历删除
			var ckbs = $("input[name=ckb]:checked");
			if (ckbs.size() == 0) {
				alert("要删除指定行，需选中要删除的行！");
				return;
			}
			ckbs.each(function() {
				$(this).parent().parent().remove();
			});
		});

		/**
		 * 全选
		 * 
		 * allCkb 全选复选框的id
		 * items 复选框的name
		 */
		function allCheck(allCkb, items) {
			$('[name=' + items + ']:checkbox').attr("checked", true);
		}

		/**
		 * 取消全选
		 * 
		 * allCkb 全选复选框的id
		 * items 复选框的name
		 */
		function allUnCheck(allCkb, items) {
			$('[name=' + items + ']:checkbox').attr("checked", false);
		}

		$("#allCkb").click(function() {
			if ($("#allCkb").is(':checked')) {
				allCheck("allCkb", "ckb");
			} else {
				allUnCheck("allCkb", "ckb");
			}
		});
	});
	
	
	//新增
	function insert(){
		//var html=$("#showDiv").html();
		var html='<table id="table_2" class="default-table">'+
			'<tr>'+
				'<td>用户登录用户名</td>'+
				'<td><input type="text" value="" id="adminUserName"/></td>'+
			'</tr>'+
			'<tr>'+
				'<td>用户名称</td>'+
				'<td><input type="text" value="" id="adminName"/></td>'+
			'</tr>'+
			'<tr>'+
				'<td>密码</td>'+
				'<td><input type="text" value="" id="password"/></td>'+
			'</tr>'+
			'<tr>'+
				'<td>状态</td>'+
				'<td><input type="text" value="" id="status"/></td>'+
			'</tr>'+
			'<tr>'+
				'<td>角色id</td>'+
				'<td><input type="text" value="" id="roleId"/></td>'+
			'</tr>'+
	'</table>';
		layer.open({
            type:1,
            title:"添加账号",
            skin: 'layui-layer-rim',
            area: ['400px', 'auto'],
            content:html,
            btn:['确定','取消'],
            yes:function(index,layerio){
            	var adminUserName= $(".layui-layer-content #adminUserName").val();
            	var adminName= $(".layui-layer-content #adminName").val();
            	var password= $(".layui-layer-content #password").val();
            	var status =$(".layui-layer-content #status").val();
            	var roleId =$(".layui-layer-content #roleId").val();
            	$.ajax({
            		url:"addAdminUser",
            		type:"post",
            		dataType:"json",
            		data:{
            			"adminUserName":adminUserName,
            			"adminName":adminName,
            			"password":password,
            			"status":status,
            			"roleId":roleId
            		},
            		success:function(data){
            			location.reload();
            			layer.close(index);
            		}
            	});
            }
        });
	}
	
	//修改
	function update(){
		var ckbs = $("input[name=ckb]:checked");
		if (ckbs.size() == 0) {
			alert("要编辑指定行，需选中要编辑的行！");
			return;
		}else if (ckbs.size() > 1) {
			alert("只能选择一行");
			return;
		}
		var value = ckbs.eq(0).val();
		var arr = value.split("&");
		var adminId = arr[0];
		var html='<table id="table_2" class="default-table">'+
		'<tr>'+
			'<td>用户登录用户名</td>'+
			'<td><input type="text" value="'+arr[1]+'" id="adminUserName"/></td>'+
		'</tr>'+
		'<tr>'+
			'<td>用户名称</td>'+
			'<td><input type="text" value="'+arr[2]+'" id="adminName"/></td>'+
		'</tr>'+
		'<tr>'+
			'<td>密码</td>'+
			'<td><input type="text" value="'+arr[3]+'" id="password"/></td>'+
		'</tr>'+
		'<tr>'+
			'<td>状态</td>'+
			'<td><input type="text" value="'+arr[4]+'" id="status"/></td>'+
		'</tr>'+
		'<tr>'+
			'<td>角色id</td>'+
			'<td><input type="text" value="'+arr[5]+'" id="roleId"/></td>'+
		'</tr>'+
'</table>';
		layer.open({
            type:1,
            title:"添加账号",
            skin: 'layui-layer-rim',
            area: ['400px', 'auto'],
            content:html,
            btn:['确定','取消'],
            yes:function(index,layerio){
            	var adminUserName= $("#adminUserName").val();
            	var adminName= $("#adminName").val();
            	var password= $("#password").val();
            	var status =$("#status").val();
            	var roleId =$("#roleId").val();
            	$.ajax({
            		url:"updateAdminUser",
            		type:"post",
            		dataType:"json",
            		data:{
            			"adminId":adminId,
            			"adminUserName":adminUserName,
            			"adminName":adminName,
            			"password":password,
            			"status":status,
            			"roleId":roleId
            		},
            		success:function(data){
            			location.reload();
            			layer.close(index);
            		}
            	});
            }
        });
	}
	
	//删除
	function del(){
		var ckbs = $("input[name=ckb]:checked");
		if (ckbs.size() == 0) {
			alert("要删除指定行，需选中要删除的行！");
			return;
		}else if (ckbs.size() > 1) {
			alert("只能选择一行");
			return;
		}
		var value = ckbs.eq(0).val();
		var arr = value.split("&");
		var adminId = arr[0];
		
		$.ajax({
    		url:"deleteAdminUserByKey",
    		type:"post",
    		dataType:"json",
    		data:{
    			"adminId":adminId
    		},
    		success:function(data){
    			location.reload();
    			layer.close(index);
    		}
    	});
	}
</script>
</head>
<body>
	<input type="button" value="新增" onclick="insert();" />
	<input type="button" value="编辑" onclick="update();" />
	<input type="button" value="删除" onclick="del()" />
	<table id="table_1" class="default-table">
		<tr>
			<th><input id="allCkb" type="checkbox" /></th>
			<th>用户登录用户名</th>
			<th>用户名称</th>
			<th>密码</th>
			<th>状态</th>
			<th>角色id</th>
		</tr>
		<c:forEach items="${list}" var="bean">
			<tr>
				<td><input name="ckb" type="checkbox" value="${bean.adminId }&${bean.adminUserName }&${bean.adminName }&${bean.password }&${bean.status }&${bean.roleId }" /></td>
				<td>${bean.adminUserName }</td>
				<td>${bean.adminName }</td>
				<td>${bean.password }</td>
				<td>${bean.status }</td>
				<td>${bean.roleId }</td>
			</tr>
		</c:forEach>
	</table>
	
	<!-- <div id="showDiv" style="display: none;">
	<table id="table_2" class="default-table">
			<tr>
				<td>用户登录用户名</td>
				<td><input type="text" value="" id="adminUserName"/></td>
			</tr>
			<tr>
				<td>用户名称</td>
				<td><input type="text" value="" id="adminName"/></td>
			</tr>
			<tr>
				<td>密码</td>
				<td><input type="text" value="" id="password"/></td>
			</tr>
			<tr>
				<td>状态</td>
				<td><input type="text" value="" id="status"/></td>
			</tr>
			<tr>
				<td>角色id</td>
				<td><input type="text" value="" id="roleId"/></td>
			</tr>
	</table>
	</div> -->
</body>
</html>
