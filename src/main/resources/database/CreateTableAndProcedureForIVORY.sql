USE IVORY;

-- 기존 테이블 삭제
DROP TABLE IF EXISTS `ACCT_ROLE`;
DROP TABLE IF EXISTS `CLS_PAY_INFO`;
DROP TABLE IF EXISTS `CODE_DTL`;
DROP TABLE IF EXISTS `CODE_MST`;
DROP TABLE IF EXISTS `CUS_REG`;
DROP TABLE IF EXISTS `CUS_WDR`;
DROP TABLE IF EXISTS `CLS_PASS`;
DROP TABLE IF EXISTS `ROLES`;
DROP TABLE IF EXISTS `SCHED_HIST`;
DROP TABLE IF EXISTS `CUS_GRP`;
DROP TABLE IF EXISTS `CERTIFICATE`;
DROP TABLE IF EXISTS `CAREER`;
DROP TABLE IF EXISTS `SCHED_FX`;
DROP TABLE IF EXISTS `SCHED_MST`;
DROP TABLE IF EXISTS `OFF_DAY_MST`;
DROP TABLE IF EXISTS `ACCT`;
DROP TABLE IF EXISTS `CUS_CONS`;
DROP TABLE IF EXISTS `CUS_MST`;
DROP TABLE IF EXISTS `CLS_PKG`;
DROP TABLE IF EXISTS `HOLIDAY_MST`;
DROP TABLE IF EXISTS `CENTER_OFF_MST`;
DROP TABLE IF EXISTS `CAL_REL`;
DROP TABLE IF EXISTS `CAL_MST`;


DROP FUNCTION IF EXISTS F_GET_CODE_NM;
DROP FUNCTION IF EXISTS F_GET_RANDOM_CONTACT;
DROP FUNCTION IF EXISTS F_GET_RANDOM_INT_RANGE;
DROP FUNCTION IF EXISTS F_RANDOM_N;
DROP FUNCTION IF EXISTS F_GET_USER_NM;

DROP EVENT IF EXISTS EV_UPDATE_CUS_REST;

DROP PROCEDURE IF EXISTS F_MAKE_CLS_PASS;

DROP VIEW IF EXISTS `CLS_VIEW`;
DROP VIEW IF EXISTS `CAL_HOLI_VIEW`;
DROP VIEW IF EXISTS `CAL_SCH_VIEW`;

-- ========================================================================================================================
-- TABLE 생성
-- ========================================================================================================================

-- ======================
-- 계정 테이블
-- ======================
CREATE TABLE `ACCT`
(
    `ACCT_ID`    BIGINT         NOT NULL COMMENT '계정 아이디',
    `ACCT_PW`    VARCHAR(100)   NOT NULL COMMENT '계정 비밀번호',
    `NAME`       VARCHAR(50)    NOT NULL COMMENT '이름',
    `CONTACT`    VARCHAR(13)    NOT NULL COMMENT '연락처',
    `BIRTH_DATE` VARCHAR(8)     NOT NULL COMMENT '생년월일',
    `GENDER`     ENUM ('M','W') NOT NULL COMMENT '성별',
    `ACTIVE_YN`  ENUM ('Y','N') NOT NULL COMMENT '재직여부' DEFAULT 'Y',
    `REG_DTM`    VARCHAR(14)    NOT NULL COMMENT '등록일시',
    `REG_ID`     VARCHAR(20)    NOT NULL COMMENT '등록계정 아이디',
    `MOD_DTM`    VARCHAR(14)                            DEFAULT NULL COMMENT '수정일시',
    `MOD_ID`     VARCHAR(20)                            DEFAULT NULL COMMENT '수정계정 아이디',
    PRIMARY KEY (`ACCT_ID`)
)
    COMMENT = '계정 테이블';

-- ======================
-- 고객 마스터
-- ======================
CREATE TABLE `CUS_MST`
(
    `MST_ID`     BIGINT         NOT NULL COMMENT '마스터고객 아이디' AUTO_INCREMENT,
    `NAME`       VARCHAR(50)    NOT NULL COMMENT '이름',
    `CONTACT`    VARCHAR(13)    NOT NULL COMMENT '연락처',
    `GENDER`     ENUM ('M','W') NOT NULL COMMENT '성별',
    `BIRTH_DATE` VARCHAR(10)    NOT NULL COMMENT '생년월일',
    `BLACK_YN`   ENUM ('Y','N') NOT NULL DEFAULT 'N' COMMENT '블랙리스트 여부',
    `REMARK`     VARCHAR(4000)           DEFAULT NULL COMMENT '메모',
    `REG_DTM`    VARCHAR(14)    NOT NULL COMMENT '등록일시',
    `REG_ID`     VARCHAR(20)    NOT NULL COMMENT '등록계정 아이디',
    `MOD_DTM`    VARCHAR(14)             DEFAULT NULL COMMENT '수정일시',
    `MOD_ID`     VARCHAR(20)             DEFAULT NULL COMMENT '수정계정 아이디',
    PRIMARY KEY (`MST_ID`)
)
    COMMENT = '고객 마스터';


-- ======================
-- 상담 고객
-- ======================
CREATE TABLE `CUS_CONS`
(
    `CUS_ID`         VARCHAR(20) NOT NULL COMMENT '아이디',
    `MST_ID`         BIGINT        DEFAULT NULL COMMENT '마스터고객 아이디',
    `HEIGHT`         FLOAT       NOT NULL COMMENT '키',
    `WEIGHT`         FLOAT       NOT NULL COMMENT '몸무게',
    `DISEASE`        VARCHAR(4000) DEFAULT NULL COMMENT '지병',
    `SUR_HIST`       VARCHAR(4000) DEFAULT NULL COMMENT '시술/수술내역',
    `BODY_CHECK_IMG` TEXT          DEFAULT NULL COMMENT '바디체킹이미지',
    `CONS_DATE`      VARCHAR(14) NOT NULL COMMENT '상담 일자',
    `REMARK`         VARCHAR(4000) DEFAULT NULL COMMENT '메모',
    `REG_DTM`        VARCHAR(14) NOT NULL COMMENT '등록일시',
    `REG_ID`         VARCHAR(20) NOT NULL COMMENT '등록계정 아이디',
    `MOD_DTM`        VARCHAR(14)   DEFAULT NULL COMMENT '수정일시',
    `MOD_ID`         VARCHAR(20)   DEFAULT NULL COMMENT '수정계정 아이디',
    PRIMARY KEY (`CUS_ID`),
    CONSTRAINT `FK_CUS_MST_TO_CUS_CONS`
        FOREIGN KEY (`MST_ID`)
            REFERENCES `CUS_MST` (`MST_ID`)
            ON UPDATE CASCADE
            ON DELETE CASCADE
)
    COMMENT = '상담 고객';


