INSERT INTO NOTI(NOTI_NO, EMP_NO, NOTI_STATUS,
			NOTI_CONTENT, NOTI_DATE, NOTI_READ_YN,
			REG_ID, REG_DATE, MOD_ID,
			MOD_DATE)
	SELECT NOTI_SEQ.NEXTVAL, EMP.EMP_NO, '2',
			'새 공지가 등록되었습니다.', SYSDATE, 'N',
			'SYSTEM', SYSDATE, 'SYSTEM',
			SYSDATE
		FROM EMP;
		
-- 시퀀스 생성
CREATE SEQUENCE NOTI_SEQ START WITH 1 INCREMENT BY 1;

-- 시퀀스 확인(1 추가됨 주의)
SELECT BO_SEQ.NEXTVAL
	FROM DUAL;
	
-- 시퀀스 삭제
DROP SEQUENCE NOTI_SEQ;

SELECT EMP_NO
	FROM EMP
	WHERE EMP_STATUS = 'ST001';
	
CREATE SEQUENCE BO_SEQ START WITH 1 INCREMENT BY 1;

---------------------------------------------------------------------------------


-- 쪽지 테이블 생성
CREATE TABLE "MSG" (
	"MSG_NO"	NUMBER		NOT NULL,
	"MSG_SEND_ID"	VARCHAR2(100)		NOT NULL,
	"MSG_RECV_ID"	VARCHAR2(100)		NOT NULL,
	"MSG_CONTENT"	CLOB		NOT NULL,
	"MSG_SEND_DATE"	DATE		NOT NULL,
	"MSG_RECV_READ_YN"	VARCHAR2(100)	DEFAULT 'N'	NOT NULL,
	"MSG_SEND_DEL_YN"	VARCHAR2(100)	DEFAULT 'N'	NOT NULL,
	"MSG_RECV_DEL_YN"	VARCHAR2(100)	DEFAULT 'N'	NOT NULL,
	"REG_ID"	VARCHAR2(100)		NOT NULL,
	"REG_DATE"	DATE		NOT NULL,
	"MOD_ID"	VARCHAR2(100)		NOT NULL,
	"MOD_DATE"	DATE		NOT NULL
);

-- 쪽지 테이블 PK 지정
ALTER TABLE "MSG" ADD CONSTRAINT "PK_MSG" PRIMARY KEY (
	"MSG_NO"
);

---------------------------------------------------------------------------------

-- *** 쪽지 테이블 삭제
DROP TABLE MSG;

---------------------------------------------------------------------------------

-- 받은 쪽지 리스트 조회
SELECT MSG_NO , EMP.EMP_NAME AS MSG_SEND_ID, MSG_RECV_ID ,
		MSG_CONTENT , MSG_SEND_DATE , MSG_RECV_READ_YN ,
		MSG_SEND_DEL_YN , MSG_RECV_DEL_YN , MSG.REG_ID ,
		MSG.REG_DATE , MSG.MOD_ID , MSG.MOD_DATE 
	FROM MSG INNER JOIN EMP
		ON MSG.MSG_SEND_ID = EMP.EMP_NO
	WHERE MSG_RECV_ID = 'AA005'
		AND MSG_RECV_DEL_YN = 'N'
	ORDER BY MSG_SEND_DATE DESC;

-- 보낸 쪽지 리스트 조회
SELECT MSG_NO , MSG_SEND_ID , EMP.EMP_NAME AS MSG_RECV_ID, 
		MSG_CONTENT , MSG_SEND_DATE , MSG_RECV_READ_YN ,
		MSG_SEND_DEL_YN , MSG_RECV_DEL_YN , MSG.REG_ID ,
		MSG.REG_DATE , MSG.MOD_ID , MSG.MOD_DATE 
	FROM MSG INNER JOIN EMP
		ON MSG.MSG_RECV_ID = EMP.EMP_NO
	WHERE MSG_SEND_ID = 'AA005'
		AND MSG_SEND_DEL_YN = 'N'
	ORDER BY MSG_SEND_DATE DESC;

