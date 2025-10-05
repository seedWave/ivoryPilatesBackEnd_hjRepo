package com.dogfeetbirdfeet.ivorypilatesbackend.service.commoncode;

import java.util.List;

import org.springframework.stereotype.Service;

import com.dogfeetbirdfeet.ivorypilatesbackend.dto.schema.CodeDtl;
import com.dogfeetbirdfeet.ivorypilatesbackend.mapper.commoncode.CommonCodeMapper;

/**
 * @author nks
 * 공통 코드 조회를 위한 서비스
 */
@Service
public class CommonCodeService {

	private final CommonCodeMapper commonCodeMapper;

	public CommonCodeService(CommonCodeMapper commonCodeMapper) {
		this.commonCodeMapper = commonCodeMapper;
	}

	public List<CodeDtl> selectCommonCode(int codeMstId) {
		return commonCodeMapper.selectCommonCode(codeMstId);
	}
}
