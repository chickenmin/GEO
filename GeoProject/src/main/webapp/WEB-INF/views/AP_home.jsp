<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<%@ include file="./header.jsp" %>

<body>
	<%@ include file="./sidebar.jsp" %>
 	<main id="main" class="main">
		
		<div class="pagetitle">
	      <h1>전자결재</h1>
    	</div><!-- End Page Title -->
    	
    	<div style="height: 200px; margin: 20px; ">
    		<span class="card-title">자주쓰는 양식</span><br>
    			<div style="display: flex; justify-content: space-evenly;">
    				<c:choose>
    					<c:when test="${favList == null}">
    						<div style="width:730px; border-radius:10px; height:150px; background: white; text-align: center;" >
    							<span style="width:400px;">자주 사용하는 양식이 없습니다.</span>
    						</div>
    					</c:when>
    					<c:otherwise>
    						<c:forEach var="fav" items="${favList}">
	    						<form action="./goForm.do">
	    							<div style="width: 150px; height:150px; background: white; position: relative;">
	    								<div style="width:120px; height:120px; margin: auto; position: absolute; ">
	    									<!-- 돔 탐색으로 양식명 받아와서 기안하기 클릭시 해당 결재 jsp로 이동 -->
		    								<span style="align-content: center;">${fav.apf_name}</span> <br><br>
		    								<input name="formNo" value="${fav.apd_form}" style="display: none">
		    								<button class="btn btn-primary">기안하기</button>
	    								</div>
	    							</div>
    							</form>
    						</c:forEach>
    					</c:otherwise>
    				</c:choose>
    		
    			</div>



    	</div>
    	
    	<div class="card">
    		<div class="card-body">
    			<h5 class="card-title">결재 양식함</h5>
    			<table class="table">
    				<thead>
    					<tr>
    						<th scope="col">No.</th>
    						<th scope="col">양식 제목</th>
    						<th scope="col">비고</th>
    						<th scope="col">즐겨찾기</th>
    					</tr>
    				</thead>
    				<tbody>
    					<tr>
    						<th scope="row">1</th>
    						<td> <a href="./daily.do" >일일 업무 일지</a></td>
    						<td></td>
    						<td>
			    				<c:set var="stopLoop" value="true" scope="page"/>
    							<c:forEach var="fav" items="${favList}">
	   								 <c:if test="${stopLoop}">
	   									<c:if test="${fav.apd_form == 111}">
	   										<img class="yesMark mark" alt="bookmark" src="img/yesBookmark.png" onclick="bookmark()">
	   										<c:set var="stopLoop" value="false" scope="page"/>
	   									</c:if>
						    		</c:if>
    							</c:forEach>
    							 <c:if test="${stopLoop}">
    								<img alt="bookmark" src="img/nonBookmark.png">
    							</c:if>
    						 </td>
    					</tr>
    					<tr>
    						<th scope="row">2</th>
    						<td> <a href="./dayOff.do">연차 신청서</a></td>
    						<td></td>
    						<td>
			    				<c:set var="stopLoop" value="true" scope="page"/>
    							<c:forEach var="fav" items="${favList}">
	   								 <c:if test="${stopLoop}">
	   									<c:if test="${fav.apd_form == 112}">
	   										<img class="yesMark mark"  alt="bookmark" src="img/yesBookmark.png">
	   										<c:set var="stopLoop" value="false" scope="page"/>
	   									</c:if>
						    		</c:if>
    							</c:forEach>
    							 <c:if test="${stopLoop}">
    								<img alt="bookmark" src="img/nonBookmark.png">
    							</c:if>
    						 </td>
    					</tr>
    					<tr>
    						<th scope="row">3</th>
    						<td> <a href="./pay.do">지출 결의서</a></td>
    						<td></td>
    						<td>
    							<c:set var="stopLoop" value="true" scope="page"/>
    							<c:forEach var="fav" items="${favList}">
	   								 <c:if test="${stopLoop}">
	   									<c:if test="${fav.apd_form == 113}">
	   										<img class="yesMark mark"  alt="bookmark" src="img/yesBookmark.png">
	   										<c:set var="stopLoop" value="false" scope="page"/>
	   									</c:if>
						    		</c:if>
    							</c:forEach>
    							 <c:if test="${stopLoop}">
    								<img alt="bookmark" src="img/nonBookmark.png">
    							</c:if>
    						 </td>
    					</tr>
    					<tr>
    						<th scope="row">4</th>
    						<td> <a href="./reason.do">사유서</a></td>
    						<td></td>
    						<td>
    						<c:set var="stopLoop" value="true" scope="page"/>
    							<c:forEach var="fav" items="${favList}">
	   								 <c:if test="${stopLoop}">
	   									<c:if test="${fav.apd_form == 114}">
	   										<img class="yesMark mark"  alt="bookmark" src="img/yesBookmark.png">
	   										<c:set var="stopLoop" value="false" scope="page"/>
	   									</c:if>
						    		</c:if>
    							</c:forEach>
    							 <c:if test="${stopLoop}">
    								<img alt="bookmark" src="img/nonBookmark.png">
    							</c:if>
    						 </td>
    					</tr>
    					<tr>
    						<th scope="row">5</th>
    						<td> <a href="./tripReport.do">출장보고서</a></td>
    						<td></td>
    						<td>
			    				<c:set var="stopLoop" value="true" scope="page"/>
    							<c:forEach var="fav" items="${favList}">
	   								 <c:if test="${stopLoop}">
	   									<c:if test="${fav.apd_form == 115}">
	   										<img class="yesMark mark"  alt="bookmark" src="img/yesBookmark.png">
	   										<c:set var="stopLoop" value="false" scope="page"/>
	   									</c:if>
						    		</c:if>
    							</c:forEach>
    							 <c:if test="${stopLoop}">
    								<img alt="bookmark" src="img/nonBookmark.png">
    							</c:if>
    						 </td>
    					</tr>
	    					
    				</tbody>
    			</table>
    		</div>
    	</div>

  	</main><!-- End #main -->

  <%@ include file="./footer.jsp" %>

</body>

<script type="text/javascript">

	function bookmark(){
		var yesBook = document.querySelectorAll(".yesMark");
		
		if(yesBook.length == 3){
			alert('즐겨찾기는 3개까지만 가능합니다');
		}
	}

</script>

</html>