-- 쪽지 상세 조회
SELECT MSG_NO , MSG_SEND_ID , MSG_RECV_ID ,
		MSG_CONTENT , MSG_SEND_DATE , MSG_RECV_READ_YN ,
		MSG_SEND_DEL_YN , MSG_RECV_DEL_YN , REG_ID ,
		REG_DATE , MOD_ID , MOD_DATE 
	FROM MSG
	WHERE MSG_NO = '9';

-- 쪽지 보내기 (insert)
INSERT INTO GEO.MSG
				(MSG_NO, MSG_SEND_ID, MSG_RECV_ID,
				MSG_CONTENT, MSG_SEND_DATE, REG_ID,
				REG_DATE, MOD_ID, MOD_DATE)
	VALUES(MSG_SEQ.NEXTVAL, 'KANG', 'HYUN',
	'더미데이터 추가', SYSDATE, 'ADMIN',
	SYSDATE, 'ADMIN', SYSDATE);
	
-- 쪽지 읽기 (update)
UPDATE GEO.MSG
	SET MSG_RECV_READ_YN='Y', MOD_DATE=SYSDATE
	WHERE MSG_NO='9';

-- 받은 쪽지 삭제 (update)
UPDATE GEO.MSG
	SET MSG_RECV_DEL_YN='Y', MOD_DATE=SYSDATE
	WHERE MSG_NO IN ('9','40');

-- 보낸 쪽지 삭제 (update)
UPDATE GEO.MSG
	SET MSG_SEND_DEL_YN='Y'	, MOD_DATE=SYSDATE
	WHERE MSG_NO IN ('9','40');

-- 쪽지 테이블 더미데이터 입력
INSERT INTO GEO.MSG
				(MSG_NO, MSG_SEND_ID, MSG_RECV_ID,
				MSG_CONTENT, MSG_SEND_DATE, MSG_RECV_READ_YN,
				MSG_SEND_DEL_YN, MSG_RECV_DEL_YN, REG_ID,
				REG_DATE, MOD_ID, MOD_DATE)
	VALUES(MSG_SEQ.NEXTVAL, 'HYUN', 'HYUN',
	'쪽지내용11', SYSDATE, 'N',
	'N', 'N', 'HYUN',
	SYSDATE, 'HYUN', SYSDATE);

-- 시퀀스 생성
CREATE SEQUENCE MSG_SEQ START WITH 1 INCREMENT BY 1;

-- 시퀀스 확인(1 추가됨 주의)
SELECT MSG_SEQ.NEXTVAL
	FROM DUAL;
	
-- 시퀀스 삭제
DROP SEQUENCE MSG_SEQ;

---------------------------------------------------------------------------------

-- 파일 시퀀스 생성
CREATE SEQUENCE FILE_SEQ START WITH 1 INCREMENT BY 1;

-- 파일 시퀀스 확인(1 추가됨 주의)
SELECT FILE_SEQ.NEXTVAL
	FROM DUAL;
	
-- 파일 시퀀스 삭제
DROP SEQUENCE FILE_SEQ;

-- 파일 업로드
INSERT INTO GEO."FILE"
		(FILE_NO, ORIGIN_NO, FILE_ONAME,
		FILE_SNAME, FILE_SIZE, FILE_TYPE,
		FILE_RANK, REG_ID, REG_DATE,
		MOD_ID, MOD_DATE)
	VALUES(MSG_SEQ.NEXTVAL, 141, '나몰빼미.png',
			'7937b1ad-2e33-4367-935e-9614881144de.png', '62.3', '3',
			0, 'HYUN', SYSDATE,
			'HYUN', SYSDATE);

-- 파일 다운로드
SELECT FILE_NO, ORIGIN_NO, FILE_ONAME,
		FILE_SNAME, FILE_SIZE, FILE_TYPE,
		FILE_RANK, FILE_DEL_YN, REG_ID,
		REG_DATE, MOD_ID, MOD_DATE
	FROM GEO."FILE"
	WHERE ORIGIN_NO = '156';

---------------------------------------------------------------------------------

-- 테스트
SELECT *
	FROM EMP;
	
