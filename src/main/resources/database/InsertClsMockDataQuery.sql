use ivory;

INSERT INTO CLS_PKG
(CLS_PKG_NM, CLS_TYPE, CLS_PKG_CNT, PRICE, DISCOUNT_AMT, INST_YN, INST_MM, USE_YN, EXP_RATE, REMARK,
 REG_DTM, REG_ID, MOD_DTM, MOD_ID)
VALUES ( '1:1 10회 2025 여름 특가', 'IOI', 10, 250000, 50000, 'Y', 5, 'Y', '20251231', '메모'
       , DATE_FORMAT(NOW(), '%Y%m%d'), 'admin', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       ( '2:1 10회 2025 여름 특가', 'TIO', 10, 350000, 30000, 'N', 0, 'Y', '20251231', '메모'
       , DATE_FORMAT(NOW(), '%Y%m%d'), 'admin', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       ( '올해는 빼고야 만다 프로젝트', 'IOI', 30, 450000, 30000, 'Y', 5, 'N', '20251231', '메모'
       , DATE_FORMAT(NOW(), '%Y%m%d'), 'admin', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       ( '몸짱이 될거야 프로젝트', 'IOI', 20, 180000, 0, 'Y', 6, 'Y', '20251231', '메모'
       , DATE_FORMAT(NOW(), '%Y%m%d'), 'admin', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       ( '1:1 10회 2024 여름 특가', 'IOI', 10, 250000, 50000, 'Y', 5, 'N', '20241231', '메모'
       , DATE_FORMAT(NOW(), '%Y%m%d'), 'admin', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       ( '2:1 10회 2024 여름 특가', 'TIO', 30, 350000, 30000, 'Y', 5, 'N', '20241231', '메모'
       , DATE_FORMAT(NOW(), '%Y%m%d'), 'admin', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       ( '1:1 10회 2023 여름 특가', 'IOI', 10, 250000, 50000, 'Y', 5, 'N', '20231231', '메모'
       , DATE_FORMAT(NOW(), '%Y%m%d'), 'admin', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       ( '2:1 10회 2023 여름 특가', 'TIO', 30, 350000, 30000, 'Y', 5, 'N', '20231231', '메모'
       , DATE_FORMAT(NOW(), '%Y%m%d'), 'admin', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       ( '1:1 10회 2022 여름 특가', 'IOI', 10, 250000, 50000, 'Y', 5, 'N', '20221231', '메모'
       , DATE_FORMAT(NOW(), '%Y%m%d'), 'admin', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       ( '2:1 10회 2022 여름 특가', 'TIO', 30, 350000, 30000, 'Y', 5, 'N', '20221231', '메모'
       , DATE_FORMAT(NOW(), '%Y%m%d'), 'admin', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin');

INSERT INTO CLS_PASS
(CLS_PKG_ID, MST_ID, GRP_CUS_ID, DISCOUNT_AMT, PAID_AMT, PAY_DATE, TOTAL_CNT, INST_MM, PAY_METHOD,
 REMAIN_CNT, STA_DTM, END_DTM, FIN_YN, REFUND_YN, REFUND_AMT, REFUND_DTM, REMARK, REG_DTM, REG_ID, MOD_DTM, MOD_ID)
VALUES (1, 3, NULL, 0, 250000, '20250922', 10, 3, 'CARD',
        5, '20250922', '20261231', 'N', 'N', 0, NULL, '메모', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       (1, 4, NULL, 0, 250000, '20250922', 10, 3, 'CARD',
        5, '20250922', '20261231', 'N', 'N', 0, NULL, '메모', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       (1, 5, NULL, 50000, 250000, '20250922', 10, 3, 'CASH',
        5, '20250922', '20261231', 'N', 'N', 0, NULL, '메모', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       (1, 6, NULL, 50000, 250000, '20250922', 10, 3, 'CASH',
        0, '20250922', '20261231', 'Y', 'N', 0, NULL, '메모', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       (1, 10, NULL, 0, 250000, '20250922', 10, 3, 'CARD',
        3, '20250922', '20261231', 'Y', 'N', 0, NULL, '메모', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       (1, 11, NULL, 50000, 250000, '20250922', 10, 3, 'CASH',
        8, '20250922', '20261231', 'N', 'N', 0, NULL, '메모', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       (1, 9, NULL, 0, 250000, '20250922', 10, 3, 'CARD',
        6, '20250922', '20261231', 'N', 'N', 0, NULL, '메모', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       (2, 1, NULL, 30000, 350000, '20250922', 10, 3, 'CARD',
        4, '20250922', '20261231', 'N', 'N', 0, NULL, '메모', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       (2, 2, NULL, 30000, 350000, '20250922', 10, 3, 'CARD',
        4, '20250922', '20261231', 'N', 'N', 0, NULL, '메모', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       (2, 7, NULL, 30000, 350000, '20250922', 10, 3, 'CARD',
        4, '20250922', '20261231', 'N', 'N', 0, NULL, '메모', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       (2, 8, NULL, 30000, 350000, '20250922', 10, 3, 'CARD',
        4, '20250922', '20261231', 'N', 'N', 0, NULL, '메모', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       (2, 20, NULL, 30000, 350000, '20250922', 10, 3, 'CARD',
        4, '20250922', '20261231', 'N', 'N', 0, NULL, '메모', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       (2, 25, NULL, 30000, 350000, '20250922', 10, 3, 'CARD',
        4, '20250922', '20261231', 'N', 'N', 0, NULL, '메모', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       (3, 23, NULL, 30000, 450000, '20250922', 30, 3, 'CARD',
        24, '20250922', '20261231', 'N', 'Y', 20000, '20251005', '메모', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       (3, 24, NULL, 30000, 450000, '20250922', 30, 3, 'CARD',
        21, '20250922', '20261231', 'N', 'N', 0, NULL, '메모', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin',
        DATE_FORMAT(NOW(), '%Y%m%d'), 'admin');

INSERT INTO CLS_PAY_INFO
(CLS_PKG_ID, PAID_FLAG, PAID_AMT, PAY_METHOD, REG_DTM, REG_ID, MOD_DTM, MOD_ID)
VALUES (1, 'PAY', 250000, 'CARD', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       (1, 'PAY', 250000, 'CARD', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       (1, 'DIS', 200000, 'CASH', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       (1, 'DIS', 200000, 'CASH', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       (1, 'PAY', 250000, 'CARD', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       (1, 'DIS', 200000, 'CASH', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       (1, 'PAY', 250000, 'CARD', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       (2, 'DIS', 320000, 'CARD', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       (2, 'DIS', 320000, 'CARD', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       (2, 'DIS', 320000, 'CARD', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       (2, 'DIS', 320000, 'CARD', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       (2, 'DIS', 320000, 'CARD', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       (2, 'DIS', 320000, 'CARD', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       (3, 'DIS', 420000, 'CARD', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin'),
       (3, 'DIS', 420000, 'CARD', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin', DATE_FORMAT(NOW(), '%Y%m%d'), 'admin');

