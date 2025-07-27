package com.dogfeetbirdfeet.ivorypilatesbackend.service.acct;

import java.util.List;

import org.springframework.stereotype.Service;

import com.dogfeetbirdfeet.ivorypilatesbackend.dto.acct.AcctDto;
import com.dogfeetbirdfeet.ivorypilatesbackend.mapper.acct.AcctMapper;

@Service
public class AcctService {

	private final AcctMapper acctMapper;

	public AcctService(final AcctMapper acctMapper) {
		this.acctMapper = acctMapper;
	}

	public List<AcctDto> findAllAcct() {

		return acctMapper.findAll();
	}
}
