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
<script type="text/javascript" src="./js/datatime.js"></script>
<script type="text/javascript" src="./js/cal.js"></script>



<body>
	<%@ include file="../comm/sidebar.jsp" %>
 	<main id="main" class="main">
 		<div class="container">
 		<!-- 모달 -->
		<div class="modal fade" id="addEventModal" tabindex="-1" aria-labelledby="addEventModalLabel" aria-hidden="true">
		    <div class="modal-dialog">
		        <div class="modal-content">
		            <div class="modal-header">
		                <h5 class="modal-title" id="addEventModalLabel">일정 추가</h5>
		                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		            </div>
		            <div class="modal-body">
		                <form id="eventForm" action="./insertCal.do" method="post">
		                    <div class="mb-3">
		                        <span>일정번호</span>
		                        <input type="text" class="form-control" id="cal_no" required>
		                    </div>
		                    <div class="mb-3">
		                        <span>일정명</span>
		                        <input type="text" class="form-control" id="cal_title" required>
		                    </div>
       		                    <div class="mb-3">
		                        <span>일정내용</span>
		                        <input type="text" class="form-control" id="cal_content" required>
		                    </div>
		                    <div class="mb-3">
		                        <span>시작일자</span>
		                        <input type="text" class="form-control" id="datetimepicker1" required>
		                    </div>
		                    <div class="mb-3">
		                        <span>종료일자</span>
		                        <input type="text" class="form-control" id="datetimepicker2" required>
		                    </div>
							<span>일정종류</span>
							<br>
							<select name="cal_type" id="cal_type">
							    <option value="0">전사일정</option>
							    <option value="1">부서일정</option>
							    <option value="2">개인일정</option>
							</select>
							<br>
							<br>
							<span>공개여부</span>
							<br>
							<select name="cal_open_yn" id="cal_open_yn">
							    <option value="Y">공개</option>
							    <option value="N">비공개</option>
							</select>
							<br>
							<br>
		                    <button type="button" class="btn btn-primary" onclick="insertAjax(); alert('일정이 등록되었습니다'); location.href='calendar.do';">등록</button>
		                    <button type="button" class="btn btn-danger" data-bs-dismiss="modal" aria-label="Close" style="cursor:pointer;">취소</button>
		                </form>
		            </div>
		        </div>
		    </div>
		</div>
	</div>
	<div id="calendar"></div>
  
  
  	<div class="modal fade" id="eventModal" tabindex="-1" aria-labelledby="eventModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="eventModalLabel">일정 상세보기</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <p id="eventTitle"></p>
	        <p id="cal_content"></p>
	        <p id="eventStart"></p>
	        <p id="eventEnd"></p>
	      </div>
	      <div class="modal-footer">
	      	<button type="button" class="btn btn-primary"  data-toggle="modal" data-target="#addEventModal" onclick="openEventModal()">수정</button>
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
	      </div>
	    </div>
	  </div>
	</div>
  
  
  
  
  	</main><!-- End #main -->

</body>
<script type="text/javascript">
	$.datetimepicker.setLocale('ko');
	$("#datetimepicker").datetimepicker({		
	});

</script>
<%@ include file="../comm/footer.jsp" %>

</html>