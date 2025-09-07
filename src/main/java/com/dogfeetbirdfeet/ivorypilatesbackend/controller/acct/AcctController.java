package com.dogfeetbirdfeet.ivorypilatesbackend.controller.acct;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.dogfeetbirdfeet.ivorypilatesbackend.dto.acct.AcctDto;
import com.dogfeetbirdfeet.ivorypilatesbackend.service.acct.AcctService;

@RestController
@RequestMapping("/acct")
public class AcctController {

	private final AcctService acctService;

	public AcctController(AcctService acctService) {
		this.acctService = acctService;
	}

	/**
	 * 모든 계정 목록 반환
	 * @author nks
	 * @return 모든 계정 목록
	 */
	@GetMapping("/getAllAccts")
	public ResponseEntity<List<AcctDto>> getAllAccts() {
		return ResponseEntity.ok(acctService.getAllAccts());
	}

	/**
	 * 아이디에 일치하는 계정 반환
	 * @author nks
	 * @param acctId 대상 계정 아이디
	 * @return 계정 정보
	 */
	@GetMapping("/getAcctById")
	public ResponseEntity<AcctDto> getAcctById(@RequestParam String acctId) {
		return ResponseEntity.ok(acctService.getAcctById(acctId));
	}
}