-- 로그인
SELECT EMP_NO, EMP_POS, EMP_DEPT,
		EMP_PW, EMP_NAME, EMP_GENDER,
		EMP_HIREDATE, EMP_EMAIL, EMP_PHONE,
		EMP_BIRTH, EMP_ADDRESS, EMP_AUTH,
		EMP_STATUS, EMP_RETIREDATE, REG_ID,
		REG_DATE, MOD_ID, MOD_DATE
	FROM GEO.EMP
	WHERE EMP_NO = 'emp5' AND EMP_PW = '111';

-- 임시비밀번호 발급 정보 확인
SELECT EMP_NO, EMP_POS, EMP_DEPT,
		EMP_PW, EMP_NAME, EMP_GENDER,
		EMP_HIREDATE, EMP_EMAIL, EMP_PHONE,
		EMP_BIRTH, EMP_ADDRESS, EMP_AUTH,
		EMP_STATUS, EMP_RETIREDATE, REG_ID,
		REG_DATE, MOD_ID, MOD_DATE
	FROM GEO.EMP
	WHERE EMP_NO = 'emp5'
		AND EMP_NAME = '최현아'
		AND EMP_EMAIL = 'limehyun15@gmail.com';
		
-- 임시 비밀번호 발급
UPDATE GEO.EMP
	SET EMP_PW='ABC123', EMP_STATUS='W',  MOD_ID='ADMIN', MOD_DATE=SYSDATE
	WHERE EMP_NO='emp5';

-- 확인
SELECT *
	FROM EMP
	WHERE EMP_NO = 'emp5';

-- 안읽은 쪽지 갯수 확인	
SELECT COUNT(*)
	FROM MSG
	WHERE MSG_RECV_ID = 'emp5'
		AND MSG_RECV_READ_YN = 'N'
		AND MSG_RECV_DEL_YN = 'N';

-- 드롭다운 클릭시 안읽은 쪽지 가장 최근에 온거 3개만 표시
SELECT EMP.EMP_NAME, MSG.MSG_CONTENT, MSG.MSG_SEND_DATE
	FROM (
	    SELECT MSG_SEND_ID, MSG_CONTENT, MSG_SEND_DATE, MSG_RECV_ID
	    FROM MSG
	    WHERE MSG_RECV_ID = 'AA005'
	        AND MSG_RECV_READ_YN = 'N'
	        AND MSG_RECV_DEL_YN = 'N'
	    ORDER BY MSG_SEND_DATE DESC
	) MSG
	JOIN EMP ON MSG.MSG_SEND_ID = EMP.EMP_NO
	WHERE ROWNUM <= 3;
	
SELECT *
	FROM MSG
	WHERE MSG_RECV_ID = 'AA005'
		AND MSG_RECV_READ_YN = 'N'
		AND MSG_RECV_DEL_YN = 'N'
	ORDER BY MSG_SEND_DATE DESC;

-- 메인 게시판 진짜최종
SELECT BO_NO , EMP_NAME , BO_TITLE ,
		BO_CONTENT , BO_VIEW_COUNT , BO_REGDATE
	FROM (SELECT BO_NO , EMP.EMP_NAME , BO_TITLE ,
				BO_CONTENT , BO_VIEW_COUNT , BO_REGDATE
			FROM BO INNER JOIN EMP
				ON BO.EMP_NO = EMP.EMP_NO 
			WHERE BO_STATUS = 'announcements'
				AND BO_DEL_YN = 'N'
			ORDER BY BO_REGDATE DESC)
	WHERE ROWNUM <= 5;
	
SELECT BO_NO , EMP.EMP_NAME , BO_TITLE ,
		BO_CONTENT , BO_VIEW_COUNT , BO_REGDATE
	FROM BO INNER JOIN EMP
		ON BO.EMP_NO = EMP.EMP_NO 
	WHERE BO_STATUS = 'announcements'
		AND BO_DEL_YN = 'N'
	ORDER BY BO_REGDATE DESC;
	
	
---------------------------------------------------------------------------------	
	
SELECT EMP_NO ,
 		EMP.EMP_NAME AS NAME,
	    POS.CODE_NAME AS "POSITION",
	    DEPT.CODE_NAME AS DEPARTMENT
	FROM EMP INNER JOIN COM POS 
		ON EMP.EMP_POS = POS.COMMON_CODE
			AND POS.DIVISION = '직급'
	INNER JOIN COM DEPT
		ON EMP.EMP_DEPT = DEPT.COMMON_CODE
			AND DEPT.DIVISION = '부서'
	WHERE EMP.EMP_NO = 'AA005';
			
