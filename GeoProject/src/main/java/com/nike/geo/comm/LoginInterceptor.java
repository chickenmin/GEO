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
		
		String requestURI = request.getRequestURI();
		if(requestURI.equals("/GeoProject/login.do") || requestURI.startsWith("/resources/")
													 || requestURI.equals("/GeoProject/errorLogin.do")
													 || requestURI.equals("/GeoProject/tempPw.do")) {
			return true;
		}
		
		HttpSession session = request.getSession(false);
		if(session == null || session.getAttribute("loginVo") == null) {
			log.info("LoginInterceptor - 미인증 사용자 요청");
			
			if (session == null) {
				log.info("LoginInterceptor - 세션이 존재하지 않습니다.");
			} else {
				log.info("LoginInterceptor - 로그인 확인 : {}", session.getAttribute("loginVo"));
			}
			
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().write(
					"<script>alert('로그인이 필요합니다.'); location.href='./login.do';</script>"
					);
			response.getWriter().flush();
			return false;
		} else {
			log.info("LoginInterceptor - 로그인 확인 : {}", session.getAttribute("loginVo"));
			return true;
		}
	}
	
}
