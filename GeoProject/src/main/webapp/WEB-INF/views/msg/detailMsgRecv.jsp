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
			<h1>쪽지 상세보기</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item">쪽지</li>
					<li class="breadcrumb-item active"><a href="./recvMsg.do">받은 쪽지함</a></li>
					<li class="breadcrumb-item active">쪽지 상세보기</li>
				</ol>
			</nav>
		</div><!-- End Page Title -->
  
  		<section class="section">
	      <div class="row">
	        <div class="col-lg-12">
	
	          <div class="card">
	            <div class="card-body">
	              <h5 class="card-title">쪽지 상세보기</h5>
	              
				  <div class="row mb-4">
	                  <div class="col-sm-2">보낸 사람</div>
	                  <div class="col-sm-10">${msgDetail.msg_send_id}</div>
	              </div>
	              
	              <div class="row mb-4">
	                  <div class="col-sm-2">보낸 날짜</div>
	                  <div class="col-sm-10">${msgDetail.msg_send_date}</div>
	              </div>
	              
	              <div class="row mb-5">
	              	<div class="col-sm-12">
		                ${msgDetail.msg_content}
	              	</div>
	              </div>
	              
	              <div class="row mb-5">
	              </div>
				  <div class="row mb-5"></div>
				  <div class="row mb-5"></div>
				  
				  <!-- 첨부파일 -->
				  <div class="row mb-2">
	                  <div class="col-sm-2">첨부파일</div>
	                  <div class="col-sm-10">
				  		<c:choose>
				  			<c:when test="${file != null}">
							  	<form action="./download.do" method="post">
						  			${file.file_oname}
							  		&nbsp&nbsp
							  		<input type="hidden" name="no" id="no" value="${msgDetail.msg_no}">
							  		<button type="submit">다운로드</button>
						  		</form>
				  			</c:when>
				  			<c:otherwise>
				  				첨부파일 없음
				  				<input type="hidden" name="no" id="no" value="${msgDetail.msg_no}">
				  			</c:otherwise>
				  		</c:choose>
			  							  	
	                  </div>
	              </div>
	              
	            </div>
	          </div>
	
	        </div>
	      </div>
		</section>
		
		<div style="text-align: center;">
			<button type="button" class="btn btn-primary" onclick="location.href='./insertMsg.do'" style="display: inline-block">쪽지 작성</button>
			<button type="button" class="btn btn-secondary" onclick="location.href='./recvMsg.do'"style="display: inline-block">쪽지 목록</button>
			<button type="button" class="btn btn-danger" id="deleteBtn" style="display: inline-block">쪽지 삭제</button>
		</div>

  	</main><!-- End #main -->

</body>
  <%@ include file="../comm/footer.jsp" %>
<script type="text/javascript">
	var no = document.getElementById("no").value;

	$("#deleteBtn").click(function(){
		if(confirm("삭제하시겠습니까?")){
			$.ajax({
				url : "./deleteMsgRecv.do",
				type : "post",
				dataType:"text",
				data : 'msg_no='+no,
				success : function(msg) {
					alert('삭제되었습니다.');
					location.href="./recvMsg.do"
				},
				error : function(error) {
					alert('삭제에 실패하였습니다.');
				}
			});
		}else{
			alert("삭제를 취소합니다.");
		}
		
	});  	
</script>
</html>