-- ======================
-- 스케줄 마스터
-- ======================
CREATE TABLE `SCHED_MST`
(
    `SCHED_ID`     BIGINT                   NOT NULL COMMENT '스케쥴 시퀸스' AUTO_INCREMENT,
    `ACCT_ID`      BIGINT                   NOT NULL COMMENT '강사 아이디',
    `MST_ID`       BIGINT                   NOT NULL COMMENT '마스터고객 아이디',
    `TRAINER_NM`   VARCHAR(50)                       DEFAULT NULL COMMENT '깅시먕',
    `CUS_NM`       VARCHAR(50)                       DEFAULT NULL COMMENT '고객명',
    `CLS_STATUS`   ENUM ('SCH','COM','NOS') NOT NULL COMMENT '수업상태',
    `CLS_SESSION`  VARCHAR(4000)                     DEFAULT NULL COMMENT '운동 세션',
    `INJURY`       VARCHAR(4000)                     DEFAULT NULL COMMENT '부상',
    `HOMEWORK`     VARCHAR(4000)                     DEFAULT NULL COMMENT '숙제',
    `VIDEO_REC_YN` ENUM ('Y','N')           NOT NULL DEFAULT 'N' COMMENT '영상여부',
    `REST_YN`      ENUM ('Y','N')                    DEFAULT NULL DEFAULT 'N' COMMENT '휴식여부',
    `FX_YN`        ENUM ('Y','N')                    DEFAULT NULL DEFAULT 'Y' COMMENT '고정수업여부',
    `CLS_NOTE`     VARCHAR(4000)                     DEFAULT NULL COMMENT '수업일지',
    `CLS_NOTE_YN`  ENUM ('Y', 'N')          NOT NULL DEFAULT 'N' COMMENT '수업일지 완료 여부',
    `REG_DTM`      VARCHAR(14)              NOT NULL COMMENT '등록일시',
    `REG_ID`       VARCHAR(20)              NOT NULL COMMENT '등록계정 아이디',
    `MOD_DTM`      VARCHAR(14)                       DEFAULT NULL COMMENT '수정일시',
    `MOD_ID`       VARCHAR(20)                       DEFAULT NULL COMMENT '수정계정 아이디',
    PRIMARY KEY (`SCHED_ID`),
    CONSTRAINT `FK_ACCT_MST_TO_SCHED_MST`
        FOREIGN KEY (`ACCT_ID`)
            REFERENCES `ACCT` (`ACCT_ID`)
            ON UPDATE CASCADE
            ON DELETE CASCADE,
    CONSTRAINT `FK_ACCT_MST_TO_CUS_MST`
        FOREIGN KEY (`MST_ID`)
            REFERENCES `CUS_MST` (`MST_ID`)
            ON UPDATE CASCADE
            ON DELETE CASCADE
)
    COMMENT = '스케쥴 마스터';


-- ======================
-- 회차별 상품
-- ======================
CREATE TABLE `CLS_PKG`
(
    `CLS_PKG_ID`   BIGINT              NOT NULL COMMENT '회차상품 아이디' AUTO_INCREMENT,
    `CLS_PKG_NM`   VARCHAR(50)         NOT NULL COMMENT '상품이름',
    `CLS_TYPE`     ENUM ('IOI', 'TIO') NOT NULL COMMENT '상품 타입',
    `CLS_PKG_CNT`  INT                 NOT NULL COMMENT '회차',
    `PRICE`        INT                 NOT NULL COMMENT '금액',
    `DISCOUNT_AMT` INT                 NOT NULL COMMENT '할인금액',
    `INST_YN`      ENUM ('Y','N')      NOT NULL DEFAULT 'N' COMMENT '할부여부',
    `INST_MM`      INT                          DEFAULT NULL COMMENT '할부가능개월',
    `USE_YN`       ENUM ('Y','N')      NOT NULL DEFAULT 'Y' COMMENT '사용여부',
    `EXP_RATE`     INT                          DEFAULT NULL COMMENT '유효기간',
    `REMARK`       VARCHAR(4000)                DEFAULT NULL COMMENT '메모',
    `REG_DTM`      VARCHAR(14)         NOT NULL COMMENT '등록일시',
    `REG_ID`       VARCHAR(20)         NOT NULL COMMENT '등록계정 아이디',
    `MOD_DTM`      VARCHAR(14)         NOT NULL COMMENT '수정일시',
    `MOD_ID`       VARCHAR(20)                  DEFAULT NULL COMMENT '수정계정 아이디',
    PRIMARY KEY (`CLS_PKG_ID`)
)
    COMMENT = '회차별 상품';


-- ======================
-- 공휴일 마스터
-- ======================
CREATE TABLE `HOLIDAY_MST`
(
    `HOLI_ID` BIGINT      NOT NULL COMMENT '공휴일 아이디' AUTO_INCREMENT,
    `HOLI_NM` VARCHAR(20) NOT NULL COMMENT '공휴일 이름',
    `REG_DTM` VARCHAR(14) NOT NULL COMMENT '등록일시',
    `REG_ID`  VARCHAR(20) NOT NULL COMMENT '등록계정 아이디',
    `MOD_DTM` VARCHAR(14) DEFAULT NULL COMMENT '수정일시',
    `MOD_ID`  VARCHAR(20) DEFAULT NULL COMMENT '수정계정 아이디',
    PRIMARY KEY (`HOLI_ID`)
)
    COMMENT = '공휴일 마스터';

-- ======================
-- 센터 휴무일 마스터
-- ======================
CREATE TABLE `CENTER_OFF_MST`
(
    `OFF_ID`  BIGINT      NOT NULL COMMENT '휴무일 아이디' AUTO_INCREMENT,
    `OFF_NM`  VARCHAR(20) NOT NULL COMMENT '휴무일 이름',
    `REG_DTM` VARCHAR(14) NOT NULL COMMENT '등록일시',
    `REG_ID`  VARCHAR(20) NOT NULL COMMENT '등록계정 아이디',
    `MOD_DTM` VARCHAR(14) DEFAULT NULL COMMENT '수정일시',
    `MOD_ID`  VARCHAR(20) DEFAULT NULL COMMENT '수정계정 아이디',
    PRIMARY KEY (`OFF_ID`)
)
    COMMENT = '센터 휴무일 마스터';

-- ======================
-- 휴무일 관리
-- ======================
CREATE TABLE `OFF_DAY_MST`
(
    `OFF_ID`     BIGINT         NOT NULL COMMENT '휴무일 아이디' AUTO_INCREMENT,
    `ACCT_ID`    BIGINT         NOT NULL COMMENT '강사 아이디',
    `TRAINER_NM` VARCHAR(50)             DEFAULT NULL COMMENT '강사명',
    `REST_YN`    ENUM ('Y','N') NOT NULL DEFAULT 'Y' COMMENT '강의여부',
    `REG_DTM`    VARCHAR(14)    NOT NULL COMMENT '등록일시',
    `REG_ID`     VARCHAR(20)    NOT NULL COMMENT '등록계정 아이디',
    `MOD_DTM`    VARCHAR(14)             DEFAULT NULL COMMENT '수정일시',
    `MOD_ID`     VARCHAR(20)             DEFAULT NULL COMMENT '수정계정 아이디',
    PRIMARY KEY (`OFF_ID`),
    CONSTRAINT `FK_ACCT_TO_OFF_DAY_MST`
        FOREIGN KEY (`ACCT_ID`)
            REFERENCES `ACCT` (`ACCT_ID`)
            ON UPDATE CASCADE
            ON DELETE CASCADE
)
    COMMENT = '휴무일 관리';


-- ======================
-- 고정 스케줄
-- ======================
CREATE TABLE `SCHED_FX`
(
    `FX_SCHED_ID` BIGINT                             NOT NULL COMMENT '고정 스케줄 시퀀스' AUTO_INCREMENT,
    `MST_ID`      BIGINT                             NOT NULL COMMENT '마스터 고객 아이디',
    `ACCT_ID`     BIGINT                             NOT NULL COMMENT '강사 아이디',
    `FX_DAY`      ENUM ('1','2','3','4','5','6','7') NOT NULL COMMENT '요일(1:월~7:일)',
    `FX_TIME`     VARCHAR(4)                         NOT NULL COMMENT '시간',
    `REG_DTM`     VARCHAR(14)                        NOT NULL COMMENT '등록일시',
    `REG_ID`      VARCHAR(20)                        NOT NULL COMMENT '등록계정 아이디',
    `MOD_DTM`     VARCHAR(14) DEFAULT NULL COMMENT '수정일시',
    `MOD_ID`      VARCHAR(20) DEFAULT NULL COMMENT '수정계정 아이디',
    PRIMARY KEY (`FX_SCHED_ID`),
    CONSTRAINT `FK_CUS_MST_TO_SCHED_FX`
        FOREIGN KEY (`MST_ID`)
            REFERENCES `CUS_MST` (`MST_ID`)
            ON UPDATE CASCADE
            ON DELETE CASCADE,
    CONSTRAINT `FK_ACCT_TO_SCHED_FX`
        FOREIGN KEY (`ACCT_ID`)
            REFERENCES `ACCT` (`ACCT_ID`)
            ON UPDATE CASCADE
            ON DELETE CASCADE
)
    COMMENT = '고정 스케쥴';


