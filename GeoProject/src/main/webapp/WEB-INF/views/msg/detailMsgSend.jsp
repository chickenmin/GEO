<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
					<li class="breadcrumb-item active"><a href="./sendMsg.do">보낸 쪽지함</a></li>
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
	                  <div class="col-sm-2">받은 사람</div>
	                  <div class="col-sm-10">${msgDetail.msg_recv_id}</div>
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
	              
	              <div class="row mb-5"></div>
				  <div class="row mb-5"></div>
				  <div class="row mb-5"></div>
				  
				  <div class="row mb-2">
	                  <div class="col-sm-2">첨부파일</div>
	                  <div class="col-sm-10">첨부파일 있으면 표시</div>
	              </div>
	              
	            </div>
	          </div>
	
	        </div>
	      </div>
		</section>
		
		<div style="text-align: center;">
			<button type="button" class="btn btn-primary" onclick="location.href='./insertMsg.do'" style="display: inline-block">쪽지 작성</button>
			<button type="button" class="btn btn-secondary" onclick="location.href='./sendMsg.do'"style="display: inline-block">쪽지 목록</button>
			<button type="button" class="btn btn-danger" onclick="location.href='#'"style="display: inline-block">쪽지 삭제</button>
		</div>

  	</main><!-- End #main -->

</body>

  <%@ include file="../comm/footer.jsp" %>

</html>