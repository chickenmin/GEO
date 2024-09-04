<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>

<%@ include file="./header.jsp" %>

<head>
<script>
	$(document).ready(function() {
		$("#arriveWorkBtn").click(function(e) {
			e.preventDefault(); // 기본 폼 제출 방지
			$.ajax({
				type : 'POST',
				url : './arriveWork.do',
				data : {
					emp_no : $('#emp_no').val()
				},
				success : function(response) {
					if (response.status === 'success') {
						alert(response.message);
						// 페이지 리프레시 또는 추가 처리
						location.reload(); // 페이지 리프레시 예시
					} else {
						alert(response.message);
					}
				},
				error : function() {
					alert('서버 통신 중 오류가 발생했습니다.');
				}
			});
		});

		$("#leftWorkBtn").click(function(e) {
			e.preventDefault(); // 기본 폼 제출 방지
			$.ajax({
				type : 'POST',
				url : '/GeoProject/leftWork.do',
				data : {
					emp_no : $('#emp_no').val()
				},
				success : function(response) {
					if (response.status === 'success') {
						alert(response.message);
						// 페이지 리프레시 또는 추가 처리
						location.reload(); // 페이지 리프레시 예시
					} else {
						alert(response.message);
					}
				},
				error : function() {
					alert('서버 통신 중 오류가 발생했습니다.');
				}
			});
		});
	});
</script>
</head>

<link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.0/main.min.css' rel='stylesheet' />
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.0/main.min.js'></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.0/locales/ko.js"></script>
<script>

	document.addEventListener('DOMContentLoaded', function() {
	    var calendarEl = document.getElementById('calendar');
	    var calendar = new FullCalendar.Calendar(calendarEl, {
			eventSources: [
				{
					events: [
						{
							// 종일 일정
							title : '최이사 병가',
							start : '2024-09-02'
						},
						{
							// 시간 일정
							title : '최부장 연차',
							start : '2024-09-06T12:30:00',
							allDay : false
						}
					],
					color: 'black',
					textColor: 'white'
				}
			],
			initialView: 'dayGridWeek',
			height: 300
	    });
	    calendar.render();
	});

</script>
<body>
	<%@ include file="./sidebar.jsp" %>
 	<main id="main" class="main">
	
		<div class="pagetitle">
	      <h1>Dashboard</h1>
	      <nav>
	        <ol class="breadcrumb">
	          <li class="breadcrumb-item"><a href="./index.do">Home</a></li>
	          <li class="breadcrumb-item active">Dashboard</li>
	        </ol>
	      </nav>
	    </div><!-- End Page Title -->

		<section class="section dashboard">
	      <div class="row">
	
	        <!-- Left side columns -->
	        <div class="col-lg-3">
	
			  <!-- Card with an image on top -->
	          <div class="card">
		        <img src="assets/img/card.jpg" class="card-img-top"alt="...">
	            <div class="card-body" style="text-align: center;">
	              <h5 class="card-title" style="display: inline-block">${mainVo.emp_name}</h5>
	              <p class="card-text">${mainVo.emp_dept}팀 ${mainVo.emp_pos}</p>

