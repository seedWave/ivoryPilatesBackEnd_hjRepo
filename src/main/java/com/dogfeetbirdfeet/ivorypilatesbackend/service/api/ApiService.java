package com.dogfeetbirdfeet.ivorypilatesbackend.service.api;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
import org.json.XML;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dogfeetbirdfeet.ivorypilatesbackend.component.util.commonMethod.CommonMethod;
import com.dogfeetbirdfeet.ivorypilatesbackend.component.util.maker.ServiceResult;
import com.dogfeetbirdfeet.ivorypilatesbackend.dto.Enum.ResponseMsg;
import com.dogfeetbirdfeet.ivorypilatesbackend.dto.dataDTO.HolidayMstWithSchedDate;
import com.dogfeetbirdfeet.ivorypilatesbackend.mapper.calMst.CalMstMapper;
import com.dogfeetbirdfeet.ivorypilatesbackend.service.holidayMst.HolidayMstService;

/**
 * @author nks
 * @apiNote 외부 통신이 필요하거나, 내부 배치성 기능의 경우 위 ApiService를 사용한다.
 */
@Service
public class ApiService {

	private final CommonMethod commonMethod;
	@Value("${api.data-go-kr.key}") private String apiKey;

	private final HolidayMstService holidayMstService;
	private static final Logger API_LOG = LoggerFactory.getLogger("API_LOG");
	private final CalMstMapper calMstMapper;

	public ApiService(HolidayMstService holidayMstService, CalMstMapper calMstMapper, CommonMethod commonMethod) {
		this.holidayMstService = holidayMstService;
		this.calMstMapper = calMstMapper;
		this.commonMethod = commonMethod;
	}

	/**
	 * 캘린더를 만든다.
	 * 대상 테이블은 CAL_MST
	 * 모든 캘린더성 테이블은 CAL_MST - CAL_REL 을 기반으로 작동한다.
	 */
	@Transactional(rollbackFor = Exception.class) public void makeCalender(String staYmd) {

		// 20000101 ~ 99991231까지 25년 단위로 반복한다.

		DateTimeFormatter B = DateTimeFormatter.BASIC_ISO_DATE; // yyyyMMdd

		LocalDate start = LocalDate.parse(staYmd, B); // 20000101
		LocalDate limit = LocalDate.of(2999, 12, 31); // 루프 상한 (필요에 맞게)

		ResponseMsg fsMsg;

		while (!start.isAfter(limit)) {
			LocalDate end = start.plusYears(25).minusDays(1); // 25년 블록: 시작~(시작+25년-1일)
			if (end.isAfter(limit))
				end = limit;

			String s = start.format(B); // yyyyMMdd
			String e = end.format(B); // yyyyMMdd

			fsMsg = commonMethod.returnResultByResponseMsg(
				calMstMapper.makeCalMst(s, e));

			if (!fsMsg.equals(ResponseMsg.ON_SUCCESS) && !fsMsg.equals(ResponseMsg.MULTI_AFFECTED)) {
				API_LOG.error("makeCalMst failed: {} ~ {}, msg={}", s, e, fsMsg);
				return;
			}

			start = start.plusYears(25); // 다음 25년 블록으로
		}

	}

	/**
	 * 공공 데이터 포털 API 를 통해 특정 년, 특정 월의 공휴일 정보를 받아온다.
	 * 요청 할 URL을 구성한다.
	 *
	 * @param solYear 대상 년도
	 * @param solMonth 대상 월
	 */
	@Transactional(rollbackFor = Exception.class) public void getHolidayExplorer(String solYear, String solMonth) {

		/*URL*/
		String urlBuilder = "http://apis.data.go.kr/B090041/openapi/service/SpcdeInfoService/getRestDeInfo?"
			+ URLEncoder.encode("serviceKey", StandardCharsets.UTF_8)
			+ "="
			+ apiKey
			+ "&"
			+ URLEncoder.encode("solYear", StandardCharsets.UTF_8)
			+ "="
			+ URLEncoder.encode(solYear, StandardCharsets.UTF_8) /*연*/
			+ "&"
			+ URLEncoder.encode("solMonth", StandardCharsets.UTF_8)
			+ "="
			+ URLEncoder.encode(solMonth, StandardCharsets.UTF_8); /*월*/

		try {
			URL requestURL = URI.create(urlBuilder).toURL();
			getResultFromConnection(requestURL);
		} catch (IOException e) {
			API_LOG.error("IOException [{}]", e.getMessage());
		}
	}

