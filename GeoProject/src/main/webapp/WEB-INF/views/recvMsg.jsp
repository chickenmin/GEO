<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>

<%@ include file="./header.jsp" %>

<body>
	<%@ include file="./sidebar.jsp" %>
 	<main id="main" class="main">
		
		<div class="pagetitle">
			<h1>받은 쪽지함</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item">쪽지</li>
					<li class="breadcrumb-item active"><a href="./recvMsg.do">받은 쪽지함</a></li>
				</ol>
			</nav>
		</div><!-- End Page Title -->
		
		<section class="section">
	      <div class="row">
	        <div class="col-lg-12">
	
	          <div class="card">
	            <div class="card-body">
	              <h5 class="card-title">받은 쪽지함</h5>
	
	              <!-- Default Table -->
	              <table class="table">
	                <thead>
	                  <tr>
	                  	<th scope="col">
	                  		<input type="checkbox"> <!-- 체크박스 -->
	                  	</th>
	                    <th scope="col">쪽지번호</th>
	                    <th scope="col">쪽지 내용</th>
	                    <th scope="col">보낸 사람</th>
	                    <th scope="col">보낸 날짜</th>
	                  </tr>
	                </thead>
	                
	                <!-- tbody -->
	                <tbody>
	                  <c:forEach var="vo" items="${msgListRecv}" varStatus="vs">
	                    <tr>
	                      <td>
	                      	<input type="checkbox" value="${vo.msg_no}"> <!-- 체크박스 -->
	                      </td>
	                      
	                      <!-- 페이징하려면 수정 -->
	                      <th scope="row">${fn:length(msgListRecv) - vs.index}</th>
	                      
	                      <!-- 링크처럼 안보이게 CSS 수정 -->
	                      <td><a href="./detailMsgRecv.do?no=${vo.msg_no}">${vo.msg_content}</a></td>
	                      
	                      <!-- 회원 상세 조회 추가시 그 쪽으로 이동 -->
	                      <td>${vo.msg_send_id}</td> 
	                      <td>${vo.msg_send_date}</td>
	                    </tr>
	                  </c:forEach>
	                </tbody>
	              </table>
	              <!-- End Default Table Example -->
	            </div>
	          </div>
	
	        </div>
	      </div>
		</section>
		
		<div style="text-align: center;">
			<button type="button" class="btn btn-primary" onclick="location.href='./insertMsg.do'" style="display: inline-block">쪽지 작성</button>
			<button type="button" class="btn btn-danger" onclick="location.href='#'"style="display: inline-block">쪽지 삭제</button>
		</div>
  

  	</main><!-- End #main -->

</body>

  <%@ include file="./footer.jsp" %>

</html>