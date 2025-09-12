package com.dogfeetbirdfeet.ivorypilatesbackend.controller.api;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.dogfeetbirdfeet.ivorypilatesbackend.service.api.ApiService;

/**
 * @author nks
 * @apiNote API Controller, 스케쥴러, 배치 성 기능에 대한 엔드포인트
 */
@RestController
@RequestMapping("/api")
public class ApiController {

	private final ApiService apiService;

	public ApiController(ApiService apiService) {
		this.apiService = apiService;
	}

	/**
	 * @author nks
	 * @apiNote 공공데이터 포탈에서 공휴일 가져오기 위한 엔드포인트 메서드
	 */
	@GetMapping("getHoliday")
	public void getHoliday() {

		apiService.getHolidayExplorer("2025", "10");

	}
}
