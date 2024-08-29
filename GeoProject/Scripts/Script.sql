INSERT INTO GEO.ATT
(EMP_NO, ATT_ARRIVE_TIME, ATT_LEFT_TIME, REG_ID, REG_DATE, MOD_ID, MOD_DATE)
VALUES(
    'aa001',
    TO_DATE('2024-08-03 09:10:00', 'YYYY-MM-DD HH24:MI:SS'),
    TO_DATE('2024-08-03 18:00:00', 'YYYY-MM-DD HH24:MI:SS'),
    'aa001',
    SYSDATE,
    'aa001',
    SYSDATE
);

-- 근태 조회 --
SELECT EMP_NO , ATT_ARRIVE_TIME , ATT_LEFT_TIME
	FROM ATT a 
	WHERE EMP_NO = 'aa001';


-- 정상 근무 --
SELECT COUNT(*)
	FROM ATT a 
	WHERE EMP_NO = 'aa001'
	AND ATT_ARRIVE_TIME <= TO_DATE('09:00:00', 'HH24:MI:SS');
	

-- 지각 --
SELECT COUNT(*)
	FROM ATT a 
	WHERE EMP_NO = 'aa001'
	AND ATT_ARRIVE_TIME >= TO_DATE('09:00:00', 'HH24:MI:SS');

-- 사원 근태 조회 --
SELECT 
	SUM(CASE 
	WHEN ATT_ARRIVE_TIME <= TO_DATE('09:00:00', 'HH24:MI:SS') THEN 1 
	ELSE 0 
	END) AS 정상근무,
	SUM(CASE 
	WHEN ATT_ARRIVE_TIME > TO_DATE('09:00:00', 'HH24:MI:SS') THEN 1 
	ELSE 0 
	END) AS 지각
FROM
	ATT
WHERE
	EMP_NO = 'aa001';


-- 비밀번호 변경 --
UPDATE GEO.EMP
SET EMP_PW='1234'
WHERE EMP_NO='JJ001';

SELECT EMP_POSTCODE , EMP_ADDRESS1 , EMP_ADDRESS2 , EMP_ADDRESS3 
	FROM EMP e 
	WHERE EMP_NO = 'AA001';


SELECT EMP_IMG 
	FROM EMP e 
	WHERE EMP_NO = 'TE001';

