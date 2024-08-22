package com.nike.geo.comm;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
public class DaoLogAdvice {
	
	public void before(JoinPoint j) {
		Logger logger = LoggerFactory.getLogger(j.getTarget()+"");
		logger.info("[AOP 메소드 시작]");
		Object[]  obj = j.getArgs();
		if (obj != null && obj.length != 0) {
			logger.info("[AOP 실행 메소드명] \t{}",j.getSignature().getName());
			for (int i=0;i<obj.length;i++) {
				logger.info("파라미터"+i+"번째:\t"+obj[i].toString());
			}
			logger.info("[AOP Logger before]: \t{}",j.getSignature().getName());
		}
	}
	
	
	
	public void afterReturning(JoinPoint j, Object returnValue) {
		Logger log = LoggerFactory.getLogger(j.getTarget()+"");
		log.info("[AOP Logger 반환결과]:\t {}",returnValue);
	}
	
	
	public void error(JoinPoint j, Exception e) {
		 Logger logger = LoggerFactory.getLogger(j.getTarget()+"");
		 logger.info("에러 \t{}",j.getArgs());
		 logger.info("에러 \t{}",e.toString());
	}

}

