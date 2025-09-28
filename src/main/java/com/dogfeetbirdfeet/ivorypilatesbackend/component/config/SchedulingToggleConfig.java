package com.dogfeetbirdfeet.ivorypilatesbackend.component.config;

import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;

/**
 * @author nks
 * @apiNote 전역 스케쥴러 설정. application.yml 에서 전역 스케쥴러 설정을 제어한다.
 */
@Configuration
@ConditionalOnProperty(value = "schedule.use", havingValue = "true")
@EnableScheduling
public class SchedulingToggleConfig {}
