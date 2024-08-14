package com.nike.geo.comm;


import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class DaoLogAdvice {
	
	public void before(JoinPoint j) {
		Logger logger = LoggerFactory.getLogger(j.getTarget()+"");
		logger.info("메소드 시작");
		Object[]  obj = j.getArgs();
		if (obj != null && obj.length != 0) {
			logger.info("method \t{}",j.getSignature().getName());
			for (int i=0;i<obj.length;i++) {
				logger.info(i+"번째:\t"+obj[i].toString());
			}
			logger.info("method \t{}",j.getSignature().getName());
		}
	}
	
	
	public void afterReturning(JoinPoint j,Object returnValue) throws Throwable {
		Logger logger = LoggerFactory.getLogger(j.getTarget()+"");
		 ProceedingJoinPoint jp = (ProceedingJoinPoint)j;
		logger.info("반환 종류 : {}",jp.proceed());
	}
	
	
	public void error(JoinPoint j, Exception e) {
		 Logger logger = LoggerFactory.getLogger(j.getTarget()+"");
		 logger.info("에러 \t{}",j.getArgs());
		 logger.info("에러 \t{}",e.toString());

	}
	

}

























