use ivory;

INSERT INTO SCHED_MST
(ACCT_ID, MST_ID, TRAINER_NM, CUS_NM, CLS_STATUS, CLS_SESSION, INJURY, HOMEWORK, VIDEO_REC_YN, REST_YN, FX_YN,
 CLS_NOTE, CLS_NOTE_YN, REG_DTM, REG_ID, MOD_DTM, MOD_ID)
    (SELECT T1.ACCT_ID
          , T1.MST_ID
          , T2.NAME
          , F_GET_USER_NM(T1.MST_ID, 'M') AS CUS_NM
          , (CASE
                 WHEN (SELECT FLOOR(RAND() * 10) <= 5) THEN 'COM'
                 WHEN (SELECT FLOOR(RAND() * 10) <= 5) THEN 'SCH'
                 ELSE 'NOS' END
            )                                CLS_STATUS
          , '수업 세션'
          , NULL
          , NULL
          , 'N'
          , (CASE WHEN (SELECT FLOOR(RAND() * 10) <= 8) THEN 'Y' ELSE 'N' END)
          , (CASE WHEN (SELECT FLOOR(RAND() * 10) <= 8) THEN 'N' ELSE 'Y' END)
          , NULL
          , 'N'
          , '20251006'
          , 'admin'
          , '20251006'
          , 'admin'
     FROM CUS_REG T1
              JOIN ACCT T2
                   ON T1.ACCT_ID = T2.ACCT_ID)
;

INSERT INTO CAL_REL
    (CAL_ID, CAL_TYPE, TAR_ID)
    (SELECT (SELECT CAL_ID
             FROM CAL_MST
                      PARTITION (P_UNDER_2025)
             WHERE YEAR = '2025'
             ORDER BY RAND()
             LIMIT 1)
          , 'SCH_MST'
          , SCHED_ID
     FROM SCHED_MST)
;
