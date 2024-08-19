<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    		
    			
    			//직접 만든 html
    		<div style="display: flex; justify-content: space-evenly;">
    			<div style="width: 150px; height:150px; background: white; position: relative;">
    				<div style="width:120px; height:120px; margin: auto; position: absolute; ">
	    				<span style="align-content: center;">일일 업무 일지</span> <br><br>
	    				<button class="btn btn-primary" >기안하기</button>
    				</div>
    			</div>
    			<div style="width: 150px; height:150px; background: white;"></div>
    			<div style="width: 150px; height:150px; background: white;"></div>
    		</div>

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
    					<c:forEach var="fav" items="${fav_form}">
	    					<tr>
	    						<th scope="row">1</th>
	    						<td> <a href="#">일일 업무 일지</a></td>
	    						<td></td>
	    						<td>
	    									<img alt="bookmark" src="img/nonBookmark.png">
	    							
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