<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<jsp:include page="/WEB-INF/jsp/_taglib.jsp" />
		<jsp:include page="/WEB-INF/jsp/_style.jsp" />
		<jsp:include page="/WEB-INF/jsp/_script.jsp" />
		<style type="text/css">
			.banner_div {
				height: 50px;
				background-color: #102A48;
				background-image: url("<%=request.getContextPath()%>/images/header_bg.png");
				background-position: 100% 100%;
				background-repeat: no-repeat;
				padding-right: 10px;
			}
			.banner_div a {
				color: #B9CCDA;
				text-decoration: none;
			}
			.logo {
				background-image: url("<%=request.getContextPath()%>/images/logo.png");
				background-repeat: no-repeat;
				width: 200px;
				height: 100%;
				float: left;
			}
			.nav {
				margin-top: 8px;
				text-align: right;
				color: #B9CCDA;
			}
		</style>
		<script type="text/javascript">
			//如果openTab()方法放在$(function(){}) 中，无法通过 window.top.openTab(title, href); 这种方式访问
			function openTab(title, href) {
				//判断菜单中的链接是否已经打开
				var mainTab = $('#main_tab');
				var tabExist = mainTab.tabs("getTab", title);
				if (tabExist != null) {
					mainTab.tabs("select", title);
				} else {
					var iframeStr = "<iframe scrolling='yes' frameborder='0'  src='" + href + "' style='width:100%;height:100%;'></iframe>";
					mainTab.tabs('add',{
					    title:title,
					    content:iframeStr,
					    closable:true,
					    tools:[{
					        iconCls:'icon-mini-refresh',
					        handler:function(){
					        	var tab = mainTab.tabs("getTab", title);
					        	if (tab != null)
					        		tab.panel("refresh");
					        }
					    }]
					});
				}
			}
			//关闭tab
			function closeTab(title){
				//判断菜单中的链接是否已经打开
				var mainTab = $('#main_tab');
				var tabExist = mainTab.tabs("getTab", title);
				if (tabExist != null) {
					mainTab.tabs("close", title);
				} 
			}
			
			$(function(){
				$("#main_menu div ul li").click(function(){
					var text = $(this).text();
					var href = $(this).children("div").attr("node-id");
					if (href != null)
						openTab(text, href);
				});
			});
		</script>
	</head>
	<body>
		<div class="easyui-layout" data-options="fit:true">
	        <div id="main_menu" data-options="region:'west', split:true" title="导航菜单" style="width:200px;">
	        	<div id="menu_accordion" class="easyui-accordion" data-options="border:false">
	        		<%@ include file="_left.jsp"%>
	        	</div>
	        </div>
	        <div data-options="region:'center'">
	            <div id="main_tab" class="easyui-tabs" data-options="fit:true, border:false,tools:'#main-tab-tools'">
			        <div title="主页" style="padding:10px">
				    	<div class="easyui-panel" title="前端" style="margin-bottom: 10px; padding-left: 10px;">
					        <p style="font-size:14px">jQuery EasyUI framework</p>  
					        <ul>
					            <li>官网：<a href="http://www.jeasyui.com/" target="_blank">http://www.jeasyui.com/</a></li>  
					        </ul>  
					    </div>
				    	<div class="easyui-panel" title="后台" style="margin-bottom: 10px; padding-left: 10px;">
					        <p style="font-size:14px">JFinal WEB + ORM 开发框架</p>  
					        <ul>
					            <li>Google Code：<a href="https://code.google.com/p/jfinal/" target="_blank">https://code.google.com/p/jfinal/</a></li>  
					        </ul>  
					    </div>
				    	<div class="easyui-panel" title="常用帮助" style="margin-bottom: 10px; padding-left: 10px;">
					        <p style="font-size:14px">jQuery API</p>  
					        <ul>
					            <li>网址：<a href="http://www.ostools.net/apidocs/apidoc?api=jquery" target="_blank">http://www.ostools.net/apidocs/apidoc?api=jquery</a></li>  
					        </ul>
					        <p style="font-size:14px">JDK6 API</p>  
					        <ul>
					            <li>网址：<a href="http://www.cjsdn.net/Doc/JDK60/" target="_blank">http://www.cjsdn.net/Doc/JDK60/</a></li>  
					        </ul>
					        <p style="font-size:14px">开源中国 在线工具</p>  
					        <ul>
					            <li>网址：<a href="http://www.ostools.net/apidocs" target="_blank">http://www.ostools.net/apidocs</a></li>  
					        </ul>
					    </div>
			        </div>
			    </div>
	        </div>
	        <div data-options="region:'south', border:false" style="background-color: #E6EEF8; text-align: center;">
	        	版权所有 COPYRIGHT 20170806
	        	1
	        	2
	        	3
	        	4
	        </div>
	    </div>
	</body>
</html>