package com.dogfeetbirdfeet.ivorypilatesbackend.component.config;

import java.time.Year;
import java.time.ZoneId;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.Scheduled;

import com.dogfeetbirdfeet.ivorypilatesbackend.service.api.ApiService;

import lombok.RequiredArgsConstructor;

/**
 * @author nks
 * @apiNote Schedule Config
 * 			개별 스케쥴러들의 작동 방식을 정의, 수행한다.
 */
@Configuration
@RequiredArgsConstructor
public class ScheduleConfig {

	private static final Logger API_LOG = LoggerFactory.getLogger("API_LOG");
	private final ApiService apiService;

	@Value("${schedule.ivory-holiday.useItem}")
	private boolean useIvoryHolidaySchedule;

	/**
	 * @author nks
	 * <p>
	 * 공공데이터 포탈에 접속하여 공휴일 정보를 받아오는 스케쥴러
	 * 매일 오전 3시 접속하여 공휴일 정보를 받아온다.
	 * 받아온 정보는 HOLIDAY_MST 테이블에 저장한다.
	 * 가져올 때 당해 년도, 내년, 내 후년까지 2년 데이터를 가져온다.
	 * </p>
	 */
	@Scheduled(cron = "${schedule.ivory-holiday.cron}")
	public void ivoryHoliday() {

		String thisYear = Year.now(ZoneId.of("Asia/Seoul")).toString();
		String nextYear = Year.now(ZoneId.of("Asia/Seoul")).plusYears(1).toString();
		String twoYear  = Year.now(ZoneId.of("Asia/Seoul")).plusYears(2).toString();

		try
		{
			if(useIvoryHolidaySchedule) {

				for (int i = 1; i <= 12; i++)
				{
					apiService.getHolidayExplorer(thisYear, i < 10 ? "0" + i : i + "");
				}

				for (int i = 1; i <= 12; i++)
				{
					apiService.getHolidayExplorer(nextYear, i < 10 ? "0" + i : i + "");
				}

				for (int i = 1; i <= 12; i++)
				{
					apiService.getHolidayExplorer(twoYear, i < 10 ? "0" + i : i + "");
				}
			}
		} catch (Exception e) {
			API_LOG.error("ivoryHoliday error [{}]", e.getMessage());
		}

	}
}
