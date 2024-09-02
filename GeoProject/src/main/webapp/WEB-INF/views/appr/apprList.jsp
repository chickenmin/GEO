<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>

<%@ include file="../comm/header.jsp" %>
<head>
	<script type="text/javascript" src="./js/apprList.js"></script>
</head>
<style>
	td a {
		color: inherit; /* 링크 색상을 부모 요소의 색상으로 설정 */
	}
	
	td strong {
		font-weight: normal; /* strong 효과 제거 */
        }

    td em {
		font-style: normal; /* em 효과 제거 */
    }
    
    td u {
    	text-decoration: none;
    }
</style>
<body>
	<%@ include file="../comm/sidebar.jsp" %>
 	<main id="main" class="main">
		
		<div class="pagetitle">
			<h1>결재 문서함</h1>
		</div><!-- End Page Title -->
		
		<section class="section">
	      <div class="row">
	        <div class="col-lg-12">
	
	          <div class="card">
	            <div class="card-body">
	            	<form action="./deleteTemp.do" method="post">
			            <c:choose>
			            	<c:when test="${variety eq 'appr' }">
				              <h5 class="card-title">결재 문서</h5>
				              <button type="button" class="btn btn-outline-dark" onclick="location.href='./apprList.do?variety=appr'">전체</button>
				              <button type="button"  class="btn btn-outline-primary category">대기  </button>
				              <button type="button"  class="btn btn-outline-info category" >진행  </button>
				              <button type="button"  class="btn btn-outline-success category" >완료  </button>
				              <button type="button"  class="btn btn-outline-danger category" >반려  </button>
			            	</c:when>
			            	
			            	<c:when test="${variety eq 'submit' }">
			            		<h5 class="card-title">기안 문서</h5>
			            	</c:when>
			            	<c:when test="${variety eq 'temp' }">
			            		<h5 class="card-title">임시 문서</h5>
			            		<button class="btn btn-outline-danger category" >삭제 </button>
			            	</c:when>
			            	<c:otherwise>
			            		<h5 class="card-title">참조 문서</h5>
			            	</c:otherwise>
			            </c:choose>
			            
			
	              <!-- Default Table -->
		              <table class="table display" id="apprList">
		                <thead>
		                  <tr>
		                    <c:if test="${variety eq 'temp' }">
			                    <th scope="col" class="text-center"><input type="checkbox" id="allCheck"> </th>
		                    </c:if>
		                    <th scope="col" class="text-center">No.</th>
		                    <th scope="col" class="text-center">기안내용</th>
		                    <th scope="col" class="text-center">기안자</th>
		                    <th scope="col" class="text-center">기안일자</th>
		                    <c:if test="${variety ne 'temp' }">
		                    	<th scope="col" class="text-center">결재상태</th>
		                    </c:if>
		                  </tr>
		                </thead>
		                
		                <!-- tbody -->
		                <tbody class="listBody">
		                  <c:forEach var="vo" items="${lists}" varStatus="vs">
		                  
		                    <tr>
		                      <c:if test="${variety eq 'temp' }">
			                  	  <th scope="col" class="text-center">
			                  	  	<input type="checkbox" id="check" value="${vo.apd_no}" name="apd_nos"> 
			                  	  </th>
		                      </c:if>
		                      <th scope="row" class="text-center"><a> ${fn:length(lists) - vs.index}</a></th>
		                      <td class="text-center"> 
		                      <c:choose>
		                      	<c:when test="${variety ne 'temp' }">
			                      <a href="./detailAppr.do?apd_no=${vo.apd_no}&variety=${variety}">
			                      	${vo.apd_con }...
							      </a>      
		                      	</c:when>
		                      	<c:otherwise>
		                      		<a href="./tempDetail.do?apd_no=${vo.apd_no }">
			                      	${vo.apd_con }...
							      </a>
		                      	</c:otherwise>
		                      </c:choose>
		                      </td> 
		                      <td class="text-center">  ${vo.emp_no}</td>
		                      <td class="text-center"> ${vo.reg_date}</td>
		                      <c:if test="${variety ne 'temp' }">
			                      <td class="text-center">
			                      	<c:choose>
						                	<c:when test="${vo.apd_status eq 'W'}">
						                		<span class="badge border-primary border-1 text-primary">대기</span>
						                	</c:when>
						                	<c:when test="${vo.apd_status eq 'C'}">
						                		<span class="badge border-warning border-1 text-warning">완료</span>
						                	</c:when>
						                	<c:when test="${vo.apd_status eq 'P'}">
						                		<span class="badge border-success border-1 text-success">진행</span>
						                	</c:when>
						                	<c:otherwise>
						                		<span class="badge border-secondary border-1 text-secondary">반려</span>
						                	</c:otherwise>
						                </c:choose>
			                      </td>
		                   	 </c:if>
		                    </tr>
		                  </c:forEach>
		                </tbody>
		              </table>
	              </form>
	              
	              <!-- End Default Table Example -->
	            </div>
	          </div>
	
	        </div>
	      </div>
		</section>
		


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