SELECT *
	FROM COM;
	
SELECT CAL_NO , EMP_NO , CAL_TITLE ,
		CAL_CONTENT , CAL_START , CAL_STOP 
	FROM CAL
	WHERE CAL_DEL_YN = 'N'
		AND CAL_OPEN_YN = 'Y'
		AND EMP_NO = 'EE001';
	
---------------------------------------------------------------------------------	

-- 본인이 결재할 문서 조회
SELECT APD_NO, EMP.EMP_NAME AS EMP_NO , SUBSTR(APD_CON, 1, 10) AS APD_CON,
		APD_STEP ,APD_STATUS ,APD_DAYS ,
		APD_HALF_YN ,APD_FORM ,APD_CLEAR_DATE ,APD_TEMP_YN ,
		ad.REG_ID , ad.REG_DATE , ad.MOD_ID , ad.MOD_DATE 
 	FROM AP_DOCU ad INNER JOIN EMP
		ON ad.EMP_NO = EMP.EMP_NO 		
 	WHERE APD_NO IN (SELECT APD_NO 
					 	FROM AP_LINE al 
					 	WHERE EMP_NO = 'EE001')
 		AND APD_TEMP_YN = 'N'
 	ORDER BY REG_DATE DESC;
 		
-- 본인이 상신한 문서 조회
SELECT APD_NO, EMP.EMP_NAME AS EMP_NO , SUBSTR(APD_CON, 1, 10) AS APD_CON,
		APD_STEP ,APD_STATUS ,APD_DAYS ,
		APD_HALF_YN ,APD_FORM ,APD_CLEAR_DATE ,APD_TEMP_YN ,
		ad.REG_ID , ad.REG_DATE , ad.MOD_ID , ad.MOD_DATE 
 	FROM AP_DOCU ad INNER JOIN EMP
		ON ad.EMP_NO = EMP.EMP_NO 
 	WHERE ad.EMP_NO = 'EE001'
	 	AND APD_TEMP_YN = 'N'
 	ORDER BY REG_DATE DESC;

---------------------------------------------------------------------------------
 		
-- 쪽지 상세보기 쿼리 수정(보낸사람, 받는사람 이름으로)
SELECT MSG_NO , A.EMP_NAME AS MSG_SEND_ID , B.EMP_NAME AS MSG_RECV_ID ,
                MSG_CONTENT , MSG_SEND_DATE , MSG_RECV_READ_YN ,
                MSG_SEND_DEL_YN , MSG_RECV_DEL_YN , MSG.REG_ID ,
                MSG.REG_DATE , MSG.MOD_ID , MSG.MOD_DATE 
        	FROM MSG INNER JOIN EMP A 
        		ON MSG_SEND_ID = A.EMP_NO
        		INNER JOIN EMP B
        			ON MSG_RECV_ID = B.EMP_NO 
        	WHERE MSG_NO = '268';
 		

---------------------------------------------------------------------------------

SELECT APD_STATUS, COUNT(*) AS STATUS_COUNT
	FROM AP_DOCU 
	WHERE APD_NO IN (SELECT APD_NO 
						FROM AP_LINE al 
			 			WHERE EMP_NO = 'EE001')
		AND APD_TEMP_YN = 'N'
		AND APD_STATUS IN ('C', 'W', 'P', 'R')
	GROUP BY APD_STATUS;
	
	
	 
SELECT BO_NO , EMP_NAME AS EMP_NO , BO_TITLE ,
				BO_CONTENT , BO_VIEW_COUNT , BO_REGDATE
			FROM (SELECT BO_NO , EMP.EMP_NAME , BO_TITLE ,
						BO_CONTENT , BO_VIEW_COUNT , BO_REGDATE
					FROM BO INNER JOIN EMP
						ON BO.EMP_NO = EMP.EMP_NO 
					WHERE BO_STATUS = 'announcements'
						AND BO_DEL_YN = 'N'
					ORDER BY BO_REGDATE DESC)
			WHERE ROWNUM <= 5;
		


