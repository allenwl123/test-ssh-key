package com.allen.usermanage.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;

import com.allen.usermanage.model.Admin;
import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.activerecord.tx.Tx;
/**
 * 用户管理控制器
 * @author Administrator
 *
 */
public class AdminController extends BaseController {
	//显示用户管理页面
	public void index(){
		render("index.jsp");
	}
	//查询
	public void find(){
		//获取参数
		String name = getPara("name");
		int page = getParaToInt("page");
		int rows = getParaToInt("rows");
		Page<Record> pageRows = null;
		//拼接sql语句
		String select = "SELECT *";
		String sqlExceptSelect = "FROM admin";
		String where = " WHERE ";
		String orderBy = " ORDER BY created_time DESC ";
		//参数列表
		ArrayList<Object> paras = new ArrayList<>();
		if (name != null && !"".equals(name.trim())) {
			where += " username LIKE CONCAT('%|',?,'%') ESCAPE '|' ";
			paras.add(name);
		}
		if (paras.size() < 1)
			pageRows = Db.paginate(page, rows, select, sqlExceptSelect + orderBy);
		else
			pageRows = Db.paginate(page, rows, select, sqlExceptSelect + where + orderBy , paras.toArray());
		int totalRow = pageRows.getTotalRow();
		setAttr("total", totalRow);
		setAttr("rows", pageRows.getList());
		//返回结果
		renderJson(new String[]{"total","rows"});
	}
	//添加
	@Before(Tx.class)
	public void add(){
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			//获取参数
			String username = getPara("username");
			String sex = getPara("sex");
			String age = getPara("age");
			Admin admin = new Admin();
			admin.set("username", username);
			admin.set("sex", sex);
			admin.set("age", age);
			Date date = new Date();
			admin.set("created_time", date);
			admin.set("updated_time",date);
			admin.save();
			map.put("result","success");
			map.put("msg","操作成功");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("result","fail");
			map.put("msg",e.getMessage());
		}
		renderJson(map);
	}
	//删除
	@Before(Tx.class)
	public void delete(){
		Map<String,Object> map = new HashMap<String,Object>();
		try{
			String id  = getPara("id");
			Admin.dao.deleteById(id);
			map.put("result","success");
			map.put("msg","操作成功");
		}catch(Exception e){
			map.put("result","fail");
			map.put("msg","操作失败"+e.getMessage());
		}
		renderJson(map);
	}
	//修改
	@Before(Tx.class)
	public void edit(){
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			//获取参数
			String id = getPara("id");
			String username = getPara("username");
			String sex = getPara("sex");
			String age = getPara("age");
			Admin admin = Admin.dao.findById(id);
			admin.set("username", username);
			admin.set("sex", sex);
			admin.set("age", age);
			admin.set("updated_time",new Date());
			admin.update();
			map.put("result","success");
			map.put("msg","操作成功");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("result","fail");
			map.put("msg",e.getMessage());
		}
		renderJson(map);
	}
}
