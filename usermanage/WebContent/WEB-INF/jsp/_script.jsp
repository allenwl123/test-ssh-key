<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- jquery and easyui -->
<script type="text/javascript" src="<%=request.getContextPath() %>/static/jquery-easyui/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/static/jquery-easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/static/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>

<script type="text/javascript">
	// WebUtil 常用工具类
	(function(){
		if (!window.WebUtil)
			WebUtil = {};
	})();
	WebUtil.form = {
		serializeJson : function(frm){
			var json = {};
	        frm = frm || $('body');
	        if (!frm) {
	            return json;
	        }
	        var inputs = frm.find('input[type!=button][type!=reset][type!=submit][type!=image],select,textarea');
	        if (!inputs) {
	        	return json;
	        }
	        for (var index = 0; index < inputs.length; index++) {
	        	var input = $(inputs[index]);
	        	var name = input.attr('name');
	        	var value = input.val();
	        	if (name != null && $.trim(name) != '' && value != null && $.trim(value) != '') {
	        		json[name] = value;
	        	}
	        }
	        return json;
		}
	};
	(function($){
		$.fn.serializeJson = function(){
			return WebUtil.form.serializeJson($(this));
		};
	}(jQuery));
	
	// 与easyui相关的工具类
	WebUtil.easyui = {};
	WebUtil.easyui.formatter = {
		// 毫秒数转日期字符串yyyy-MM-dd HH:mm:ss
		millisecond : function(value,row,index){
			if (value) {
				var date = new Date(value);
				var year = date.getFullYear();
				var month = date.getMonth() < 9 ? '0' + parseInt(date.getMonth() + 1) : parseInt(date.getMonth() + 1);
				var day = date.getDate() < 10 ? '0' + date.getDate() : date.getDate();
				var hours = date.getHours() < 10 ? '0' + date.getHours() : date.getHours();
				var minutes = date.getMinutes() < 10 ? '0' + date.getMinutes() : date.getMinutes();
				var seconds = date.getSeconds() < 10 ? '0' + date.getSeconds() : date.getSeconds();
				var dateTimeStr = year + "-" + month + "-" + day + " " + hours + ":" + minutes + ":" + seconds;
				return dateTimeStr;
			}
		},
		// 毫秒数转日期yyyy-MM-dd
		millisecondToDate : function(value,row,index){
			if (value) {
				var date = new Date(value);
				var year = date.getFullYear();
				var month = date.getMonth() < 9 ? '0' + parseInt(date.getMonth() + 1) : parseInt(date.getMonth() + 1);
				var day = date.getDate() < 10 ? '0' + date.getDate() : date.getDate();
				var dateStr = year + "-" + month + "-" + day;
				return dateStr;
			}
		},
		// 用户性别转字符串
		userSex : function(value,row,index){
			switch(value) {
			case true : 
				return '男';
			case false : 
				return '女';
			}
		},
		// 用户性别转字符串
		userGender : function(value,row,index){
			switch(value) {
			case 1 : 
				return '先生';
			case 0 : 
				return '女士';
			}
		},
		// 用户状态转字符串
		userState : function(value,row,index){
			if (value) {
				if (value == 1)
					return '启用';
				else
					return '停用';
			}
		},
		// 用户类型转字符串
		userType : function(value,row,index){
			if (value) {
				switch(value) {
					case 1 : 
						return '400客服';
					case 2 : 
						return '律师助理';
					case 3 :
						return '律师';
				}
			}
		},
		// 用户状态转字符串
		roleState : function(value,row,index){
			if (value)
				return '启用';
			else
				return '停用';
		},
		// 案件类型
		caseType : function(value,row,index){
			switch(value){
				case 0:
					return '非诉讼';
				case 1:
					return '诉讼';
			}
		},
		// 诉讼类型
		litigationType : function(value,row,index){
			switch(value){
				case 1:
					return '民事';
				case 2:
					return '刑事';
				case 3:
					return '行政';
				case 4:
					return '法律顾问';
				case 5:
					return '专项法律服务';
				case 6:
					return '劳动仲裁';
				case 7:
					return '商事仲裁';
				case 8:
					return '资讯解答';
				case 9:
					return '代书';
				case 10:
					return '其他';
			}
		},
		// 案件阶段
		casePhase : function(value,row,index){
			switch(value){
				case 1:
					return '侦查阶段';
				case 2:
					return '审查起诉阶段';
				case 3:
					return '行政裁决阶段';
				case 4:
					return '行政复议阶段';
				case 5:
					return '一审';
				case 6:
					return '二审';
				case 7:
					return '再审';
			}
		}
	};
	
	// 扩展easyui
	$.extend($.fn.validatebox.defaults.rules, {
		equals : {
			validator : function(value, param) {
				return value == $(param[0]).val();
			},
			message : '值不匹配'
		}
	});
</script>