-- ======================
-- 경력
-- ======================
CREATE TABLE `CAREER`
(
    `CAREER_ID`     BIGINT      NOT NULL COMMENT '경력 아이디' AUTO_INCREMENT,
    `ACCT_ID`       BIGINT      NOT NULL COMMENT '강사 아이디',
    `CAREER_NM`     VARCHAR(50) NOT NULL COMMENT '경력 이름',
    `CAREER_ORG`    VARCHAR(50)   DEFAULT NULL COMMENT '경력 기관',
    `CAREER_MEMO`   VARCHAR(1000) DEFAULT NULL COMMENT '경력 상세',
    `CAREER_STR_DT` VARCHAR(14) NOT NULL COMMENT '경력 시작일',
    `CAREER_END_DT` VARCHAR(14) NOT NULL COMMENT '경력 종료일',
    `REG_DTM`       VARCHAR(14) NOT NULL COMMENT '등록일시',
    `REG_ID`        VARCHAR(20) NOT NULL COMMENT '등록계정 아이디',
    `MOD_DTM`       VARCHAR(14)   DEFAULT NULL COMMENT '수정일시',
    `MOD_ID`        VARCHAR(20)   DEFAULT NULL COMMENT '수정계정 아이디',
    PRIMARY KEY (`CAREER_ID`),
    CONSTRAINT `FK_ACCT_TO_CAREER`
        FOREIGN KEY (`ACCT_ID`)
            REFERENCES `ACCT` (`ACCT_ID`)
            ON UPDATE CASCADE
            ON DELETE CASCADE
)
    COMMENT = '경력';


-- ======================
-- 자격증
-- ======================
CREATE TABLE `CERTIFICATE`
(
    `CERT_ID`         BIGINT      NOT NULL COMMENT '자격증 식별번호' AUTO_INCREMENT,
    `ACCT_ID`         BIGINT      NOT NULL COMMENT '계정 아이디',
    `CERT_NAME`       VARCHAR(50) NOT NULL COMMENT '자격증 이름',
    `CERT_ISSUE_DATE` VARCHAR(14) NOT NULL COMMENT '자격증 발급일자',
    `CERT_EXP_DATE`   VARCHAR(14) DEFAULT NULL COMMENT '자격증 만료일자',
    `REG_DTM`         VARCHAR(14) NOT NULL COMMENT '등록일시',
    `REG_ID`          VARCHAR(20) NOT NULL COMMENT '등록계정 아이디',
    `MOD_DTM`         VARCHAR(14) DEFAULT NULL COMMENT '수정일시',
    `MOD_ID`          VARCHAR(20) DEFAULT NULL COMMENT '수정계정 아이디',
    PRIMARY KEY (`CERT_ID`, `ACCT_ID`),
    CONSTRAINT `FK_ACCT_TO_CERTIFICATE`
        FOREIGN KEY (`ACCT_ID`)
            REFERENCES `ACCT` (`ACCT_ID`)
            ON UPDATE CASCADE
            ON DELETE CASCADE
)
    COMMENT = '자격증';


-- ======================
-- 등록 그룹
-- ======================
CREATE TABLE `CUS_GRP`
(
    `GRP_CUS_ID` BIGINT      NOT NULL COMMENT '그룹 고객 관계 아이디' AUTO_INCREMENT,
    `CUS_ID_1`   BIGINT      DEFAULT NULL COMMENT '아이디1',
    `CUS_ID_2`   BIGINT      DEFAULT NULL COMMENT '아이디2',
    `CUS_ID_3`   BIGINT      DEFAULT NULL COMMENT '아이디3',
    `CUS_ID_4`   BIGINT      DEFAULT NULL COMMENT '아이디4',
    `REG_DTM`    VARCHAR(14) NOT NULL COMMENT '등록일시',
    `REG_ID`     VARCHAR(20) NOT NULL COMMENT '등록계정 아이디',
    `MOD_DTM`    VARCHAR(14) DEFAULT NULL COMMENT '수정일시',
    `MOD_ID`     VARCHAR(20) DEFAULT NULL COMMENT '수정계정 아이디',
    PRIMARY KEY (`GRP_CUS_ID`)
)
    COMMENT = '등록 가족';

-- ======================
-- 스케줄 히스토리
-- ======================
CREATE TABLE `SCHED_HIST`
(
    `SCHED_HIST_ID` BIGINT         NOT NULL COMMENT '스케줄 히스토리 시퀸스' AUTO_INCREMENT,
    `SCHED_ID`      BIGINT         NOT NULL COMMENT '스케쥴 아이디',
    `ACCT_ID`       BIGINT         NOT NULL COMMENT '강사 아이디',
    `MST_ID`        BIGINT         NOT NULL COMMENT '마스터 고객 아이디',
    `CLS_DONE_YN`   ENUM ('Y','N') NOT NULL DEFAULT 'N' COMMENT '수업 완료 여부',
    `MOD_CNT`       VARCHAR(300)            DEFAULT NULL COMMENT '수정 내용',
    `REG_DTM`       VARCHAR(14)    NOT NULL COMMENT '등록일시',
    `REG_ID`        VARCHAR(20)    NOT NULL COMMENT '등록계정 아이디',
    `MOD_DTM`       VARCHAR(14)             DEFAULT NULL COMMENT '수정일시',
    `MOD_ID`        VARCHAR(20)             DEFAULT NULL COMMENT '수정계정 아이디',
    PRIMARY KEY (`SCHED_HIST_ID`),
    CONSTRAINT `FK_SCHED_MST_TO_SCHED_HIST`
        FOREIGN KEY (`SCHED_ID`)
            REFERENCES `SCHED_MST` (`SCHED_ID`)
            ON UPDATE CASCADE
            ON DELETE CASCADE,
    CONSTRAINT `FK_ACCT_TO_SCHED_HIST`
        FOREIGN KEY (`ACCT_ID`)
            REFERENCES `ACCT` (`ACCT_ID`)
            ON UPDATE CASCADE
            ON DELETE CASCADE,
    CONSTRAINT `FK_CUS_MST_TO_SCHED_HIST`
        FOREIGN KEY (`MST_ID`)
            REFERENCES `CUS_MST` (`MST_ID`)
            ON UPDATE CASCADE
            ON DELETE CASCADE
)
    COMMENT = '스케쥴 히스토리';

