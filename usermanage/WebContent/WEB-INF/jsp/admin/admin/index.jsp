<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<jsp:include page="/WEB-INF/jsp/_taglib.jsp" />
		<jsp:include page="/WEB-INF/jsp/_style.jsp" />
		<jsp:include page="/WEB-INF/jsp/_script.jsp" />
	</head>
	<body>
		<div class="easyui-layout" data-options="fit:true">
			<div class="easyui-panel" data-options="region:'north', title:'查询条件'" style="height:100px; padding: 5px 10px;">
				<form id="search-form" style="display: none;" method="post">
					<table class="search-table">
						<tr>
							<td>用户名：<input id="name" name="name"></td>
						</tr>
					</table>
					<div align="center">
						<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" id="search-btn">查询</a>
						<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" id="reset-btn">重置</a>
					</div>
				</form>
			</div>
			<div data-options="region:'center', title:'查询结果'">
				<table id="dg"></table>
			</div>
		</div>
	    <!-- 添加窗口 -->
	    <div id="dlg" style="width:400px; height:350px; display: none;">
	    	<form id="form-add" method="post">
		    		<table style="padding-left: 10px;">
						<tr>
							<td>姓名:</td>
							<td><input type="text" name="username" class="easyui-validatebox" data-options="required:true"></input></td>
						</tr>
						<tr>
							<td>性别:</td>
							<td>
								<select name="sex" style="width:150px;">
									<option value="1">男</option>
									<option value="0">女</option>
								</select>
							</td>
						</tr>
						<tr>
							<td>年龄:</td>
						    <td><input name="age" class="easyui-numberspinner" style="width:150px;" required="required" data-options="min:10,max:100,editable:true"></td>
						</tr>
					</table>
		    </form>
	    </div>
	    <!-- 修改窗口 -->
	    <div id="dlg_edit" style="width:400px; height:350px; display: none;">
	    	<form id="form-edit" method="post">
	    		<table style="padding-left: 10px;">
					<tr>
						<td>姓名:</td>
						<td><input type="text" name="username" class="easyui-validatebox" data-options="required:true"></input></td>
					</tr>
					<tr>
						<td>性别:</td>
						<td>
							<select id="sexForEdit" name="sex" style="width:150px;">
								<option value="1">男</option>
								<option value="0">女</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>年龄:</td>
						<td><input id="ageForEdit" name="age" class="easyui-numberspinner" style="width:150px;" data-options="min:10,max:100,editable:true"></td>
					</tr>
				</table>
		    </form>
	    </div>
	
		<script type="text/javascript">
			$(function(){
				var url = '';
				var findUrl = 'admin/find';
				var addUrl = "admin/add";
				var updateUrl = "admin/edit";
				//添加表单
				var formAdd = $("#form-add");
				//修改表单
				var formEdit = $("#form-edit");
				//显示查询表单
				$("#search-form").show();
				//表格
				var grid = $("#dg");
				grid.datagrid({
					border:false,
					fit:true,
					idField:"id",
					url:findUrl,
					pagination:true,
				    rownumbers:true,
					singleSelect:true,
					columns:[[
						{field:'id',title:'ID',width:100},
						{field:'username',title:'名称',width:100},
						{field:'created_time',title:'创建时间', formatter:WebUtil.easyui.formatter.millisecond},
						{field:'updated_time',title:'更新时间', formatter:WebUtil.easyui.formatter.millisecond}
					]],
					toolbar:[{
						iconCls:"icon-reload",
						text:"刷新",
						handler:function(){
							grid.datagrid('reload');
						}
					}, "-", {
						iconCls:"icon-add",
						text:"添加",
						handler:function(){
							url = addUrl;
							formAdd.form("reset");
							dlg.dialog("open").dialog("setTitle","添加");
						}
					},{
						iconCls:"icon-edit",
						text:"修改",
						handler:function(){
							var rows = grid.datagrid("getSelections");
							if(rows.length == 0){
								$.messager.alert("提示","请选择一条记录!","info");
								return;
							}else if(rows.length > 1){
								$.messager.alert("提示","请选择一条记录!","info");
								return;
							}
							url = updateUrl+"?id="+rows[0].id;
							formEdit.form("reset");
							formEdit.form("load",{username:rows[0].username});
							$("#ageForEdit").numberspinner({required:true});
							$("#ageForEdit").numberspinner('setValue', rows[0].age);
							$("#sexForEdit").val(rows[0].sex);
							dlg_edit.dialog("open").dialog("setTitle","修改");
						}
					},{
						iconCls:"icon-remove",
						text:"删除",
						handler:function(){
							var rows = grid.datagrid("getSelections");
							if(rows.length == 0){
								$.messager.alert("提示","请选择记录","info");
								return;
							}
							$.messager.confirm("确认","确定删除吗?",function(r){
								if(r){
									$.post("admin/delete",{id:rows[0].id},function(result){
										console.info(result);
										if(result.result == "success"){
											grid.datagrid("reload");
											grid.datagrid("clearSelections");
											$.messager.show({
												title:"提示",
												msg:result.msg,
												showType:"show"
											});
										}else{
											$.messager.show({
												title:"error",
												msg:result.msg,
												showType:"show"
											});
										}
									});
								}
							});
						}
					}]
				});
				// 添加窗口
				var dlg = $("#dlg").show();
				dlg.dialog({
					title:'添加',
					closed:true,
					collapsible:true,
					maximizable:true,
					shadow:false,
					modal:true,
					buttons:[{
						text:'保存',
						iconCls:'icon-save',
						handler:function(){
							//保存
							add();
						}
					},{
						text:'关闭',
						handler:function(){
							dlg.dialog('close');
						}
					}]
				});
				// 修改窗口
				var dlg_edit = $("#dlg_edit").show();
				dlg_edit.dialog({
					title:'修改',
					closed:true,
					collapsible:true,
					maximizable:true,
					shadow:false,
					modal:true,
					buttons:[{
						text:'保存',
						iconCls:'icon-save',
						handler:function(){
							//修改
							edit();
						}
					},{
						text:'关闭',
						handler:function(){
							dlg_edit.dialog('close');
						}
					}]
				});
				//添加
				function add(){
					//提交表单
					formAdd.form('submit',{
			            url: url,
			            onSubmit: function(){
			            	var vali = $(this).form('validate');
			                return vali; 
			            },
			            success: function(msg){
			            	msg = eval("(" + msg + ")");
			            	if(msg.result == "success"){
			            		dlg.dialog("close");
			            		grid.datagrid("clearSelections");
			            		grid.datagrid('reload');
			            		$.messager.show({
			                        title:'提示',
			                        msg:msg.msg,
			                        showType:'show'
			                    });
			            	}else{
			            		$.messager.show({
			                        title:'提示',
			                        msg:msg.msg,
			                        showType:'show'
			                    });
			            	}
			            	
			            }
			        });
				}
				//修改
				function edit(){
					//提交表单
					formEdit.form('submit',{
			            url: url,
			            onSubmit: function(){
			            	var vali = $(this).form('validate');
			                return vali; 
			            },
			            success: function(msg){
			            	msg = eval("(" + msg + ")");
			            	console.info(msg);
			            	if(msg.result == "success"){
			            		dlg_edit.dialog("close");
			            		grid.datagrid("clearSelections");
			            		grid.datagrid('reload');
			            		$.messager.show({
			                        title:'提示',
			                        msg:msg.msg,
			                        showType:'show'
			                    });
			            	}else{
			            		$.messager.show({
			                        title:'提示',
			                        msg:msg.msg,
			                        showType:'show'
			                    });
			            	}
			            	
			            }
			        });
				}
				//查询
				$("#search-btn").click(function(){
					var name = $("#name").val();
					var query = {name:name};
					grid.datagrid("options").queryParams = query;
					grid.datagrid("load");
				});
				//重置
				$("#reset-btn").click(function(){
					$("#search-form").form("reset");
				});
			});
		</script>
	</body>
</html>