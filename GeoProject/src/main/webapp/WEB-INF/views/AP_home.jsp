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
	      ${favList }
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
    							<div style="width: 150px; height:150px; background: white; position: relative;">
    								<div style="width:120px; height:120px; margin: auto; position: absolute; ">
	    								<span style="align-content: center;">${fav.apf_name}</span> <br><br>
	    								<button class="btn btn-primary" >기안하기</button>
    								</div>
    							</div>
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
    					<c:forEach var="fav" items="${favList}">
	    					<tr>
	    						<th scope="row">1</th>
	    						<td> <a href="#">일일 업무 일지</a></td>
	    						<td></td>
	    						<td>
	    							<c:choose>
	    								<c:when test="${fav.apd_form == 111}">
	    									<img alt="bookmark" src="img/yesBookmark.png">
	    								</c:when>
	    								<c:otherwise>
	    									<img alt="bookmark" src="img/nonBookmark.png">
	    								</c:otherwise>
	    							</c:choose>
	    						 </td>
	    					</tr>
	    					<tr>
	    						<th scope="row">2</th>
	    						<td> <a href="#">연차 신청서</a></td>
	    						<td></td>
	    						<td> <button>☆</button></td>
	    					</tr>
	    					<tr>
	    						<th scope="row">3</th>
	    						<td> <a href="#">일일 업무 일지</a></td>
	    						<td></td>
	    						<td> <button>☆</button></td>
	    					</tr>
	    					<tr>
	    						<th scope="row">4</th>
	    						<td> <a href="#">일일 업무 일지</a></td>
	    						<td></td>
	    						<td> <button>☆</button></td>
	    					</tr>
	    					<tr>
	    						<th scope="row">5</th>
	    						<td> <a href="#">일일 업무 일지</a></td>
	    						<td></td>
	    						<td> <button>☆</button></td>
	    					</tr>
	    				</c:forEach>	
    				</tbody>
    			</table>
    		</div>
    	</div>

  	</main><!-- End #main -->

  <%@ include file="./footer.jsp" %>

</body>

</html>