<input type="hidden" id="emp_no" value="${loginVo.emp_no}">
    <button id="arriveWorkBtn" class="btn btn-primary">출근</button>
    <button id="leftWorkBtn" class="btn btn-danger">퇴근</button>
	            </div>
	          </div>
	          <!-- End Card with an image on top -->
	          
	  
	          <!-- End Card with an image on top -->


			  <div class="card">
	            <div class="card-body" style="text-align: center;">
	              <h5 class="card-title" style="display: inline-block">
	              	9월 결재 현황
	              </h5>
	              <div class="row mb-3"></div>
	              <table class="table">
	              	<thead>
		              	<tr>
		              		<td scope="col">총합</td>
		              		<td scope="col">승인</td>
		              		<td scope="col">반려</td>
		              		<td scope="col">대기</td>
		              	</tr>
	              	</thead>
	              	<tbody>
		              	<tr>
		              		<th scope="col">10</th>
		              		<th scope="col">2</th>
		              		<th scope="col">7</th>
		              		<th scope="col">1</th>
		              	</tr>
	              	</tbody>
	              </table>
	            </div>
	          </div>
			
			  <div class="card">
	            <div class="card-body" style="text-align: center;">
	              <h5 class="card-title" style="display: inline-block">
	              	9월 근태 현황
	              </h5>
	              <!-- Pie Chart -->
	              <canvas id="pieChart" style="max-height: 400px;"></canvas>
	              <script>
	                document.addEventListener("DOMContentLoaded", () => {
	                  new Chart(document.querySelector('#pieChart'), {
	                    type: 'pie',
	                    data: {
	                      labels: [
	                        '출근',
	                        '조퇴',
	                        '지각'
	                      ],
	                      datasets: [{
	                        label: 'My First Dataset',
	                        data: [355, 35, 60],
	                        backgroundColor: [
	                          'rgb(255, 99, 132)',
	                          'rgb(54, 162, 235)',
	                          'rgb(255, 205, 86)'
	                        ],
	                        hoverOffset: 4
	                      }]
	                    }
	                  });
	                });
	              </script>
	              <!-- End Pie CHart -->
	            </div>
	          </div>


	          
	            
	        </div><!-- End Left side columns -->
	
	        <!-- Right side columns -->
	        <div class="col-lg-9">
	        
				<!-- 공지 게시판 -->
	            <div class="col-12">
	              <div class="card recent-sales overflow-auto">
	
	                <div class="card-body">
	                  <h5 class="card-title">공지 게시판</h5>
	
	                  <!-- Default Table -->
		              <table class="table display" id="notiTable">
		                <thead>
		                  <tr>
		                    <th scope="col" class="text-center">글번호</th>
		                    <th scope="col" class="text-center">글제목</th>
		                    <th scope="col" class="text-center">작성자</th>
		                    <th scope="col" class="text-center">조회수</th>
		                    <th scope="col" class="text-center">작성일</th>
		                  </tr>
		                </thead>
		                
		                <!-- tbody -->
		                <tbody>
		                  <c:forEach var="vo" items="${board}" varStatus="vs">
		                    <tr>
		                      <th scope="row" class="text-center">${fn:length(board) - vs.index}</th>
		                      
		                      <!-- 한번도 읽지않은 쪽지는 New 표시 -->
		                      <td><a href="./detailBoard.do?bo_no=${vo.bo_no}">
		                      	${vo.bo_title}
		                      </a></td>
		                      
		                      <td class="text-center">${vo.emp_no}</td> 
		                      <td class="text-center">${vo.bo_view_count}</td> 
		                      <td class="text-center">${vo.bo_regdate}</td>
		                    </tr>
		                  </c:forEach>
		                </tbody>
		              </table>
		              <!-- End Default Table Example -->
	
	                </div>
	
	              </div>
	            </div><!-- 공지 게시판 End -->
	            
	            <!-- 결재 문서함 -->
	            <div class="col-12">
	              <div class="card recent-sales overflow-auto">
	
	                <div class="card-body">
	                  <h5 class="card-title">결재 문서함</h5>
	
	                  <!-- Default Table -->
		              <table class="table display" id="notiTable">
		                <thead>
		                  <tr>
		                    <th scope="col" class="text-center">글번호</th>
		                    <th scope="col" class="text-center">글제목</th>
		                    <th scope="col" class="text-center">작성자</th>
		                    <th scope="col" class="text-center">조회수</th>
		                    <th scope="col" class="text-center">작성일</th>
		                  </tr>
		                </thead>
		                
		                <!-- tbody -->
		                <tbody>
		                  <c:forEach var="vo" items="${board}" varStatus="vs">
		                    <tr>
		                      <th scope="row" class="text-center">${fn:length(board) - vs.index}</th>
		                      
		                      <!-- 한번도 읽지않은 쪽지는 New 표시 -->
		                      <td><a href="./detailBoard.do?bo_no=${vo.bo_no}">
		                      	${vo.bo_title}
		                      </a></td>
		                      
		                      <td class="text-center">${vo.emp_no}</td> 
		                      <td class="text-center">${vo.bo_view_count}</td> 
		                      <td class="text-center">${vo.bo_regdate}</td>
		                    </tr>
		                  </c:forEach>
		                </tbody>
		              </table>
		              <!-- End Default Table Example -->
	
	                </div>
	
	              </div>
	            </div><!-- 결재 문서함 End -->
	
				<!-- 달력 -->
				<div class="col-12">
	              <div class="card recent-sales overflow-auto">
	
	                <div class="card-body">
	                  <h5 class="card-title">이번 주 일정</h5>
	
					  <!-- 달력 그려지는 부분 -->
	                  <div id='calendar-container' style="height: 300px;">
						  <div id='calendar'></div>
					  </div>
	                </div>
	                <!-- End card-body -->
	
	              </div>
	            </div>
	            <!-- End 달력 -->
				
	
	        </div><!-- End Right side columns -->
	
	      </div>
	    </section>

		
<!-- 		<div> -->
<!-- 			<form action="./arriveWork.do" method="post"> -->
<%-- 				<input type="hidden" name="emp_no" value="${loginVo.emp_no}"> --%>
<!-- 				<button type="submit">출근</button> -->
<!-- 			</form> -->
<!-- 			<form action="./leftWork.do" method="post"> -->
<!-- 				<input type="hidden" name="emp_no" value="aa001"> -->
<!-- 				<button type="submit">퇴근</button> -->
<!-- 			</form> -->
<!-- 		</div> -->


  	</main><!-- End #main -->


</body>
  <%@ include file="./footer.jsp" %>
<script type="text/javascript">


</script>

</html>