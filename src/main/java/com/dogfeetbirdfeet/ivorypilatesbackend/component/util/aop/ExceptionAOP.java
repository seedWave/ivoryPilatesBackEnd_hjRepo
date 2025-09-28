package com.dogfeetbirdfeet.ivorypilatesbackend.component.util.aop;

import lombok.extern.slf4j.Slf4j;

import java.util.Arrays;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Configuration;

/**
 * @author nks
 * @apiNote Exception 발생 추적을 위한 AOP
 */
@Aspect
@Configuration
@Slf4j
public class ExceptionAOP {

	protected final Logger logger = LoggerFactory.getLogger(getClass());

	/**
	 * Exception 발생 시 AOP
	 * @param joinPoint 실행되는 메서드
	 * @param ex Exception
	 */
	@AfterThrowing(pointcut = "within(com.dogfeetbirdfeet.ivorypilatesbackend..*) || within(com.dogfeetbirdfeet.ivorypilatesbackend..*)", throwing = "ex")
	public void logException(JoinPoint joinPoint, Throwable ex) {
		String method = joinPoint.getSignature().toShortString();
		String args = Arrays.toString(joinPoint.getArgs());
		logger.error("Exception in {} with args={} -> {}: {}",
			method, args, ex.getClass().getSimpleName(), ex.getMessage(), ex);
	}
}
