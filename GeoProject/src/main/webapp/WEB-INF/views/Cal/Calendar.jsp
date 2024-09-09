<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="./dist/datetimepicker/jquery.datetimepicker.css">
<link href="./css/calendar.css" rel="stylesheet">
</head>
<%@ include file="../comm/header.jsp" %>
<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> --%>
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
		                        <span>일정명</span>
		                        <input type="text" class="form-control" id="cal_title" required/>
		                    </div>
       		                    <div class="mb-3">
		                        <span>일정내용</span>
		                        <input type="text" class="form-control" id="cal_content" required/>
		                    </div>
		                    <div class="mb-3">
		                        <span>시작일자</span>
		                        <input type="text" class="form-control" id="datetimepicker1" required/>
		                    </div>
		                    <div class="mb-3">
		                        <span>종료일자</span>
		                        <input type="text" class="form-control" id="datetimepicker2" required/>
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
  	
  	 <div class="container">		
 		<div class="checkboxes">
            <label><input type="checkbox" name="chk_box" id="allCheckBox" checked="checked" onclick="selectAjax();" value="0"> 전사일정</label><br>
            <label><input type="checkbox" name="chk_box" id="departmentCheckBox" checked="checked" onclick="selectAjax();" value="1"> 부서일정</label><br>
            <label><input type="checkbox" name="chk_box" id="employeeCheckBox" checked="checked" onclick="selectAjax();" value="2"> 사원일정</label>
        </div>
        
        <div id="calendarDisplay"></div>
     </div>

  
<!-- 상세보기 모달창 -->  
  <div class="modal fade" id="eventModal" aria-hidden="true" aria-labelledby="eventModalLabel" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalToggleLabel">일정 상세보기</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        	<p id="eventTitle"></p>
	        <p id="cal_content"></p>
	        <p id="eventStart"></p>
	        <p id="eventEnd"></p>
      </div>
      <div class="modal-footer">
<%--       <c:if test="${CalVo.emp_no eq 'AU003'}"> --%>
        <button class="btn btn-primary" id="updateBtn" data-bs-target="#updateEventModal" data-bs-toggle="modal" data-bs-dismiss="modal">수정창 이동</button>
     	<button type="button" class="btn btn-danger" id="deleteBtn" onclick="deleteCal()" style="display: inline-block">일정 삭제</button>
<%--       </c:if> --%>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>
<!-- 일정수정 모달창 -->
<div class="modal fade" id="updateEventModal" aria-hidden="true" aria-labelledby="updateEventModalLabel" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="updateEventModalLabel">일정수정</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
         <form id="updateEventForm">
         	<div class="mb-3">
                <input type="hidden" class="form-control" id="update_cal_no" required/>
            </div>
            <div class="mb-3">
                <span>일정명</span>
                <input type="text" class="form-control" id="update_cal_title" required/>
            </div>
            <div class="mb-3">
                <span>일정내용</span>
                <input type="text" class="form-control" id="update_cal_content" required/>
            </div>
            <div class="mb-3">
                <span>시작일자</span>
                <input type="text" class="form-control" id="update_datetimepicker1" required/>
            </div>
            <div class="mb-3">
                <span>종료일자</span>
                <input type="text" class="form-control" id="update_datetimepicker2" required/>
            </div>
            <span>일정종류</span>
            <br>
            <select name="update_cal_type" id="update_cal_type">
                <option value="0">전사일정</option>
                <option value="1">부서일정</option>
                <option value="2">개인일정</option>
            </select>
            <br>
            <br>
            <span>공개여부</span>
            <br>
            <select name="update_cal_open_yn" id="update_cal_open_yn">
                <option value="Y">공개</option>
                <option value="N">비공개</option>
            </select>
            <br>
            <br>

        </form>
      </div>
      <div class="modal-footer">

        <button class="btn btn-secondary" data-bs-target="#eventModal" data-bs-toggle="modal" data-bs-dismiss="modal">상세보기로 이동</button>
<%--       <c:if test="${CalVo.emp_no eq 'AA001' or CalVo.emp_no eq emp_no}"> --%>
        <button type="button" class="btn btn-primary" onclick="updateAjax(); alert('일정을 수정하시겠습니까?');">수정</button> 
<%--       </c:if> --%>
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal" aria-label="Close" style="cursor:pointer;">취소</button>
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