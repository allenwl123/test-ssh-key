package com.allen.usermanage.controller;

import com.jfinal.core.Controller;

public class BaseController extends Controller {

	/**
	 * 获取参数并转换为Integer，如果参数数据类型转换异常返回null
	 * @param name
	 * @return
	 */
	public Integer getParaToIntOrNull(String name) {
		String str = super.getPara(name);
		if (str == null)
			return null;
		try {
			return Integer.parseInt(str);
		} catch (NumberFormatException e) {
			return null;
		}
	}
	
	/**
	 * 获取参数并转换为Integer，如果参数数据类型转换异常返回指定的默认�?
	 * @param name
	 * @return
	 */
	public Integer getParaToIntOrDefault(String name, Integer defaultValue) {
		String str = super.getPara(name);
		if (str == null)
			return defaultValue;
		try {
			return Integer.parseInt(str);
		} catch (NumberFormatException e) {
			return defaultValue;
		}
	}
	
	public String getParaStrOrDefault(String name, String defaultValue) {
		String str = super.getPara(name);
		if (str == null || "".equals(str.trim()))
			return defaultValue;
	    return  str;
	}

}
