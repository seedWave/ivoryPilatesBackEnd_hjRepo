package com.dogfeetbirdfeet.ivorypilatesbackend.controller.test;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.dogfeetbirdfeet.ivorypilatesbackend.service.test.TestService;

@RestController
@RequestMapping("/test")
public class TestController {

	private final TestService testService;

	public TestController(TestService testService) {
		this.testService = testService;
	}

	/**
	 * 테스트용 모든 테이블 반환
	 * 
	 * @param tableName 반환할 테이블 이름 (camelCase)
	 * @return 대상 테이블 모든 정보
	 */
	@GetMapping()
	public ResponseEntity<List<?>> getTableInfo(String tableName) {
		return ResponseEntity.ok(testService.getTableInfo(tableName));
	}
}
