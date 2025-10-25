use ivory;

TRUNCATE TABLE CLS_PKG;
TRUNCATE TABLE CLS_PASS;
TRUNCATE TABLE CLS_PAY_INFO;

INSERT INTO CLS_PKG
(CLS_PKG_NM, CLS_TYPE, CLS_PKG_CNT, PRICE, DISCOUNT_AMT, INST_YN, INST_MM, USE_YN, EXP_RATE, REMARK,
 REG_DTM, REG_ID, MOD_DTM, MOD_ID)
VALUES ('2020 1대1 10회(2개월)', 'IOI', 10, 700000, 0, 'N', 0, 'Y', 60, 'TEMP 데이터',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'admin', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       ('2020 1대1 20회(4개월)', 'IOI', 20, 1260000, 0, 'N', 0, 'Y', '120', 'TEMP 데이터',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'admin', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       ('2020 1대1 30회(6개월)', 'IOI', 30, 1575000, 0, 'N', 0, 'Y', 180, 'TEMP 데이터',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'admin', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       ('2020 2대1 10회(2개월)', 'TIO', 10, 450000, 0, 'N', 0, 'Y', 60, 'TEMP 데이터',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'admin', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       ('2021 1대1 10회(2개월)', 'IOI', 10, 700000, 0, 'N', 0, 'Y', 60, 'TEMP 데이터',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'admin', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       ('2021 1대1 20회(4개월)', 'IOI', 20, 1260000, 0, 'N', 0, 'Y', '120', 'TEMP 데이터',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'admin', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       ('2021 1대1 30회(6개월)', 'IOI', 30, 1575000, 0, 'N', 0, 'Y', 180, 'TEMP 데이터',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'admin', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       ('2021 2대1 10회(2개월)', 'TIO', 10, 450000, 0, 'N', 0, 'Y', 60, 'TEMP 데이터',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'admin', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       ('2022 1대1 10회(2개월)', 'IOI', 10, 700000, 0, 'N', 0, 'Y', 60, 'TEMP 데이터',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'admin', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       ('2022 1대1 20회(4개월)', 'IOI', 20, 1260000, 0, 'N', 0, 'Y', '120', 'TEMP 데이터',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'admin', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       ('2022 1대1 30회(6개월)', 'IOI', 30, 1575000, 0, 'N', 0, 'Y', 180, 'TEMP 데이터',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'admin', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       ('2022 2대1 10회(2개월)', 'TIO', 10, 450000, 0, 'N', 0, 'Y', 60, 'TEMP 데이터',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'admin', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       ('2023 1대1 10회(2개월)', 'IOI', 10, 700000, 0, 'N', 0, 'Y', 60, 'TEMP 데이터',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'admin', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       ('2023 1대1 20회(4개월)', 'IOI', 20, 1260000, 0, 'N', 0, 'Y', '120', 'TEMP 데이터',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'admin', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       ('2023 1대1 30회(6개월)', 'IOI', 30, 1575000, 0, 'N', 0, 'Y', 180, 'TEMP 데이터',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'admin', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       ('2023 2대1 10회(2개월)', 'TIO', 10, 450000, 0, 'N', 0, 'Y', 60, 'TEMP 데이터',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'admin', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       ('2024 1대1 10회(2개월)', 'IOI', 10, 700000, 0, 'N', 0, 'Y', 60, 'MIG 데이터',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'admin', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       ('2024 1대1 20회(4개월)', 'IOI', 20, 1260000, 0, 'N', 0, 'Y', '120', 'MIG 데이터',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'admin', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       ('2024 1대1 30회(6개월)', 'IOI', 30, 1575000, 0, 'N', 0, 'Y', 180, 'MIG 데이터',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'admin', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       ('2024 2대1 10회(2개월)', 'TIO', 10, 450000, 0, 'N', 0, 'Y', 60, 'MIG 데이터',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'admin', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       ('2025 1대1 10회(2개월)', 'IOI', 10, 700000, 0, 'N', 0, 'Y', '60', 'TEMP 데이터',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'admin', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       ('2025 1대1 20회(4개월)', 'IOI', 20, 1260000, 0, 'N', 0, 'Y', '120', 'TEMP 데이터',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'admin', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       ('2025 1대1 30회(6개월)', 'IOI', 30, 1575000, 0, 'N', 0, 'Y', '180', 'TEMP 데이터',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'admin', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       ('2025 2대1 10회(2개월)', 'TIO', 10, 450000, 0, 'N', 0, 'Y', '60', 'TEMP 데이터',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'admin', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin')
;

CALL F_MAKE_CLS_PASS();

INSERT INTO CLS_PAY_INFO
(CLS_PKG_ID, PAID_FLAG, PAID_AMT, PAY_METHOD, REG_DTM, REG_ID, MOD_DTM, MOD_ID)
SELECT p.CLS_PKG_ID,
       IF(IFNULL(p.DISCOUNT_AMT, 0) > 0, 'DIS', 'PAY') AS PAID_FLAG,
       (p.PAID_AMT - IFNULL(p.DISCOUNT_AMT, 0))        AS PAID_AMT,
       p.PAY_METHOD,
       DATE_FORMAT(NOW(), '%Y%m%d')                    AS REG_DTM,
       'admin'                                         AS REG_ID,
       DATE_FORMAT(NOW(), '%Y%m%d')                    AS MOD_DTM,
       'admin'                                         AS MOD_ID
FROM CLS_PASS p
WHERE NOT EXISTS (SELECT 1
                  FROM CLS_PAY_INFO c
                  WHERE c.CLS_PKG_ID = p.CLS_PKG_ID);


