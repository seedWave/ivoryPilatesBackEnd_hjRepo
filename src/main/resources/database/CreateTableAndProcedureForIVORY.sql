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
DROP TABLE IF EXISTS `CUS_FAM`;
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
DROP TABLE IF EXISTS `CAL_REL`;
DROP TABLE IF EXISTS `CAL_MST`;


DROP FUNCTION IF EXISTS F_GET_CODE_NM;
DROP FUNCTION IF EXISTS F_GET_RANDOM_CONTACT;
DROP FUNCTION IF EXISTS F_GET_RANDOM_GENDER;
DROP FUNCTION IF EXISTS F_GET_RANDOM_INT_RANGE;
DROP FUNCTION IF EXISTS F_GET_RANDOM_NAME;
DROP FUNCTION IF EXISTS F_GET_RANDOM_YN;
DROP FUNCTION IF EXISTS F_RANDOM_N;

DROP EVENT IF EXISTS EV_UPDATE_CUS_REST;
DROP EVENT IF EXISTS EV_UPDATE_CUS_WDR;


-- ========================================================================================================================
-- TABLE 생성
-- ========================================================================================================================

-- ======================
-- 계정 테이블
-- ======================
CREATE TABLE `ACCT`
(
    `ACCT_ID`    VARCHAR(20)    NOT NULL COMMENT '계정 아이디',
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
    `MST_ID`     VARCHAR(20)    NOT NULL COMMENT '마스터고객 아이디',
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
    `MST_ID`         VARCHAR(20) NOT NULL COMMENT '마스터고객 아이디',
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
    `ACCT_ID`      VARCHAR(20)              NOT NULL COMMENT '강사 아이디',
    `MST_ID`       VARCHAR(20)              NOT NULL COMMENT '마스터고객 아이디',
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
    `EXP_RATE`     VARCHAR(14)                  DEFAULT NULL COMMENT '유효기간',
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
-- 휴무일 관리
-- ======================
CREATE TABLE `OFF_DAY_MST`
(
    `OFF_ID`     BIGINT         NOT NULL COMMENT '휴무일 아이디' AUTO_INCREMENT,
    `ACCT_ID`    VARCHAR(20)    NOT NULL COMMENT '강사 아이디',
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
    `MST_ID`      VARCHAR(20)                        NOT NULL COMMENT '마스터 고객 아이디',
    `ACCT_ID`     VARCHAR(20)                        NOT NULL COMMENT '강사 아이디',
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
    `ACCT_ID`       VARCHAR(20) NOT NULL COMMENT '강사 아이디',
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
    `ACCT_ID`         VARCHAR(20) NOT NULL COMMENT '계정 아이디',
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
    `CUS_ID_1`   VARCHAR(20) DEFAULT NULL COMMENT '아이디1',
    `CUS_ID_2`   VARCHAR(20) DEFAULT NULL COMMENT '아이디2',
    `CUS_ID_3`   VARCHAR(20) DEFAULT NULL COMMENT '아이디3',
    `CUS_ID_4`   VARCHAR(20) DEFAULT NULL COMMENT '아이디4',
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
    `ACCT_ID`       VARCHAR(20)    NOT NULL COMMENT '강사 아이디',
    `MST_ID`        VARCHAR(20)    NOT NULL COMMENT '마스터 고객 아이디',
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
    `MST_ID`       VARCHAR(20)          NOT NULL COMMENT '마스터 고객 아이디',
    `GRP_CUS_ID`   BIGINT               NOT NULL COMMENT '그룹 고객 관계 아이디',
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
    `MST_ID`         VARCHAR(20)    NOT NULL COMMENT '마스터 고객 아이디',
    `ACCT_ID`        VARCHAR(20)    NOT NULL COMMENT '담당 강사 아이디',
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
    `MST_ID`         VARCHAR(20)    NOT NULL COMMENT '마스터 고객 아이디',
    `ACCT_ID`        VARCHAR(20)    NOT NULL COMMENT '담당 강사 아이디',
    `GRP_CUS_ID`     BIGINT                  DEFAULT NULL COMMENT '그룹 고객 아이디',
    `CLS_PASS_ID`    BIGINT         NOT NULL COMMENT '결제 수강권 아이디',
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
    CONSTRAINT `FK_CLS_PASS_TO_CUS_REG`
        FOREIGN KEY (`CLS_PASS_ID`)
            REFERENCES `CLS_PASS` (`CLS_PASS_ID`)
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
    `ACCT_ID` VARCHAR(20) NOT NULL COMMENT '계정 아이디',
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
    PRIMARY KEY (`CAL_ID`)
)
    COMMENT = '캘린더 마스터';

-- ======================
-- 캘린더 관계
-- ======================
CREATE TABLE `CAL_REL`
(
    `CAL_ID`   BIGINT                                                        NOT NULL COMMENT '캘린더 아이디',
    `CAL_TYPE` ENUM ('SCH_MST', 'SCH_HIST', 'SCH_FIX', 'OFF_DAY', 'HOL_DAY') NOT NULL COMMENT '캘린더 타입',
    `TAR_ID`   BIGINT                                                        NOT NULL COMMENT '대상 아이디',
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
    DEFINER = `ivory_admin` FUNCTION `IVORY`.`F_GET_RANDOM_GENDER`() RETURNS varchar(31) CHARSET utf8mb4
    DETERMINISTIC
BEGIN

    DECLARE V_RET VARCHAR(1);
    DECLARE V_GENDER VARCHAR(2) DEFAULT 'MW';

    -- F_RANDN() 함수를 이용하여 M/F 중하나의 값을 선택.
    SET V_RET = F_RANDOM_N(V_GENDER, 1);

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
    DEFINER = `ivory_admin` FUNCTION `IVORY`.`F_GET_RANDOM_NAME`() RETURNS varchar(31) CHARSET utf8mb4
    DETERMINISTIC
BEGIN

    -- 이름이 들어가는 단어들(f_firsts)변수와 성이 들어가는 단어들(V_LASTS)변수를 정의.
    DECLARE V_RET VARCHAR(31);
    DECLARE V_FIRSTS VARCHAR(255) DEFAULT '이준시우서준하준도윤은우지호이안선우서아하윤아지안아윤시아서윤아린';
    DECLARE V_LASTS VARCHAR(255) DEFAULT '김이박최정강조윤장임';

    -- F_RANDOM_N() 함수를 이용하여 이름(f_firsts), 성(V_LASTS)의 하나의 값을 선택.
    -- V_RET 결과값 변수에 하나씩 뽑은 값을 concat() 함수를 통해 조합하여 이름을 생성.
    SET V_RET = CONCAT(F_RANDOM_N(V_LASTS, 1), F_RANDOM_N(V_FIRSTS, 1), F_RANDOM_N(V_FIRSTS, 1));

-- 결과를 반환.
    RETURN V_RET;
END$$

CREATE
    DEFINER = `ivory_admin` FUNCTION `IVORY`.`F_GET_RANDOM_YN`() RETURNS varchar(31) CHARSET utf8mb4
    DETERMINISTIC
BEGIN

    DECLARE V_RET VARCHAR(1);
    DECLARE V_YN VARCHAR(2) DEFAULT 'YN';

    -- F_RANDN() 함수를 이용하여 Y/N 중하나의 값을 선택.
    SET V_RET = F_RANDOM_N(V_YN, 1);

-- 결과를 반환.
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
    WHERE (T1.REST_YN IS NULL OR T1.REST_YN != 'Y')
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

DELIMITER ;

SELECT *
FROM ACCT;

INSERT INTO ROLES
VALUES ('01', 'ADMIN', '관리자', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');
INSERT INTO ROLES
VALUES ('02', 'USER', '사용자', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');
INSERT INTO ROLES
VALUES ('03', 'TRAINER', '강사', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');
INSERT INTO ROLES
VALUES ('04', 'TIME_TRAINER', '시간 강사', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');


INSERT INTO ACCT
VALUES ('A000001', 'PWD', '관리자01', F_GET_RANDOM_CONTACT(),
        DATE_FORMAT(DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 20000) DAY), '%Y%m%d'), 'W', 'Y',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');
INSERT INTO ACCT
VALUES ('A000002', 'PWD', '관리자02', F_GET_RANDOM_CONTACT(),
        DATE_FORMAT(DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 20000) DAY), '%Y%m%d'), 'M', 'Y',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');
INSERT INTO ACCT
VALUES ('A000003', 'PWD', '강사01', F_GET_RANDOM_CONTACT(),
        DATE_FORMAT(DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 20000) DAY), '%Y%m%d'), 'W', 'Y',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');
INSERT INTO ACCT
VALUES ('A000004', 'PWD', '강사02', F_GET_RANDOM_CONTACT(),
        DATE_FORMAT(DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 20000) DAY), '%Y%m%d'), 'W', 'Y',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');
INSERT INTO ACCT
VALUES ('A000005', 'PWD', '강사03', F_GET_RANDOM_CONTACT(),
        DATE_FORMAT(DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 20000) DAY), '%Y%m%d'), 'M', 'Y',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');


INSERT INTO CODE_MST
VALUES ('01', 'PAY_DIV', '결제구분', '결제방법을 구분하기 위한 코드', 'Y', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');
INSERT INTO CODE_MST
VALUES ('02', 'SCH', '수업상태', '수업 진행 상태를 구분하기 위한 코드', 'Y', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');
INSERT INTO CODE_MST
VALUES ('03', 'PAY_MET', '결제수단', '결제 수단을 구분하기 위한 코드', 'Y', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');
INSERT INTO CODE_MST
VALUES ('04', 'USER', '사용자구분', '사용자 권한을 구분하기 위한 코드', 'Y', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');
INSERT INTO CODE_MST
VALUES ('05', 'Y/N', 'Y/N구분', 'Y/N을 구분하기 위한 코드', 'Y', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS', DATE_FORMAT(NOW(), '%Y%m%d'),
        'SYS');
INSERT INTO CODE_MST
VALUES ('06', 'GENDER', '성별구분', '성별을 구분하기 위한 코드', 'Y', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');

INSERT INTO CODE_DTL
VALUES ('01', '01', 'PAY_DIV', 'PAY', '결제', '정상적으로 결제가 진행 된 상태', 'Y', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');
INSERT INTO CODE_DTL
VALUES ('02', '01', 'PAY_DIV', 'DIS', '할인', '할인된 금액으로 결제가 진행 된 상태', 'Y', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');
INSERT INTO CODE_DTL
VALUES ('03', '01', 'PAY_DIV', 'REF', '환불', '결제된 금액이 환불 된 상태', 'Y', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');

INSERT INTO CODE_DTL
VALUES ('04', '02', 'SCH', 'SCH', '예정', '수업이 아직 진행되지 않고 예정된 상태', 'Y', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');
INSERT INTO CODE_DTL
VALUES ('05', '02', 'SCH', 'COM', '완료', '수업이 정상적으로 완료 된 상태', 'Y', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');
INSERT INTO CODE_DTL
VALUES ('06', '02', 'SCH', 'NOS', '노쇼', '수업 일자가 지났으나 수업이 진행되지 않은 상태', 'Y', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');

INSERT INTO CODE_DTL
VALUES ('07', '03', 'PAY_MET', 'CARD', '카드', '카드로 결제가 진행 된 상태', 'Y', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');
INSERT INTO CODE_DTL
VALUES ('08', '03', 'PAY_MET', 'CASH', '계좌이체', '현금으로 결제가 진행 된 상태', 'Y', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');

INSERT INTO CODE_DTL
VALUES ('09', '04', 'USER', 'ADMIN', '관리자', '관리자 권한을 가지고 있는 상태', 'Y', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');
INSERT INTO CODE_DTL
VALUES ('10', '04', 'USER', 'USER', '사용자', '사용자 권한을 가지고 있는 상태', 'Y', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');
INSERT INTO CODE_DTL
VALUES ('11', '04', 'USER', 'TRAINER', '강사', '강사 권한을 가지고 있는 상태', 'Y', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');

INSERT INTO CODE_DTL
VALUES ('12', '05', 'Y/N', 'Y', 'Y', 'YN 중 Y', 'Y', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS', DATE_FORMAT(NOW(), '%Y%m%d'),
        'SYS');
INSERT INTO CODE_DTL
VALUES ('13', '05', 'Y/N', 'N', 'N', 'YN 중 N', 'Y', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS', DATE_FORMAT(NOW(), '%Y%m%d'),
        'SYS');

INSERT INTO CODE_DTL
VALUES ('14', '06', 'GENDER', 'M', '남자', '성별 중 남성', 'Y', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');
INSERT INTO CODE_DTL
VALUES ('15', '06', 'GENDER', 'W', '여자', '성별 중 여성', 'Y', DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'SYS');


COMMIT



