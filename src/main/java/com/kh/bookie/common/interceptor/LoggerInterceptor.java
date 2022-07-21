package com.kh.bookie.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import lombok.extern.slf4j.Slf4j;

/**
 * interceptor
 * 	- DispatcherServlet에서 Controller의 Handler메소드 호출 직전에 개입한다.
 *  - HandlerInterceptorAdapter class 상속받으면 됨
 *  - 1. preHandle
 *  - 2. postHandle
 *  - 3. afterCompletion
 *
 */
@Slf4j
public class LoggerInterceptor extends HandlerInterceptorAdapter{
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		log.debug("====================================================================");
		log.debug(request.getRequestURI());
		log.debug("--------------------------------------------------------------------");
		// true를 리턴해야 다음 Handler로 연결될 수 있다.
		return super.preHandle(request, response, handler); // 항상 true를 리턴
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		super.postHandle(request, response, handler, modelAndView);
		log.debug("--------------------------------------------------------------------");
		log.debug("modelAndView = {}", modelAndView);
		log.debug("--------------------------------------------------------------------");
	}
	
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		super.afterCompletion(request, response, handler, ex);
		log.debug("____________________________________________________________________");
		log.debug("{}\n", response.getStatus());
	}
}
