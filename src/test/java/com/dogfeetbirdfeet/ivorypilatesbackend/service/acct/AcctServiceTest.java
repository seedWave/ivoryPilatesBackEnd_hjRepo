package com.dogfeetbirdfeet.ivorypilatesbackend.service.acct;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import java.nio.file.Path;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import com.dogfeetbirdfeet.ivorypilatesbackend.component.util.docs.SnippetWriter;
import com.dogfeetbirdfeet.ivorypilatesbackend.dto.Enum.Gender;
import com.dogfeetbirdfeet.ivorypilatesbackend.dto.Enum.YN;
import com.dogfeetbirdfeet.ivorypilatesbackend.dto.schema.Acct;
import com.dogfeetbirdfeet.ivorypilatesbackend.mapper.acct.AcctMapper;

/**
 * @author nks
 * Unit test for {#{@link AcctService}}
 * <p>
 *     This test verifies that an acct is correctly selected through
 *        {@link AcctService#getAcctById(String)}
 * 	using a mocked {#{@link com.dogfeetbirdfeet.ivorypilatesbackend.mapper.acct.AcctMapper}}
 * </p>
 */
public class AcctServiceTest {

	private SnippetWriter writer() {
		return new SnippetWriter(Path.of("build/generated-snippets"));
	}

	@Test
	@DisplayName("GET /acct - 계정 조회 API 테스트 - 성공") void testGetAcctByIdTestSuccess() {

		// ✅ Arrange
		Acct acctDto = new Acct();
		acctDto.setAcctId("A000001");
		acctDto.setAcctPw("PWD");
		acctDto.setName("관리자01");
		acctDto.setContact("010-2592-3017");
		acctDto.setBirthDate("20250527");
		acctDto.setGender(Gender.W);
		acctDto.setActiveYn(YN.Y);
		acctDto.setRegDtm("20250907");
		acctDto.setRegId("SYS");
		acctDto.setModDtm("20250907");
		acctDto.setModId("SYS");

		AcctMapper mockMapper = mock(AcctMapper.class);

		when(mockMapper.getAcctById(acctDto.getAcctId())).thenReturn(acctDto);

		AcctService acctService = new AcctService(mockMapper);

		// ✅ Act
		Acct result = acctService.getAcctById(acctDto.getAcctId());

		// ✅ Assert
		assertNotNull(result);
		assertEquals("A000001", result.getAcctId());
		assertEquals("PWD", result.getAcctPw());
		assertEquals("관리자01", result.getName());
		assertEquals("010-2592-3017", result.getContact());
		assertEquals("2025년 05월 27일", result.getBirthDate()); // 변환 확인
		assertEquals(Gender.W, result.getGender());
		assertEquals(YN.Y, result.getActiveYn());
		assertEquals("2025년 09월 07일", result.getRegDtm()); // 변환 확인
		assertEquals("SYS", result.getRegId());
		assertEquals("2025년 09월 07일", result.getModDtm()); // 변환 확인
		assertEquals("SYS", result.getModId());

		verify(mockMapper, times(1)).getAcctById(acctDto.getAcctId());

		// 🔽 문서 스니펫 생성 (서비스 문서용)
		var w = writer();
		w.writeJson("service/acct/getAcctById/success/response.json", result);
		w.writeAdoc("service/acct/getAcctById/success/description.adoc",
			"""
				이 스니펫은 *Service 레이어*에서 `getAcctById` 성공 케이스입니다.

				* 입력: `acctId = A000001`
				* 처리: Mapper → Service 후처리
				* 결과: 계정 DTO
				""");

	}

	@Test
	@DisplayName("Service: getAcctById - 실패(null)") void testGetAcctById_Fail_Null() {
		AcctMapper mockMapper = mock(AcctMapper.class);
		when(mockMapper.getAcctById("B000001")).thenReturn(null);

		AcctService acctService = new AcctService(mockMapper);

		Acct result = acctService.getAcctById("B000001");

		assertNull(result);
		verify(mockMapper, times(1)).getAcctById("B000001");

		var w = writer();
		// 실패 케이스는 보통 빈 JSON 예시 or 설명만
		w.writeText("service/acct/getAcctById/fail/response-empty.txt", "(null)  // 서비스는 null 반환");
		w.writeAdoc("service/acct/getAcctById/fail/description.adoc",
			"""
				이 스니펫은 *Service 레이어*에서 `getAcctById` 실패(null) 케이스입니다.

				* 입력: `acctId = B000001`
				* 결과: `null` (컨트롤러에서 200 OK + 빈 바디로 변환하는 정책과 구분)
				""");
	}

}