-- ======================
-- 결제 수강권
-- ======================
CREATE TABLE `CLS_PASS`
(
    `CLS_PASS_ID`  BIGINT               NOT NULL COMMENT '결제 수강권 아이디' AUTO_INCREMENT,
    `CLS_PKG_ID`   BIGINT               NOT NULL COMMENT '회차상품 아이디',
    `MST_ID`       BIGINT               NOT NULL COMMENT '마스터 고객 아이디',
    `GRP_CUS_ID`   BIGINT                        DEFAULT NULL COMMENT '그룹 고객 관계 아이디',
    `DISCOUNT_AMT` INT                           DEFAULT NULL COMMENT '할인 금액',
    `PAID_AMT`     INT                  NOT NULL COMMENT '최종 결제 금액',
    `PAY_DATE`     VARCHAR(14)          NOT NULL COMMENT '결제일자',
    `TOTAL_CNT`    INT                  NOT NULL COMMENT '총 서비스 회차',
    `INST_MM`      INT                  NOT NULL COMMENT '할부 개월 수',
    `PAY_METHOD`   ENUM ('CARD','CASH') NOT NULL COMMENT '결제 수단',
    `REMAIN_CNT`   INT                  NOT NULL COMMENT '남은 수강 회차',
    `STA_DTM`      VARCHAR(14)          NOT NULL COMMENT '수강권개시일자',
    `END_DTM`      VARCHAR(14)          NOT NULL COMMENT '수강권종료일자',
    `FIN_YN`       ENUM ('Y','N')       NOT NULL DEFAULT 'N' COMMENT '만료여부',
    `REFUND_YN`    ENUM ('Y','N')       NOT NULL DEFAULT 'N' COMMENT '환불여부',
    `REFUND_AMT`   INT                           DEFAULT NULL COMMENT '환불금액',
    `REFUND_DTM`   VARCHAR(14)                   DEFAULT NULL COMMENT '환불일자',
    `REMARK`       VARCHAR(4000)                 DEFAULT NULL COMMENT '메모',
    `REG_DTM`      VARCHAR(14)          NOT NULL COMMENT '등록일시',
    `REG_ID`       VARCHAR(20)          NOT NULL COMMENT '등록계정아이디',
    `MOD_DTM`      VARCHAR(14)                   DEFAULT NULL COMMENT '수정일시',
    `MOD_ID`       VARCHAR(20)                   DEFAULT NULL COMMENT '수정계정아이디',
    PRIMARY KEY (`CLS_PASS_ID`),
    CONSTRAINT `FK_CLS_PKG_TO_CLS_PASS`
        FOREIGN KEY (`CLS_PKG_ID`)
            REFERENCES `CLS_PKG` (`CLS_PKG_ID`)
            ON UPDATE CASCADE
            ON DELETE CASCADE,
    CONSTRAINT `FK_CUS_MST_TO_CLS_PASS`
        FOREIGN KEY (`MST_ID`)
            REFERENCES `CUS_MST` (`MST_ID`)
            ON UPDATE CASCADE
            ON DELETE CASCADE,
    CONSTRAINT `FK_CUS_GRP_TO_CLS_PASS`
        FOREIGN KEY (`GRP_CUS_ID`)
            REFERENCES `CUS_GRP` (`GRP_CUS_ID`)
            ON UPDATE CASCADE
            ON DELETE CASCADE
)
    COMMENT = '결제 수강권';

-- ======================
-- 탈퇴 고객
-- ======================
CREATE TABLE `CUS_WDR`
(
    `CUST_ID`        VARCHAR(20)    NOT NULL COMMENT '아이디',
    `MST_ID`         BIGINT         NOT NULL COMMENT '마스터 고객 아이디',
    `ACCT_ID`        BIGINT         NOT NULL COMMENT '담당 강사 아이디',
    `GRP_CUS_ID`     BIGINT                  DEFAULT NULL COMMENT '그룹 고객 관계 아이디',
    `CLS_PASS_ID`    BIGINT         NOT NULL COMMENT '결제 수강권 아이디',
    `HEIGHT`         FLOAT          NOT NULL COMMENT '키',
    `WEIGHT`         FLOAT          NOT NULL COMMENT '몸무게',
    `DISEASE`        VARCHAR(4000)           DEFAULT NULL COMMENT '지병',
    `SUR_HIST`       VARCHAR(4000)           DEFAULT NULL COMMENT '시술/수술내역',
    `BODY_CHECK_IMG` TEXT                    DEFAULT NULL COMMENT '바디체킹이미지',
    `LAST_CLS_DATE`  VARCHAR(14)    NOT NULL COMMENT '마지막 수업 일자',
    `FAM_CUS_YN`     ENUM ('Y','N') NOT NULL DEFAULT 'N' COMMENT '가족 고객 여부',
    `DEL_DTM`        VARCHAR(14)             DEFAULT NULL COMMENT '탈퇴 일자',
    `REMARK`         VARCHAR(4000)           DEFAULT NULL COMMENT '메모',
    `REG_DTM`        VARCHAR(14)    NOT NULL COMMENT '등록일시',
    `REG_ID`         VARCHAR(20)    NOT NULL COMMENT '등록계정 아이디',
    `MOD_DTM`        VARCHAR(14)             DEFAULT NULL COMMENT '수정일시',
    `MOD_ID`         VARCHAR(20)             DEFAULT NULL COMMENT '수정계정 아이디',
    PRIMARY KEY (`CUST_ID`),
    CONSTRAINT `FK_CUS_MST_TO_CUS_WDR`
        FOREIGN KEY (`MST_ID`)
            REFERENCES `CUS_MST` (`MST_ID`)
            ON UPDATE CASCADE
            ON DELETE CASCADE,
    CONSTRAINT `FK_ACCT_TO_CUS_WDR`
        FOREIGN KEY (`ACCT_ID`)
            REFERENCES `ACCT` (`ACCT_ID`)
            ON UPDATE CASCADE
            ON DELETE CASCADE,
    CONSTRAINT `FK_CUS_GRP_TO_CUS_WDR`
        FOREIGN KEY (`GRP_CUS_ID`)
            REFERENCES `CUS_GRP` (`GRP_CUS_ID`)
            ON UPDATE CASCADE
            ON DELETE CASCADE,
    CONSTRAINT `FK_CLS_PASS_TO_CUS_WDR`
        FOREIGN KEY (`CLS_PASS_ID`)
            REFERENCES `CLS_PASS` (`CLS_PASS_ID`)
            ON UPDATE CASCADE
            ON DELETE CASCADE
)
    COMMENT = '탈퇴 고객';

-- ======================
-- 권한
-- ======================
CREATE TABLE `ROLES`
(
    `ROLE_ID`   BIGINT                                          NOT NULL COMMENT '권한 식별 번호' AUTO_INCREMENT,
    `ROLE_NM`   ENUM ('ADMIN','USER','TRAINER', 'TIME_TRAINER') NOT NULL COMMENT '권한',
    `ROLE_DESC` VARCHAR(50) DEFAULT NULL COMMENT '권한 설명',
    `REG_DTM`   VARCHAR(14)                                     NOT NULL COMMENT '등록일시',
    `REG_ID`    VARCHAR(20)                                     NOT NULL COMMENT '등록계정 아이디',
    `MOD_DTM`   VARCHAR(14) DEFAULT NULL COMMENT '수정일시',
    `MOD_ID`    VARCHAR(20) DEFAULT NULL COMMENT '수정계정 아이디',
    PRIMARY KEY (`ROLE_ID`)
)
    COMMENT = '권한';


-- ======================
-- 등록 고객
-- ======================
CREATE TABLE `CUS_REG`
(
    `CUST_ID`        VARCHAR(20)    NOT NULL COMMENT '고객 아이디',
    `MST_ID`         BIGINT         NOT NULL COMMENT '마스터 고객 아이디',
    `ACCT_ID`        BIGINT         NOT NULL COMMENT '담당 강사 아이디',
    `GRP_CUS_ID`     BIGINT                  DEFAULT NULL COMMENT '그룹 고객 아이디',
    `CLS_PKG_ID`     BIGINT         NOT NULL COMMENT '결제 수강권 아이디',
    `HEIGHT`         FLOAT          NOT NULL COMMENT '키',
    `WEIGHT`         FLOAT          NOT NULL COMMENT '몸무게',
    `DISEASE`        VARCHAR(4000)           DEFAULT NULL COMMENT '지병',
    `SUR_HIST`       VARCHAR(4000)           DEFAULT NULL COMMENT '시술/수술내역',
    `BODY_CHECK_IMG` TEXT                    DEFAULT NULL COMMENT '바디체킹 이미지',
    `FX_CLS_YN`      ENUM ('Y','N') NOT NULL DEFAULT 'Y' COMMENT '고정 수업 여부',
    `FX_CLS_DAY`     VARCHAR(3)              DEFAULT NULL COMMENT '고정 수업 요일',
    `FX_CLS_TM`      VARCHAR(4)              DEFAULT NULL COMMENT '고정 수업 시간',
    `LAST_CLS_DATE`  VARCHAR(14)             DEFAULT NULL COMMENT '마지막 수업 일자',
    `FAM_CUS_YN`     ENUM ('Y','N') NOT NULL DEFAULT 'N' COMMENT '가족 고객 여부',
    `REST_YN`        ENUM ('Y','N') NOT NULL DEFAULT 'N' COMMENT '휴먼 여부',
    `REST_DTM`       VARCHAR(14)             DEFAULT NULL COMMENT '휴먼 일시',
    `REMARK`         VARCHAR(4000)           DEFAULT NULL COMMENT '메모',
    `REG_DTM`        VARCHAR(14)    NOT NULL COMMENT '등록일시',
    `REG_ID`         VARCHAR(20)    NOT NULL COMMENT '등록계정 아이디',
    `MOD_DTM`        VARCHAR(14)             DEFAULT NULL COMMENT '수정일시',
    `MOD_ID`         VARCHAR(20)             DEFAULT NULL COMMENT '수정계정 아이디',
    PRIMARY KEY (`CUST_ID`),
    CONSTRAINT `FK_CUS_MST_TO_CUS_REG`
        FOREIGN KEY (`MST_ID`)
            REFERENCES `CUS_MST` (`MST_ID`)
            ON UPDATE CASCADE
            ON DELETE CASCADE,
    CONSTRAINT `FK_ACCT_TO_CUS_REG`
        FOREIGN KEY (`ACCT_ID`)
            REFERENCES `ACCT` (`ACCT_ID`)
            ON UPDATE CASCADE
            ON DELETE CASCADE,
    CONSTRAINT `FK_CUS_GRP_TO_CUS_REG`
        FOREIGN KEY (`GRP_CUS_ID`)
            REFERENCES `CUS_GRP` (`GRP_CUS_ID`)
            ON UPDATE CASCADE
            ON DELETE CASCADE,
    CONSTRAINT `FK_CLS_PKG_TO_CUS_REG`
        FOREIGN KEY (`CLS_PKG_ID`)
            REFERENCES `CLS_PKG` (`CLS_PKG_ID`)
            ON UPDATE CASCADE
            ON DELETE CASCADE
)
    COMMENT = '등록 고객';


