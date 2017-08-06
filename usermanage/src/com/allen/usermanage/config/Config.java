package com.allen.usermanage.config;

import com.allen.usermanage.controller.*;
import com.allen.usermanage.interceptor.LoginInterceptor;
import com.allen.usermanage.model.*;
import com.jfinal.config.Constants;
import com.jfinal.config.Handlers;
import com.jfinal.config.Interceptors;
import com.jfinal.config.JFinalConfig;
import com.jfinal.config.Plugins;
import com.jfinal.config.Routes;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.jfinal.plugin.c3p0.C3p0Plugin;
import com.jfinal.render.ViewType;

public class Config extends JFinalConfig {

	@Override
	public void configConstant(Constants me) {
		loadPropertyFile("classes/resources/jdbc/jdbc.properties");
		me.setDevMode(getPropertyToBoolean("devMode", false));
		me.setViewType(ViewType.JSP);
		me.setBaseViewPath("/WEB-INF/jsp");
		me.setMaxPostSize(1024 * 1024 * 50);
	}
	
	@Override
	public void configInterceptor(Interceptors me) {
		me.add(new LoginInterceptor());
	}

	@Override
	public void configRoute(Routes me) {
		me.add("/", IndexController.class);
		me.add("/admin/admin", AdminController.class);
	}

	@Override
	public void configPlugin(Plugins me) {
		C3p0Plugin c3p0Plugin = new C3p0Plugin(getProperty("jdbc_url"), getProperty("jdbc_username"), getProperty("jdbc_password"));
		me.add(c3p0Plugin);
		
		ActiveRecordPlugin arp = new ActiveRecordPlugin(c3p0Plugin);
		me.add(arp);
		arp.addMapping("admin", Admin.class);
	}

	@Override
	public void configHandler(Handlers me) {
		
	}

}