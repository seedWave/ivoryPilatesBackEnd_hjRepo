package com.dogfeetbirdfeet.ivorypilatesbackend.controller.acct;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.dogfeetbirdfeet.ivorypilatesbackend.component.util.commonmethod.CommonMethod;
import com.dogfeetbirdfeet.ivorypilatesbackend.component.util.maker.ApiResponse;
import com.dogfeetbirdfeet.ivorypilatesbackend.dto.schema.Acct;
import com.dogfeetbirdfeet.ivorypilatesbackend.service.acct.AcctService;

@RestController
@RequestMapping("/acct")
public class AcctController {

	private final AcctService acctService;
	private static final CommonMethod commonMethod = new CommonMethod();

	public AcctController(AcctService acctService) {
		this.acctService = acctService;
	}

	/**
	 * 모든 계정 목록 반환
	 * @author nks
	 * @return 모든 계정 목록
	 */
	@GetMapping()
	public ResponseEntity<List<Acct>> getAllAccts() {
		return ResponseEntity.ok(acctService.getAllAccts());
	}

	/**
	 * 아이디에 일치하는 계정 반환
	 * @author nks
	 * @param acctId 대상 계정 아이디
	 * @return 계정 정보
	 */
	@GetMapping("/{acctId}")
	public ResponseEntity<Acct> getAcctById(@PathVariable Long acctId) {
		return ResponseEntity.ok(acctService.getAcctById(acctId));
	}

	/**
	 * 계정을 생성한다.
	 *
	 * @author nks
	 * @param acct 생성 계정 정보
	 * @param userId 생성하는 계정 아이디
	 * @return 생성된 계정 정보
	 */
	@PostMapping()
	public ResponseEntity<ApiResponse<Acct>> insertAcct(@RequestBody Acct acct,
		@RequestParam String userId) {
		return commonMethod.responseTransaction(acctService.insertAcct(acct, userId));
	}
}
