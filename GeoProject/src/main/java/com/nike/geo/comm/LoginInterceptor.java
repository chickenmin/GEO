package com.nike.geo.comm;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class LoginInterceptor implements HandlerInterceptor{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		log.info("LoginInterceptor - 인터셉터 진입");
//		
//		String requestURI = request.getRequestURI();
//		if(requestURI.equals("/GeoProject/login.do") || requestURI.startsWith("/resources/")) {
//			return true;
//		}
//		
//		HttpSession session = request.getSession(false);
//		if(session == null || session.getAttribute("loginVo") == null) {
//			log.info("LoginInterceptor - 미인증 사용자 요청");
//			log.info("LoginInterceptor - 로그인 확인 : {}", session.getAttribute("loginVo"));
//			response.sendRedirect("./errorLogin.do");
//			return false;
//		} else {
//			return true;
//		}
		return true;
	}
	
}