SELECT APD_NO, EMP_NO , APD_CON,
				APD_STEP ,APD_STATUS ,APD_DAYS ,
				APD_HALF_YN , APD_FORM , APD_CLEAR_DATE ,APD_TEMP_YN ,
				REG_ID , REG_DATE , MOD_ID , MOD_DATE
			FROM (SELECT APD_NO, EMP.EMP_NAME AS EMP_NO , APD_CON,
						APD_STEP ,APD_STATUS ,APD_DAYS ,
						APD_HALF_YN ,c.CODE_NAME AS APD_FORM , APD_CLEAR_DATE ,APD_TEMP_YN ,
						ad.REG_ID, ad.REG_DATE , ad.MOD_ID , ad.MOD_DATE 
 					FROM AP_DOCU ad INNER JOIN EMP
						ON ad.EMP_NO = EMP.EMP_NO
									INNER JOIN COM c
						ON ad.APD_FORM = c.COMMON_CODE  
 					WHERE APD_NO IN (SELECT APD_NO 
										FROM AP_LINE al 
					 					WHERE EMP_NO = 'EE001')
						AND APD_TEMP_YN = 'N'
					ORDER BY REG_DATE DESC)
			WHERE ROWNUM <= 5;
			
---------------------------------------------------------------------------------
			
			SELECT MSG.MSG_NO, MSG.MSG_CONTENT, EMP.EMP_IMG AS REG_DATE,
		EMP.EMP_NAME AS MSG_SEND_ID, MSG.MSG_SEND_DATE 
	FROM (SELECT MSG.MSG_NO, MSG_SEND_ID, MSG_CONTENT,
				MSG_SEND_DATE, MSG_RECV_ID 
			FROM MSG
			WHERE MSG_RECV_ID = 'EE001'
				AND MSG_RECV_READ_YN = 'N'
				AND MSG_RECV_DEL_YN = 'N'
			ORDER BY MSG_SEND_DATE DESC) MSG
		JOIN EMP ON MSG.MSG_SEND_ID = EMP.EMP_NO
	WHERE ROWNUM <= 3;
			
SELECT MSG.MSG_NO, MSG_SEND_ID, MSG_CONTENT,
						MSG_SEND_DATE, MSG_RECV_ID, MSG.REG_ID 
				    FROM MSG
				    WHERE MSG_RECV_ID = 'EE001'
				        AND MSG_RECV_READ_YN = 'N'
				        AND MSG_RECV_DEL_YN = 'N'
				    ORDER BY MSG_SEND_DATE DESC;
				    
SELECT * 
	FROM NOTI;
	
-- 공지게시판 관련 알림 : STATUS가 2
INSERT INTO NOTI(NOTI_NO, EMP_NO, NOTI_STATUS,
				NOTI_CONTENT, NOTI_DATE, REG_ID,
				REG_DATE, MOD_ID, MOD_DATE)
	VALUES(NOTI_SEQ.NEXTVAL, 'EE001', '2',
			'사내 공지사항이 등록되었습니다.', SYSDATE, 'EE001',
			SYSDATE, 'EE001', SYSDATE);
		
-- 시퀀스 생성
CREATE SEQUENCE NOTI_SEQ START WITH 1 INCREMENT BY 1;

-- 시퀀스 확인(1 추가됨 주의)
SELECT NOTI_SEQ.NEXTVAL
	FROM DUAL;
	
-- 시퀀스 삭제
DROP SEQUENCE NOTI_SEQ;


INSERT INTO NOTI(NOTI_NO, EMP_NO, NOTI_STATUS,
			NOTI_CONTENT, NOTI_DATE, NOTI_READ_YN,
			REG_ID, REG_DATE, MOD_ID,
			MOD_DATE)
	SELECT NOTI_SEQ.NEXTVAL, EMP.EMP_NO, '2',
			'새 공지가 등록되었습니다.', SYSDATE, 'N',
			'SYSTEM', SYSDATE, 'SYSTEM',
			SYSDATE
		FROM EMP;

-- 중복체크
SELECT NOTI_NO, COUNT(*)
FROM NOTI
GROUP BY NOTI_NO
HAVING COUNT(*) > 1;