-- ======================
-- 공통코드관리
-- ======================
CREATE TABLE `CODE_MST`
(
    `CODE_MST_ID` BIGINT         NOT NULL COMMENT '일련번호' AUTO_INCREMENT,
    `CLASS_CD`    VARCHAR(10)    NOT NULL COMMENT '분류 코드',
    `CLASS_NM`    VARCHAR(60)    NOT NULL COMMENT '분류',
    `COMMENT`     VARCHAR(300) DEFAULT NULL COMMENT '상세설명',
    `USE_YN`      ENUM ('Y','N') NOT NULL COMMENT '사용 여부',
    `REG_DTM`     VARCHAR(14)    NOT NULL COMMENT '등록일시',
    `REG_ID`      VARCHAR(20)    NOT NULL COMMENT '등록계정 아이디',
    `MOD_DTM`     VARCHAR(14)  DEFAULT NULL COMMENT '수정일시',
    `MOD_ID`      VARCHAR(20)  DEFAULT NULL COMMENT '수정계정 아이디',
    PRIMARY KEY (`CODE_MST_ID`)
)
    COMMENT = '공통코드관리';



-- ======================
-- 공통코드 세부관리
-- ======================
CREATE TABLE `CODE_DTL`
(
    `CODE_ID`     BIGINT         NOT NULL COMMENT '일련번호' AUTO_INCREMENT,
    `CODE_MST_ID` BIGINT         NOT NULL COMMENT '마스터 일련번호',
    `CLASS_CD`    VARCHAR(10)    NOT NULL COMMENT '분류 코드',
    `DTL_CD`      VARCHAR(10)    NOT NULL COMMENT '세부코드',
    `DTL_NM`      VARCHAR(60)    NOT NULL COMMENT '세부코드 이름',
    `CLS_COMMENT` VARCHAR(300) DEFAULT NULL COMMENT '상세 설명',
    `USE_YN`      ENUM ('Y','N') NOT NULL COMMENT '사용 여부',
    `REG_DTM`     VARCHAR(14)    NOT NULL COMMENT '등록일시',
    `REG_ID`      VARCHAR(20)    NOT NULL COMMENT '등록계정 아이디',
    `MOD_DTM`     VARCHAR(14)  DEFAULT NULL COMMENT '수정일시',
    `MOD_ID`      VARCHAR(20)  DEFAULT NULL COMMENT '수정계정 아이디',
    PRIMARY KEY (`CODE_ID`, `CODE_MST_ID`),
    CONSTRAINT `FK_CODE_MST_TO_CODE_DTL`
        FOREIGN KEY (`CODE_MST_ID`)
            REFERENCES `CODE_MST` (`CODE_MST_ID`)
            ON UPDATE CASCADE
            ON DELETE CASCADE
)
    COMMENT = '공통코드 세부관리';


-- ======================
-- 결제 정보
-- ======================
CREATE TABLE `CLS_PAY_INFO`
(
    `PAY_ID`     BIGINT                   NOT NULL COMMENT '결제 정보 아이디' AUTO_INCREMENT,
    `CLS_PKG_ID` BIGINT                   NOT NULL COMMENT '회차 상품 아이디',
    `PAID_FLAG`  ENUM ('PAY','DIS','REF') NOT NULL COMMENT '결제 구분',
    `PAID_AMT`   INT                      NOT NULL COMMENT '금액',
    `PAY_METHOD` ENUM ('CARD','CASH')     NOT NULL COMMENT '결제 수단',
    `REG_DTM`    VARCHAR(14)              NOT NULL COMMENT '등록일시',
    `REG_ID`     VARCHAR(20)              NOT NULL COMMENT '등록계정 아이디',
    `MOD_DTM`    VARCHAR(14) DEFAULT NULL COMMENT '수정일시',
    `MOD_ID`     VARCHAR(20) DEFAULT NULL COMMENT '수정계정 아이디',
    PRIMARY KEY (`PAY_ID`),
    CONSTRAINT `FK_CLS_PASS_TO_CLS_PAY_INFO`
        FOREIGN KEY (`CLS_PKG_ID`)
            REFERENCES `CLS_PASS` (`CLS_PKG_ID`)
            ON UPDATE CASCADE
            ON DELETE CASCADE
)
    COMMENT = '결제 정보';

-- ======================
-- 계정-역할 매핑
-- ======================
CREATE TABLE `ACCT_ROLE`
(
    `ACCT_ID` BIGINT      NOT NULL COMMENT '계정 아이디',
    `ROLE_ID` BIGINT      NOT NULL COMMENT '권한식별번호' AUTO_INCREMENT,
    `REG_DTM` VARCHAR(14) NOT NULL COMMENT '등록일시',
    `REG_ID`  VARCHAR(20) NOT NULL COMMENT '등록계정 아이디',
    `MOD_DTM` VARCHAR(14) DEFAULT NULL COMMENT '수정일시',
    `MOD_ID`  VARCHAR(20) DEFAULT NULL COMMENT '수정계정 아이디',
    PRIMARY KEY (`ACCT_ID`, `ROLE_ID`),
    CONSTRAINT `FK_ACCT_TO_ACCT_ROLE`
        FOREIGN KEY (`ACCT_ID`)
            REFERENCES `ACCT` (`ACCT_ID`)
            ON UPDATE CASCADE
            ON DELETE CASCADE,
    CONSTRAINT `FK_ROLES_TO_ACCT_ROLE`
        FOREIGN KEY (`ROLE_ID`)
            REFERENCES `ROLES` (`ROLE_ID`)
            ON UPDATE CASCADE
            ON DELETE CASCADE
)
    COMMENT = '계정-역할 매핑';

