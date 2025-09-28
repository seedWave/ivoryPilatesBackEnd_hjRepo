package com.dogfeetbirdfeet.ivorypilatesbackend.controller.acct;

import static org.mockito.Mockito.*;
import static org.springframework.restdocs.mockmvc.MockMvcRestDocumentation.*;
import static org.springframework.restdocs.payload.PayloadDocumentation.*;
import static org.springframework.restdocs.request.RequestDocumentation.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.restdocs.AutoConfigureRestDocs;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.http.MediaType;
import org.springframework.restdocs.payload.JsonFieldType;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.web.servlet.MockMvc;

import com.dogfeetbirdfeet.ivorypilatesbackend.dto.Enum.Gender;
import com.dogfeetbirdfeet.ivorypilatesbackend.dto.Enum.YN;
import com.dogfeetbirdfeet.ivorypilatesbackend.dto.schema.Acct;
import com.dogfeetbirdfeet.ivorypilatesbackend.service.acct.AcctService;
import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * @author nks
 * Unit test for {@link AcctController}.
 * <p>
 *     This test verifies that an acct is correctly selected through
 *        {@link AcctController#getAcctById(String)}
 * 	using a mocked {@link com.dogfeetbirdfeet.ivorypilatesbackend.mapper.acct.AcctMapper}
 * </p>
 */
@WebMvcTest(value = {AcctController.class})
@AutoConfigureRestDocs(outputDir = "build/generated-snippets/acct/controller")
@WithMockUser("nks")
public class AcctControllerSelectTest {

	@Autowired
	private MockMvc mockMvc;

	@MockitoBean
	private AcctService acctService;

	@Autowired
	private ObjectMapper objectMapper;

	@Test
	@DisplayName("GET /acct - 계정 조회 API 테스트 - 성공")
	void getAcctByIdTestSuccess() throws Exception {

		// ✅ Given
		Acct acctDto = new Acct();
		acctDto.setAcctId("A000001");
		acctDto.setAcctPw("PWD");
		acctDto.setName("관리자01");
		acctDto.setContact("010-2592-3017");
		acctDto.setBirthDate("2025년 05월 27일");
		acctDto.setGender(Gender.W);
		acctDto.setActiveYn(YN.Y);
		acctDto.setRegDtm("2025년 09월 07일");
		acctDto.setRegId("SYS");
		acctDto.setModDtm("2025년 09월 07일");
		acctDto.setModId("SYS");

		String expectedJson = objectMapper.writeValueAsString(acctDto);

		// ✅ When
		when(acctService.getAcctById("A000001")).thenReturn(acctDto);

		// ✅ Then
		mockMvc.perform(get("/acct/getAcctById")
				.contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(acctDto))
				.param("acctId", "A000001"))
			.andExpect(status().isOk())
			.andExpect(content().json(expectedJson))
			.andDo(document("acct-get-by-id",
				queryParameters(
					parameterWithName("acctId").description("대상 계정 아이디")
				),
				responseFields(
					fieldWithPath("acctId").optional().type(JsonFieldType.STRING).description("계정 ID"),
					fieldWithPath("acctPw").optional().type(JsonFieldType.STRING).description("계정 비밀번호"),
					fieldWithPath("name").type(JsonFieldType.STRING).description("이름"),
					fieldWithPath("contact").type(JsonFieldType.STRING).description("연락처"),
					fieldWithPath("birthDate").type(JsonFieldType.STRING).description("생년월일"),
					fieldWithPath("gender").type(JsonFieldType.STRING).description("성별"),
					fieldWithPath("activeYn").type(JsonFieldType.STRING).description("활성 여부(Y/N)"),
					fieldWithPath("regDtm").type(JsonFieldType.STRING).description("등록 일시"),
					fieldWithPath("regId").type(JsonFieldType.STRING).description("등록자 ID"),
					fieldWithPath("modDtm").type(JsonFieldType.STRING).description("수정 일시"),
					fieldWithPath("modId").type(JsonFieldType.STRING).description("수정자 ID")
				)
			));
	}

	@Test
	@DisplayName("GET /acct - 계정 조회 API 테스트 - 실패")
	void getAcctByIdTestFail() throws Exception {

		// ✅ Given
		Acct acctDto = new Acct();
		acctDto.setAcctId("B000001");

		// ✅ When
		when(acctService.getAcctById("B000001")).thenReturn(null);

		// ✅ Then
		mockMvc.perform(get("/acct/getAcctById")
				.contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(acctDto))
				.param("acctId", "B000001"))
			.andExpect(status().isOk())
			.andDo(document("acct-get-by-id",
				queryParameters(
					parameterWithName("acctId").description("대상 계정 아이디")
				),
				responseBody()
			));
	}
}
