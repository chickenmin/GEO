SELECT BO_NO,ROWNUM,BO_TITLE  ,BO_WRITER ,BO_REGDATE ,BO_LIKE_COUNT ,BO_VIEW_COUNT 
	FROM PRO_BOARD
	WHERE BO_STATUS ='announcements';
	
SELECT BO_NO,ROWNUM,BO_TITLE  ,BO_WRITER ,BO_REGDATE ,BO_LIKE_COUNT ,BO_VIEW_COUNT 
	FROM PRO_BOARD
	WHERE BO_STATUS ='delete';
	
SELECT ROWNUM,BO_TITLE  ,BO_WRITER ,BO_REGDATE ,BO_LIKE_COUNT ,BO_VIEW_COUNT 
	FROM PRO_BOARD
	WHERE BO_STATUS ='nomal';