-- ======================
-- 캘린더 마스터
-- ======================
CREATE TABLE `CAL_MST`
(
    `CAL_ID`     BIGINT      NOT NULL COMMENT '캘린더 아이디' AUTO_INCREMENT,
    `YEAR`       VARCHAR(4)  NOT NULL COMMENT '년도',
    `MONTH`      VARCHAR(2)  NOT NULL COMMENT '월',
    `DAY`        VARCHAR(2)  NOT NULL COMMENT '일',
    `KOR_DATE`   VARCHAR(3)  NOT NULL COMMENT '요일',
    `SCHED_DATE` VARCHAR(8)  NOT NULL COMMENT '년월일',
    `SCHED_TIME` VARCHAR(4)  NOT NULL COMMENT '시분',
    `REG_DTM`    VARCHAR(14) NOT NULL COMMENT '등록일시',
    `REG_ID`     VARCHAR(20) NOT NULL COMMENT '등록계정 아이디',
    `MOD_DTM`    VARCHAR(14) DEFAULT NULL COMMENT '수정일시',
    `MOD_ID`     VARCHAR(20) DEFAULT NULL COMMENT '수정계정 아이디',
    PRIMARY KEY (`CAL_ID`, `SCHED_DATE`)
)
    PARTITION BY RANGE COLUMNS (`SCHED_DATE`) (
        PARTITION P_UNDER_2000 VALUES LESS THAN ('20001231'),
        PARTITION P_UNDER_2025 VALUES LESS THAN ('20251231'),
        PARTITION P_UNDER_2050 VALUES LESS THAN ('20501231'),
        PARTITION P_UNDER_2075 VALUES LESS THAN ('20751231'),
        PARTITION P_UNDER_2100 VALUES LESS THAN ('21001231'),
        PARTITION P_UNDER_2250 VALUES LESS THAN ('22501231'),
        PARTITION P_UNDER_2500 VALUES LESS THAN ('25001231'),
        PARTITION P_UNDER_2750 VALUES LESS THAN ('27501231'),
        PARTITION P_UNDER_MAXVALUE VALUES LESS THAN (MAXVALUE)
        );


-- ======================
-- 캘린더 관계
-- ======================
CREATE TABLE `CAL_REL`
(
    `CAL_ID`   BIGINT                                                                   NOT NULL COMMENT '캘린더 아이디',
    `CAL_TYPE` ENUM ('SCH_MST', 'SCH_HIST', 'SCH_FIX', 'OFF_DAY', 'HOL_DAY', 'CEN_OFF') NOT NULL COMMENT '캘린더 타입',
    `TAR_ID`   BIGINT                                                                   NOT NULL COMMENT '대상 아이디',
    PRIMARY KEY (`CAL_ID`, `CAL_TYPE`, `TAR_ID`)
)
    COMMENT = '캘린더 관계';

-- ========================================================================================================================
-- FUNCTION, EVENT, PROCEDURE 생성
-- ========================================================================================================================
DELIMITER $$

CREATE
    DEFINER = `ivory_admin` FUNCTION `IVORY`.`F_GET_RANDOM_CONTACT`() RETURNS varchar(31) CHARSET utf8mb4
    DETERMINISTIC
BEGIN

    DECLARE V_RET VARCHAR(13);
    DECLARE V_FIRST VARCHAR(3) DEFAULT '010';
    DECLARE V_MID VARCHAR(10) DEFAULT '0123456789';

    -- F_RANDN() 함수를 이용하여 숫자 중하나의 값을 선택.
    SET V_RET = CONCAT(V_FIRST, '-', F_RANDOM_N(V_MID, 4), '-', F_RANDOM_N(V_MID, 4));

-- 결과를 반환.
    RETURN V_RET;
END$$


CREATE
    DEFINER = `ivory_admin` FUNCTION `IVORY`.`F_GET_CODE_NM`(I_CODE_MST_ID VARCHAR(20)
, I_CODE_ID VARCHAR(20)
) RETURNS varchar(31) CHARSET utf8mb4
    READS SQL DATA
BEGIN

    DECLARE V_RET VARCHAR(33);

    SELECT IFNULL(DTL_NM, '')
    INTO V_RET
    FROM CODE_DTL
    WHERE CODE_MST_ID = I_CODE_MST_ID
      AND CODE_ID = I_CODE_ID;

    -- 결과를 반환.
    RETURN V_RET;
END$$

CREATE
    DEFINER = `ivory_admin` FUNCTION `IVORY`.`F_GET_RANDOM_INT_RANGE`(I_STA_NUM INT
, I_END_NUM INT
) RETURNS int
    DETERMINISTIC
BEGIN

    RETURN FLOOR(I_STA_NUM + (RAND() * (I_END_NUM - I_STA_NUM + 1)));

END$$

CREATE
    DEFINER = `ivory_admin` FUNCTION `IVORY`.`F_GET_USER_NM`(I_USER_ID VARCHAR(20)
, FLAG VARCHAR(1)
) RETURNS VARCHAR(20) CHARSET utf8mb4
    READS SQL DATA
BEGIN
    DECLARE V_RET VARCHAR(20);
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET V_RET = NULL;
    IF FLAG = 'M' THEN
        SELECT NAME
        INTO V_RET
        FROM CUS_MST
        WHERE I_USER_ID REGEXP '^[0-9]+$'
          AND MST_ID = CAST(I_USER_ID AS UNSIGNED)
        LIMIT 1;

    ELSEIF FLAG = 'C' THEN
        SELECT NAME
        INTO V_RET
        FROM CUS_MST
        WHERE MST_ID = (SELECT MST_ID
                        FROM CUS_CONS
                        WHERE CUS_ID = I_USER_ID
                        LIMIT 1);
    ELSEIF FLAG = 'W' THEN
        SELECT NAME
        INTO V_RET
        FROM CUS_MST
        WHERE MST_ID = (SELECT MST_ID
                        FROM CUS_WDR
                        WHERE CUST_ID = I_USER_ID
                        LIMIT 1);
    ELSEIF FLAG = 'R' THEN
        SELECT NAME
        INTO V_RET
        FROM CUS_MST
        WHERE MST_ID = (SELECT MST_ID
                        FROM CUS_REG
                        WHERE CUST_ID = I_USER_ID
                        LIMIT 1);

    ELSE
        SET V_RET = NULL;

    END IF;

    RETURN V_RET;

END$$

CREATE
    DEFINER = `ivory_admin` FUNCTION `IVORY`.`F_RANDOM_N`(I_STR VARCHAR(255), I_N INT) RETURNS varchar(255) CHARSET utf8mb4
BEGIN
    DECLARE V_RET VARCHAR(255) DEFAULT '';
    DECLARE V_LEN TINYINT;
    DECLARE I INT DEFAULT 0;

    -- 1. 파라미터로 받은 값(I_STR)의 길이를 반환하는 변수(V_LEN)를 선언.
    SET V_LEN = CHAR_LENGTH(I_STR);

    -- 2. _n 번 반복하며 랜덤한 문자를 추출.
    WHILE I < I_N
        DO
            SET V_RET = CONCAT(V_RET, SUBSTRING(I_STR, CEIL(RAND() * V_LEN), 1));
            SET I = I + 1;
        END WHILE;

    -- 최종결과값(V_RET)을 반환.
    RETURN V_RET;
END$$

CREATE EVENT EV_UPDATE_CUS_REST
    ON SCHEDULE EVERY 1 DAY
        STARTS '2025-07-28 09:00:00.000'
    ON COMPLETION PRESERVE
    ENABLE
    DO BEGIN

    /*
    @DESCRIPTION
       매일 자정, 남은 수강권이 0인 회원을 휴먼 계정으로 변환한다.
    @PARAM
    @RETURN
    */
    UPDATE CUS_REG T1
    SET T1.REST_YN  = 'Y'
      , T1.REST_DTM = DATE_FORMAT(NOW(), '%Y%m%d')
      , T1.MOD_DTM  = DATE_FORMAT(NOW(), '%Y%m%d')
      , T1.MOD_ID   = 'SYS'
    WHERE (T1.REST_YN != 'Y')
      AND (SELECT T2.REMAIN_CNT
           FROM CLS_PASS T2
           WHERE T2.MST_ID = T1.MST_ID) = 0;
END$$

CREATE TRIGGER T_MAKE_ACCT_ROLE
    AFTER INSERT
    ON `ACCT`
    FOR EACH ROW
