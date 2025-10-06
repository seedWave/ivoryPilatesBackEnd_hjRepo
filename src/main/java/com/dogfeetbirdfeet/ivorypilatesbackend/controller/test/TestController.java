package com.dogfeetbirdfeet.ivorypilatesbackend.controller.test;

import java.util.List;

import org.springframework.http.ResponseEntity;

import com.dogfeetbirdfeet.ivorypilatesbackend.dto.searchdto.TestSearchDto;
import com.dogfeetbirdfeet.ivorypilatesbackend.service.test.TestService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ModelAttribute;

@RestController
@RequestMapping("/test")
public class TestController {

    private final TestService testService;

    public TestController(TestService testService) {
        this.testService = testService;
    }

    /**
     * 테스트용 모든 테이블 반환
     *
     * @param tableName 반환할 테이블 이름 (camelCase)
     * @param dto       조회 조건
     * @return 대상 테이블 모든 정보
     * @
     */
    @GetMapping("/{tableName}")
    public ResponseEntity<List<?>> getTableInfo(@PathVariable String tableName, @ModelAttribute TestSearchDto dto) {

        System.out.println(tableName);
        System.out.println(dto);
        return ResponseEntity.ok(testService.getTableInfo(tableName, dto));
    }
}
