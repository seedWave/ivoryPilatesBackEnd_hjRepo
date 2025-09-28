package com.dogfeetbirdfeet.ivorypilatesbackend.service.acct;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dogfeetbirdfeet.ivorypilatesbackend.component.util.commonMethod.CommonMethod;
import com.dogfeetbirdfeet.ivorypilatesbackend.component.util.maker.ServiceResult;
import com.dogfeetbirdfeet.ivorypilatesbackend.dto.Enum.ResponseMsg;
import com.dogfeetbirdfeet.ivorypilatesbackend.dto.schema.Acct;
import com.dogfeetbirdfeet.ivorypilatesbackend.mapper.acct.AcctMapper;

@Service
public class AcctService {

	private final AcctMapper acctMapper;
	private static final CommonMethod commonMethod = new CommonMethod();

	public AcctService(final AcctMapper acctMapper) {
		this.acctMapper = acctMapper;
	}

	public List<Acct> getAllAccts() {
		return postProcessingAcctTables(acctMapper.getAllAccts());
	}

	/**
	 * 계정 ID와 일치하는 계정 반환한다.
	 *
	 * @author nks
	 * @param acctId 대상 계정 아이디
	 * @return 계정 정보
	 */
	public Acct getAcctById(@Param("acctId") String acctId) {

		return postProcessingAcctTable(acctMapper.getAcctById(acctId));
	}

	/**
	 * 계정 목록 반환 시 후처리 진행 한다.
	 * DTM(YYYYmmDD) -> YYYY년 MM월 DD일
	 * PictureId 있을 경우 -> PictureUrl Setting
	 *
	 * @author nks
	 * @param accts 대상 계정 리스트
	 * @return 후처리 후 대상 유저 리스트
	 */
	public List<Acct> postProcessingAcctTables(List<Acct> accts) {

		for (Acct acct : accts) {
			postProcessingAcctTable(acct);
		}

		return accts;
	}

	/**
	 * 유저 반환 시 후처리 진행 한다.
	 * DTM(YYYYmmDD) -> YYYY년 MM월 DD일
	 * PictureId 있을 경우 -> PictureUrl Setting
	 *
	 * @author nks
	 * @param user 대상 유저
	 * @return 후처리 후 대상 유저
	 */
	public Acct postProcessingAcctTable(Acct user) {

		if (null == user)
			return null;
		user.setBirthDate(null != user.getBirthDate() ? commonMethod.translateDate(user.getBirthDate()) : null);
		user.setRegDtm(null != user.getRegDtm() ? commonMethod.translateDate(user.getRegDtm()) : null);
		user.setModDtm(null != user.getModDtm() ? commonMethod.translateDate(user.getModDtm()) : null);

		return user;
	}

	/**
	 * 계정 생성
	 *
	 * @param acct 생성 계정 객체
	 * @param userId 생성하는 계정 ID
	 * @return 생성된 객체 정보
	 */
	@Transactional(rollbackFor = Exception.class) public ServiceResult<Acct> insertAcct(Acct acct, String userId) {

		ResponseMsg fsMsg = commonMethod.returnResultByResponseMsg(
			acctMapper.insertAcct(acct, userId));

		if (!fsMsg.equals(ResponseMsg.ON_SUCCESS)) {
			return ServiceResult.failure(fsMsg);
		}

		return ServiceResult.success(() -> getAcctById(acct.getAcctId()));
	}
}
