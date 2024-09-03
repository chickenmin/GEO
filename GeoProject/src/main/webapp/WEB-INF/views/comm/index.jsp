<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>

<%@ include file="./header.jsp" %>
<script src='https://cdn.jsdelivr.net/npm/@fullcalendar/google-calendar@6.1.15/index.global.min.js'></script>
<body>
	<%@ include file="./sidebar.jsp" %>
 	<main id="main" class="main">
		<div id="calendar"></div>
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
	              <button class="btn btn-primary">출근</button>
				  <button class="btn btn-danger">퇴근</button>
	            </div>
	          </div>
	          <!-- End Card with an image on top -->
	          
<!-- 	          	<div class="card" style="height: 400px; display: flex; flex-direction: column; align-items: center;"> -->
<!-- 				    <div style="height: 200px; display: flex; justify-content: center; align-items: center;"> -->
<!-- 				        <img src="img/profile.png" class="card-img-top" style="width: 60%; margin: 0 auto; display: block;" alt="..."> -->
<!-- 				    </div> -->
<!-- 				    <div class="card-body" style="height: 200px; text-align: center; display: flex; flex-direction: column; justify-content: center;"> -->
<%-- 				        <h5 class="card-title" style="display: inline-block;">${mainVo.emp_name}</h5> --%>
<%-- 				        <p class="card-text">${mainVo.emp_dept}팀 ${mainVo.emp_pos}</p> --%>
				        
<!-- 				        <button class="btn btn-primary">출근</button> -->
<!-- 				        <button class="btn btn-danger">퇴근</button> -->
<!-- 				        <form action="./arriveWork.do" method="post"> -->
<!-- 							<input type="hidden" name="emp_no" value="aa001"> -->
<!-- 							<button type="submit">출근</button> -->
<!-- 						</form> -->
<!-- 						<form action="./leftWork.do" method="post"> -->
<!-- 							<input type="hidden" name="emp_no" value="aa001"> -->
<!-- 							<button type="submit">퇴근</button> -->
<!-- 						</form> -->
<!-- 				    </div> -->
<!-- 				</div> -->

	          
	            
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
	
	
	        </div><!-- End Right side columns -->
	
	      </div>
	    </section>


		<div id="mdp-demo"></div>
		
		<script type="text/javascript">
		var date = new Date();
		$('#mdp-demo').multiDatesPicker({
		});
		</script>
		
		<div>
			<form action="./arriveWork.do" method="post">
				<input type="hidden" name="emp_no" value="aa001">
				<button type="submit">출근</button>
			</form>
			<form action="./leftWork.do" method="post">
				<input type="hidden" name="emp_no" value="aa001">
				<button type="submit">퇴근</button>
			</form>
		</div>


  	</main><!-- End #main -->


</body>
  <%@ include file="./footer.jsp" %>
<script type="text/javascript">
	$(document).ready(function() {
		$("#notiTable").DataTable({
			"lengthChange": false,
			"paging": false,
			"searching": false,
			"info": false,
			"order": [[4, "desc"]]
		});
	});
</script>

</html>