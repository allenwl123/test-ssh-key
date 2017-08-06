package com.allen.usermanage.interceptor;

import java.util.List;
import com.jfinal.aop.Interceptor;
import com.jfinal.core.ActionInvocation;
import com.jfinal.plugin.activerecord.Record;

public class LoginInterceptor implements Interceptor{
	@Override
	public void intercept(ActionInvocation paramActionInvocation) {
		System.out.println("****************拦截器打印信息开始************");
		String uri = paramActionInvocation.getActionKey();
		System.out.println("当前URI为："+uri);
		System.out.println("************拦截器打印信息完毕************");
		paramActionInvocation.invoke();
	}
}
