package com.dogfeetbirdfeet.ivorypilatesbackend.controller.commoncode;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.dogfeetbirdfeet.ivorypilatesbackend.dto.schema.CodeDtl;
import com.dogfeetbirdfeet.ivorypilatesbackend.service.commoncode.CommonCodeService;

import lombok.extern.slf4j.Slf4j;

/**
 * @author nks
 * 공통코드 조회를 위한 Controller
 */
@Slf4j
@RestController
@RequestMapping("/commoncode")
public class CommonCodeController {

	private final CommonCodeService commonCodeService;

	public CommonCodeController(CommonCodeService commonCodeService) {
		this.commonCodeService = commonCodeService;
	}

	/**
	 * 공통코드 마스터 ID에 해당하는 공통코드 목록 반환
	 *
	 * @param codeMstId 대상 마스터 코드 ID
	 * @return 대상 공통코드 목록
	 * @author nks
	 */
	@GetMapping("/{codeMstId}")
	public ResponseEntity<List<CodeDtl>> getAllCommonCode(@PathVariable int codeMstId) {

		log.info("RESULT : {}", commonCodeService.selectCommonCode(codeMstId).getFirst());
		return ResponseEntity.ok(commonCodeService.selectCommonCode(codeMstId));
	}
}
