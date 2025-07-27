package com.dogfeetbirdfeet.ivorypilatesbackend.controller.acct;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
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

	@GetMapping
	public List<AcctDto> getAllAcct() {
		return acctService.findAllAcct();
	}
}