BEGIN
    INSERT INTO `ACCT_ROLE`
        (`ACCT_ID`, `ROLE_ID`, `REG_DTM`, `REG_ID`)
    VALUES (NEW.`ACCT_ID`, '01', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');

END$$

CREATE
    DEFINER = `ivory_admin` PROCEDURE `IVORY`.`F_MAKE_CLS_PASS`()
BEGIN

    DECLARE i INT DEFAULT 1;
    DECLARE CLS_PKG_ID INT;
    DECLARE DISCOUNT_AMT INT;
    DECLARE V_PAID_AMT INT;
    DECLARE V_YMD VARCHAR(20);
    DECLARE REMAIN_CNT INT;
    DECLARE MST_ID INT;

    WHILE (i <= 1000)
        DO

            -- 17, 18, 19 중 하나
            SELECT FLOOR(RAND() * 3) + 17
            INTO CLS_PKG_ID;

            -- 0, 1000, 2000, ...., 30000
            SELECT FLOOR(RAND() * 31) * 1000
            INTO DISCOUNT_AMT;

            -- 최종 가격 (원 가격 - 할인 가격)
            SET V_PAID_AMT =
                    (CASE CLS_PKG_ID
                         WHEN 17 THEN 700000
                         WHEN 18 THEN 1260000
                         WHEN 19 THEN 1575000
                        END) - DISCOUNT_AMT;

            -- 두 달 범위에서 날짜 뽑기 (20251001~20251030, 20251101~20251130)
            SELECT DATE_FORMAT(
                           CASE
                               WHEN r < 30
                                   THEN DATE_ADD('2025-10-01', INTERVAL r DAY)
                               ELSE DATE_ADD('2025-11-01', INTERVAL r - 30 DAY)
                               END
                       , '%Y%m%d')
            INTO V_YMD
            FROM (SELECT FLOOR(RAND() * 60) AS r) t;

            -- 0 ~ 10
            SELECT FLOOR(RAND() * 11)
            INTO REMAIN_CNT;

            SELECT FLOOR(RAND() * 100) + 1
            INTO MST_ID;

            INSERT INTO CLS_PASS
            (CLS_PKG_ID, MST_ID, GRP_CUS_ID, DISCOUNT_AMT, PAID_AMT, PAY_DATE, TOTAL_CNT, INST_MM, PAY_METHOD,
             REMAIN_CNT, STA_DTM, END_DTM, FIN_YN, REFUND_YN, REFUND_AMT, REFUND_DTM, REMARK, REG_DTM, REG_ID, MOD_DTM,
             MOD_ID)
            VALUES (CLS_PKG_ID, MST_ID, NULL, DISCOUNT_AMT, V_PAID_AMT, V_YMD,
                    (CASE CLS_PKG_ID WHEN 17 THEN 10 WHEN 18 THEN 20 WHEN 19 THEN 30 END), 0, 'CASH',
                    REMAIN_CNT, V_YMD, V_YMD, (IF(REMAIN_CNT > 0, 'Y', 'N')), 'N', 0, NULL, '자동생성 수강권 001', V_YMD,
                    'admin', V_YMD, 'admin');
        END WHILE;

END$$

DELIMITER ;


-- ======================
-- 상품-수강권-결제 정보 뷰
-- ======================
CREATE VIEW CLS_VIEW AS
SELECT T1.CLS_PKG_ID
     , T2.CLS_PASS_ID
     , T2.MST_ID                     AS USER_ID
     , F_GET_USER_NM(T2.MST_ID, 'M') AS USER_NM
     , (SELECT ACCT_ID
        FROM CUS_REG
        WHERE MST_ID = T2.MST_ID)    AS ACCT_ID
     , T1.CLS_PKG_NM
     , T1.CLS_TYPE
     , T1.PRICE
     , T2.PAID_AMT
     , T1.DISCOUNT_AMT
     , T2.DISCOUNT_AMT               AS DISCOUNT_AMT2
     , T2.TOTAL_CNT
     , T2.REMAIN_CNT
     , T1.EXP_RATE
     , T2.PAY_METHOD
     , T2.PAY_DATE
     , T2.REFUND_YN
     , T2.REFUND_DTM
     , T1.USE_YN
FROM CLS_PKG T1
         JOIN CLS_PASS T2
              ON T1.CLS_PKG_ID = T2.CLS_PKG_ID
;

-- ======================
-- 공휴일 확인용 뷰
-- ======================
CREATE VIEW CAL_HOLI_VIEW AS
SELECT T1.CAL_ID
     , T1.YEAR
     , T1.MONTH
     , T1.DAY
     , T1.KOR_DATE
     , T1.SCHED_DATE
     , T1.SCHED_TIME
     , T1.REG_DTM
     , T1.REG_ID
     , T1.MOD_DTM
     , T1.MOD_ID
     , T2.CAL_TYPE
     , T3.HOLI_NM
FROM CAL_MST T1
         JOIN CAL_REL T2
              ON T1.CAL_ID = T2.CAL_ID
         JOIN HOLIDAY_MST T3
              ON T3.HOLI_ID = T2.TAR_ID
ORDER BY SCHED_DATE, SCHED_TIME
;

-- ======================
-- 스케쥴 확인용 뷰
-- ======================
CREATE VIEW CAL_SCH_VIEW AS
SELECT T4.SCHED_ID
     , T4.ACCT_ID
     , T4.MST_ID
     , T4.TRAINER_NM
     , T4.CUS_NM
     , IF(R.ACCT_OFF = 1, 'Y', 'N')                                                               AS ACCT_OFF_YN
     , IF(R.HOL = 1, 'Y', 'N')                                                                    AS HOL_YN
     , IF(R.HOL = 1, (SELECT HOLI_NM FROM HOLIDAY_MST WHERE HOLI_ID = T2.TAR_ID), '')             AS HOL_NM
     , IF(R.CEN_OFF = 1, 'Y', 'N')                                                                AS CENTER_OFF_YN
     , IF(R.ACCT_OFF = 1, (SELECT CONCAT(NAME, ", ") FROM ACCT WHERE ACCT_ID = T4.ACCT_ID), NULL) AS OFF_ACCT_NM
     , P.GRP_YN
     , IF(P.GRP_YN = 'Y', P.GRP_IDS, NULL)                                                        AS GRP_IDS
     , IF(P.GRP_YN = 'Y', P.GRP_NMS, NULL)                                                        AS GRP_NMS
     , T4.CLS_STATUS
     , T4.CLS_SESSION
     , T4.INJURY
     , T4.HOMEWORK
     , T4.VIDEO_REC_YN
     , T4.REST_YN
     , T4.FX_YN
     , T4.CLS_NOTE
     , T4.CLS_NOTE_YN
     , T4.REG_DTM
     , T4.REG_ID
     , T4.MOD_DTM
     , T4.MOD_ID
     , T2.CAL_ID
     , T2.CAL_TYPE
     , T1.YEAR
     , T1.MONTH
     , T1.DAY
     , T1.KOR_DATE
     , T1.SCHED_DATE
     , T1.SCHED_TIME
FROM CAL_MST T1
         LEFT JOIN CAL_REL T2
                   ON T2.CAL_ID = T1.CAL_ID
         LEFT JOIN SCHED_MST T4
                   ON T2.TAR_ID = T4.SCHED_ID
         LEFT JOIN (SELECT CAL_ID
                         , MAX(CAL_TYPE = 'OFF_DAY') AS ACCT_OFF
                         , MAX(CAL_TYPE = 'HOL_DAY') AS HOL
                         , MAX(CAL_TYPE = 'CEN_OFF') AS CEN_OFF
                    FROM CAL_REL
                    GROUP BY CAL_ID) R
                   ON R.CAL_ID = T1.CAL_ID
         LEFT JOIN (SELECT P2.MST_ID
                         , P2.STA_DTM
                         , P2.END_DTM
                         , IF(P1.CLS_TYPE = 'IOI', 'N', 'Y')                                                 GRP_YN
                         , P2.GRP_CUS_ID
                         , CONCAT(F_GET_USER_NM(P3.CUS_ID_1, 'C'), ", ", F_GET_USER_NM(P3.CUS_ID_2, 'C')) AS GRP_NMS
                         , CONCAT(P3.CUS_ID_1, ", ", P3.CUS_ID_2)                                         AS GRP_IDS
                    FROM CLS_PKG P1
                             JOIN CLS_PASS P2
                                  ON P1.CLS_PKG_ID = P2.CLS_PKG_ID
                             JOIN CUS_GRP P3
                                  ON P3.GRP_CUS_ID = P2.GRP_CUS_ID
                    ORDER BY P2.STA_DTM) P
                   ON P.MST_ID = T4.MST_ID
                       AND T1.SCHED_DATE BETWEEN P.STA_DTM AND P.END_DTM
ORDER BY SCHED_DATE, SCHED_TIME
;



INSERT INTO ROLES
VALUES ('01', 'ADMIN', '관리자', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');
INSERT INTO ROLES
VALUES ('02', 'USER', '사용자', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');
INSERT INTO ROLES
VALUES ('03', 'TRAINER', '강사', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');
INSERT INTO ROLES
VALUES ('04', 'TIME_TRAINER', '시간 강사', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');


INSERT INTO ACCT
VALUES (1, 'PWD', '관리자01', F_GET_RANDOM_CONTACT(),
        DATE_FORMAT(DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 20000) DAY), '%Y%m%d'), 'W', 'Y',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');
INSERT INTO ACCT
VALUES (2, 'PWD', '관리자02', F_GET_RANDOM_CONTACT(),
        DATE_FORMAT(DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 20000) DAY), '%Y%m%d'), 'M', 'Y',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');
INSERT INTO ACCT
VALUES (3, 'PWD', '강사01', F_GET_RANDOM_CONTACT(),
        DATE_FORMAT(DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 20000) DAY), '%Y%m%d'), 'W', 'Y',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');
INSERT INTO ACCT
VALUES (4, 'PWD', '강사02', F_GET_RANDOM_CONTACT(),
        DATE_FORMAT(DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 20000) DAY), '%Y%m%d'), 'W', 'Y',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');
INSERT INTO ACCT
VALUES (5, 'PWD', '강사03', F_GET_RANDOM_CONTACT(),
        DATE_FORMAT(DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 20000) DAY), '%Y%m%d'), 'M', 'Y',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');


