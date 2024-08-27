<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="./dist/datetimepicker/jquery.datetimepicker.css">
<link href="./css/calendar.css" rel="stylesheet">
</head>
<%@ include file="../comm/header.jsp" %>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js'></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<script src='https://cdn.jsdelivr.net/npm/@fullcalendar/google-calendar@6.1.15/index.global.min.js'></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/locales-all.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="./dist/datetimepicker/jquery.datetimepicker.full.min.js"></script>
<script type="text/javascript" src="./js/cal.js"></script>
<script type="text/javascript" src="./js/datatime.js"></script>
 

<body>
	<%@ include file="../comm/sidebar.jsp" %>
 	<main id="main" class="main">
 		<div class="container">
 				<form action="./insertCal.do" method="post">
				<div>
					<b>번호 : </b>
					<input type="text" id="cal_no" name="cal_no">
					<b>일정명 : </b>
					<input type="text" id="cal_title" name="cal_title">
					<b>내용 : </b>
					<input type="text" id="cal_content" name="cal_content">
				</div>
			
				<div style="margin-top: 10px;">
					
					<!-- datetimepicker -->
					<b>일정 시작일 : </b>
					<input type="text" name="cal_start" id="datetimepicker1" readonly="readonly" ondblclick="return false"><img src="./img/reply.png" id="imagebutton">
					<!-- datetimepicker -->
					<b>일정 종료일 : </b>
					<input type="text" name="cal_stop" id="datetimepicker2" readonly="readonly"><img src="./img/reply.png" id="imagebutton2">	<br>	
					<b>일정 종류 : </b>
					<input type="text" id="cal_type" name="cal_type">	
					<b>공개여부 : </b>
					<input type="text" id="cal_open_yn" name="cal_open_yn">						
				</div>

				<div>
					<input type="hidden" name="cal_type" value="1"/>
					<input type="button" onclick="insertAjax()" value="전송">
				</div>
				
			</form>
			</div>
		<div id="calendar"></div>
  
  	</main><!-- End #main -->

</body>
<script type="text/javascript">
	$.datetimepicker.setLocale('ko');
	$("#datetimepicker").datetimepicker({		
	});
</script>
<%@ include file="../comm/footer.jsp" %>

</html>