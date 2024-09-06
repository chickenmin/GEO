<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>

<%@ include file="../comm/header.jsp" %>
<head>
	<style type="text/css">
        #signature-pad {
            border: 2px solid #000;
            width: 400px;
            height: 200px;
            margin-bottom: 10px;
        }
        .btn {
            margin-right: 10px;
        }
	</style>
	 <script src="https://cdn.jsdelivr.net/npm/signature_pad@4.1.7/dist/signature_pad.umd.min.js"></script>
	 <script src="./js/signHome.js"></script>
</head>
<body>
	<%@ include file="../comm/sidebar.jsp" %>
 	<main id="main" class="main" style="height: 600px;">
		
		<div class="pagetitle">
			<h1>결재 문서함</h1>
		</div><!-- End Page Title -->
		
			<section class="section">
		      <div class="row">
		     	 <div class="formDiv" >
		      	<form action="./deleteSign.do" method="post"> <!-- 삭제 -->
		      		<button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#enroll"
		      			style="margin: 3px;">사인생성</button>
		      		<button type="button" class="btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#sign"
		      			style="margin: 3px;">파일추가</button>
		      		<button class="btn btn-outline-success " 	style="margin: 3px;">삭제</button>
			      <c:choose>
			      	<c:when test="${fn:length(signs) != 0 || fn:length(signature) != 0}">
			      		<div style="display: flex; justify-content: space-evenly;">
				      		<c:forEach var="sign" items="${signs}" varStatus="vs"> 
						       <div class="card info-card revenue-card">
								    <h5 class="card-title" style="text-align: center;">도장</h5>
								    <div class="position-relative">
								        <!-- 이미지 -->
								        <img alt="도장이미지" src="./signature/${sign.file_oname }" style="height: 200px; width: 200px;">
								        <!-- 체크박스 -->
								        <input type="checkbox" name="signName" value="${sign.file_oname}" 
								               class="position-absolute" style="top: 10px; left: 10px;">
								    </div>
								</div>
				      		</c:forEach>
				      		<c:forEach var="signs" items="${signature}" varStatus="vs"> 
						       <div class="card info-card revenue-card">
								    <h5 class="card-title" style="text-align: center;">전자서명</h5>
								    <div class="position-relative">
								        <!-- 이미지 -->
								        <img alt="전자서명" src="data:image/png;base64,${signs.encoding }" style="height: 200px; width: 200px;">
								        <!-- 체크박스 -->
								        <input type="checkbox" name="signatureName" value="${signs.encoding }" 
								               class="position-absolute" style="top: 10px; left: 10px;">
								    </div>
								</div>
				      		</c:forEach>
				      	</div>
			      	</c:when>
			      	<c:otherwise>
			      		<div class="card">
			      			<div class="card-body" style="text-align: center;"><br><h4>등록된 서명이 없습니다.</h4></div>
						</div>
			      	</c:otherwise>
			      </c:choose>
		      </form>
		      </div>
		      </div>
			</section>
		
<jsp:include page="./enrollFile.jsp"></jsp:include>
<jsp:include page="./enrollSign.jsp"></jsp:include>

  	</main><!-- End #main -->

  <%@ include file="../comm/footer.jsp" %>
</body>

</html>