	/**
	 * Connection 안정성을 위해 별도 메서드로 분리,
	 * Request URL 통해 Connection 을 열고, 공공데이터포탈의 결과 값을 xml 형태로 받아온다.
	 * xml 데이터는 JSONObject 형태로 변환 후, tableInsert 메서드 호출한다.
	 *
	 * @param requestURL 대상 경로 (공공데이터 포털)
	 * @throws IOException 입출력 오류
	 */
	@Transactional(rollbackFor = Exception.class) public void getResultFromConnection(URL requestURL)
		throws IOException {

		HttpURLConnection conn = (HttpURLConnection)requestURL.openConnection();
		BufferedReader rd = null;

		StringBuilder xmlResult = new StringBuilder();
		JSONObject responseBody;

		try {
			conn.setRequestMethod("GET");
			conn.setReadTimeout(5000);
			conn.setRequestProperty("Content-type", "application/json");

			if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
				rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			} else {
				rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
			}

			String line;

			while ((line = rd.readLine()) != null) {
				xmlResult.append(line);
			}

			rd.close();

		} catch (Exception e) {

			API_LOG.error("Exception [{}]", e.getMessage());
			assert rd != null;
			rd.close();
		} finally {
			conn.disconnect();
		}

		responseBody = XML.toJSONObject(xmlResult.toString()).getJSONObject("response").getJSONObject("body");

		tableInsert(responseBody);

	}

	/**
	 * 공공데이터 포탈에서 받아온 데이터를 HOLIDAY_MST 테이블에 INSERT 한다.
	 *
	 * @param jsonObject 공공데이터 포탈에서 받아온 결과값
	 */
	@Transactional(rollbackFor = Exception.class) public void tableInsert(JSONObject jsonObject) {

		int totalCount = jsonObject.getInt("totalCount");
		API_LOG.info("totalCount [{}]", totalCount);

		List<HolidayMstWithSchedDate> list = new ArrayList<>();
		JSONArray jsonArray = new JSONArray();

		if (totalCount <= 0)
			return;

		else if (totalCount == 1) {
			JSONObject target = jsonObject.getJSONObject("items").getJSONObject("item");
			jsonArray.put(target);
		} else {
			jsonArray = jsonObject.getJSONObject("items").getJSONArray("item");
		}

		for (int i = 0; i < jsonArray.length(); i++) {
			JSONObject target = jsonArray.getJSONObject(i);

			String dateName = target.getString("dateName");
			int locDate = target.getInt("locdate");
			String dateKind = target.getString("dateKind");
			String isHoliday = target.getString("isHoliday");
			int seq = target.getInt("seq");

			if (!isHoliday.equals("Y"))
				continue;

			HolidayMstWithSchedDate holidayMst = new HolidayMstWithSchedDate();
			holidayMst.setHoliNm(dateName);
			holidayMst.setSchedDate(String.valueOf(locDate));

			list.add(holidayMst);
			API_LOG.info("dateName [{}], locDate [{}], dateKind [{}], isHoliday [{}], seq [{}]", dateName, locDate,
				dateKind, isHoliday, seq);
		}

		// 트랜잭션 처리를 위해 List 형태로 보낸다. 해당 월의 모든 공휴일은 원자성을 지켜야 한다.
		ServiceResult<HolidayMstWithSchedDate> result = holidayMstService.insertHolidayMst(list);

		if (!result.status().equals(ResponseMsg.ON_SUCCESS)) {
			API_LOG.error("insertHolidayMst error [{}]", result.status());
		} else
			API_LOG.info("insertHolidayMst success");
	}

}
