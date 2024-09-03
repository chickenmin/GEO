SELECT *
	FROM EMP e ;
	

UPDATE GEO.EMP
SET EMP_PW='1111'
WHERE EMP_NO='TE123';

UPDATE GEO.EMP
SET EMP_IMG='1111'
WHERE EMP_NO='TE123';


SELECT *
	FROM ATT a ;
	
INSERT INTO GEO.ATT
(EMP_NO, ATT_ARRIVE_TIME, ATT_LEFT_TIME, REG_ID, REG_DATE, MOD_ID, MOD_DATE)
VALUES('TE001', '', '', 'TE001', SYSDATE, 'TE001', SYSDATE);

UPDATE GEO.ATT
SET EMP_NO='', ATT_ARRIVE_TIME='', ATT_LEFT_TIME='', REG_ID='', REG_DATE='', MOD_ID='', MOD_DATE='';


-- 출근 --
UPDATE GEO.ATT
SET ATT_ARRIVE_TIME = SYSDATE,
	REG_ID = EMP_NO,
	REG_DATE = SYSDATE
WHERE EMP_NO = 'SY001'
AND ATT_ARRIVE_TIME IS NULL
AND TO_CHAR(ATT_ARRIVE_TIME, 'yyyy-MM-dd') = TO_CHAR(SYSDATE, 'yyyy-MM-dd');


UPDATE GEO.ATT
SET ATT_ARRIVE_TIME = SYSDATE,
    REG_ID = EMP_NO,
    REG_DATE = SYSDATE
WHERE EMP_NO = 'SY001';


UPDATE GEO.ATT
SET ATT_LEFT_TIME = SYSDATE,
	MOD_ID = EMP_NO,
	MOD_DATE = SYSDATE
WHERE EMP_NO = 'SY001'
AND ATT_LEFT_TIME IS NULL
AND TO_CHAR(ATT_ARRIVE_TIME, 'yyyy-MM-dd') = TO_CHAR(SYSDATE, 'yyyy-MM-dd');