INSERT INTO CODE_MST
VALUES (1, 'PAY_DIV', '결제구분', '결제방법을 구분하기 위한 코드', 'Y', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');
INSERT INTO CODE_MST
VALUES (2, 'SCH', '수업상태', '수업 진행 상태를 구분하기 위한 코드', 'Y', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');
INSERT INTO CODE_MST
VALUES (3, 'PAY_MET', '결제수단', '결제 수단을 구분하기 위한 코드', 'Y', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');
INSERT INTO CODE_MST
VALUES (4, 'USER', '사용자구분', '사용자 권한을 구분하기 위한 코드', 'Y', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');
INSERT INTO CODE_MST
VALUES (5, 'Y/N', 'Y/N구분', 'Y/N을 구분하기 위한 코드', 'Y', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS', DATE_FORMAT(NOW(), '%Y%m%d'),
        'SYS');
INSERT INTO CODE_MST
VALUES (6, 'GENDER', '성별구분', '성별을 구분하기 위한 코드', 'Y', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');
INSERT INTO CODE_MST
VALUES (7, 'CLS_TYPE', '상품타입', '상품 종류를 구분하기 위한 코드', 'Y', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');
INSERT INTO CODE_MST
VALUES (8, 'CAL_TYPE', '캘린더 타입', '캘린더의 날짜별 특징을 구분하기 위한 코드', 'Y', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');

INSERT INTO CODE_DTL
VALUES (1, 1, 'PAY_DIV', 'PAY', '결제', '정상적으로 결제가 진행 된 상태', 'Y', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');
INSERT INTO CODE_DTL
VALUES (2, 1, 'PAY_DIV', 'DIS', '할인', '할인된 금액으로 결제가 진행 된 상태', 'Y', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');
INSERT INTO CODE_DTL
VALUES (3, 1, 'PAY_DIV', 'REF', '환불', '결제된 금액이 환불 된 상태', 'Y', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');

INSERT INTO CODE_DTL
VALUES (4, 2, 'SCH', 'SCH', '예정', '수업이 아직 진행되지 않고 예정된 상태', 'Y', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');
INSERT INTO CODE_DTL
VALUES (5, 2, 'SCH', 'COM', '완료', '수업이 정상적으로 완료 된 상태', 'Y', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');
INSERT INTO CODE_DTL
VALUES (6, 2, 'SCH', 'NOS', '노쇼', '수업 일자가 지났으나 수업이 진행되지 않은 상태', 'Y', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');

INSERT INTO CODE_DTL
VALUES (7, 3, 'PAY_MET', 'CARD', '카드', '카드로 결제가 진행 된 상태', 'Y', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');
INSERT INTO CODE_DTL
VALUES (8, 3, 'PAY_MET', 'CASH', '계좌이체', '현금으로 결제가 진행 된 상태', 'Y', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');

INSERT INTO CODE_DTL
VALUES (9, 4, 'USER', 'ADMIN', '관리자', '관리자 권한을 가지고 있는 상태', 'Y', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');
INSERT INTO CODE_DTL
VALUES (10, 4, 'USER', 'USER', '사용자', '사용자 권한을 가지고 있는 상태', 'Y', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');
INSERT INTO CODE_DTL
VALUES (11, 4, 'USER', 'TRAINER', '강사', '강사 권한을 가지고 있는 상태', 'Y', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');

INSERT INTO CODE_DTL
VALUES (12, 5, 'Y/N', 'Y', 'Y', 'YN 중 Y', 'Y', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS', DATE_FORMAT(NOW(), '%Y%m%d'),
        'SYS');
INSERT INTO CODE_DTL
VALUES (13, 5, 'Y/N', 'N', 'N', 'YN 중 N', 'Y', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS', DATE_FORMAT(NOW(), '%Y%m%d'),
        'SYS');

INSERT INTO CODE_DTL
VALUES ('14', '06', 'GENDER', 'M', '남자', '성별 중 남성', 'Y', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');
INSERT INTO CODE_DTL
VALUES ('15', '06', 'GENDER', 'W', '여자', '성별 중 여성', 'Y', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');

INSERT INTO CODE_DTL
VALUES ('16', '07', 'CLS_TYPE', 'IOI', '1:1 수업', '수강생과 강사가 1 : 1인 수업', 'Y', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');
INSERT INTO CODE_DTL
VALUES ('17', '07', 'CLS_TYPE', 'TIO', '2:1 수업', '수강생과 강사가 2 : 1인 수업', 'Y', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');

INSERT INTO CODE_DTL
VALUES ('18', '08', 'CAL_TYPE', 'SCH_MST', '스케쥴 마스터', 'SCHED_MST 테이블에 기록된 일정', 'Y', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');
INSERT INTO CODE_DTL
VALUES ('19', '08', 'CAL_TYPE', 'SCH_HIST', '스케쥴 히스토리', 'SCHED_HIST 테이블에 기록된 일정', 'Y', DATE_FORMAT(NOW(), '%Y%m%d'),
        'SYS',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');
INSERT INTO CODE_DTL
VALUES ('20', '08', 'CAL_TYPE', 'SCH_FIX', '고정 스케쥴', 'SCHED_FX 테이블에 기록된 일정', 'Y', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');
INSERT INTO CODE_DTL
VALUES ('21', '08', 'CAL_TYPE', 'OFF_DAY', '강사 휴무일', '해당 일자에 강사가 휴가인 경우', 'Y', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');
INSERT INTO CODE_DTL
VALUES ('22', '08', 'CAL_TYPE', 'HOL_DAY', '공휴일', '해당 일자가 법정 공휴일인 경우', 'Y', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');
INSERT INTO CODE_DTL
VALUES ('23', '08', 'CAL_TYPE', 'CEN_OFF', '센터 휴무일', '해당 일자가 센터 휴무일인 경우', 'Y', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');

COMMIT



