<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>

<%@ include file="../comm/header.jsp" %>
<body>
	<%@ include file="../comm/sidebar.jsp" %>
 	<main id="main" class="main">
		
		<div class="pagetitle">
			<h1>결재 문서함</h1>
		</div><!-- End Page Title -->
		
<!-- 		<form action="./"> -->
			<section class="section">
		      <div class="row">
		      <c:choose>
		      	<c:when test="${signs != null }">
		      		<c:forEach var="sign" items="signs"> 
				        <div class="col-lg-6">
							<h5 class="card-title">전자서명</h5>
							<div class="carousel-inner">
								<img alt="전자서명" src="${path}${sign.file_oname}">
							</div>
				        </div>
		      		</c:forEach>
		      	</c:when>
		      	<c:otherwise>
		      	
		      	</c:otherwise>
		      </c:choose>
		      </div>
			</section>
<!-- 		</form> -->
		


  	</main><!-- End #main -->

</body>
  <%@ include file="../comm/footer.jsp" %>
<script type="text/javascript">

	$(document).ready(function() {
		$("#apprList").DataTable({
			"info": false,
			"columnDefs":[
				{"orderable": false, "targets":0}
			]
		});
		

		
	});// ready 끝

	
</script>
</html>