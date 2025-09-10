package com.dogfeetbirdfeet.ivorypilatesbackend.controller.acct;

import java.util.List;

import com.dogfeetbirdfeet.ivorypilatesbackend.component.util.commonMethod.CommonMethod;
import com.dogfeetbirdfeet.ivorypilatesbackend.component.util.maker.ApiResponse;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

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
	@GetMapping("/getAllAccts")
	public ResponseEntity<List<Acct>> getAllAccts() {
		return ResponseEntity.ok(acctService.getAllAccts());
	}

	/**
	 * 아이디에 일치하는 계정 반환
	 * @author nks
	 * @param acctId 대상 계정 아이디
	 * @return 계정 정보
	 */
	@GetMapping("/getAcctById")
	public ResponseEntity<Acct> getAcctById(@RequestParam String acctId) {
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
    @PostMapping("/insertAcct")
    public ResponseEntity<ApiResponse<Acct>> insertAcct(@RequestBody Acct acct, @RequestParam String userId) {
        return commonMethod.responseTransaction(acctService.insertAcct(acct, userId));
    }
}
