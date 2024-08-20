<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>

<%@ include file="./header.jsp" %>

<body>
	<%@ include file="./sidebar.jsp" %>
	<script src="https://cdn.quilljs.com/1.3.6/quill.js"></script>
 	<main id="main" class="main">
		
		<div class="pagetitle">
			<h1>쪽지 작성</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item">쪽지</li>
					<li class="breadcrumb-item active"><a href="./insertMsg.do">쪽지 작성</a></li>
				</ol>
			</nav>
		</div><!-- End Page Title -->
		
		<section class="section">
	      <div class="row">
	        <div class="col-lg-12">
	
	          <div class="card">
	            <div class="card-body">
	              <h5 class="card-title">쪽지 작성</h5>
	
	              <!-- General Form Elements -->
	              <form action="./insertMsg.do" method="post" onsubmit="sendDivContent()">
	                
	                <div class="row mb-4">
	                  <label for="inputText" class="col-sm-2 col-form-label">받는 사람</label>
	                  <div class="col-sm-10">
	                    <input type="text" name="msg_recv_id" class="form-control">
	                  </div>
	                </div>
	                
	                <!-- 여유 되면 아래 div 제거하고 여백 추가. -->
	                <div class="row mb-5">
	                  <div class="col-sm-12">
		                  <!-- Quill Editor Default -->
		                  <div id="editor"></div>
		                  <!-- End Quill Editor Default -->
		                  <input type="hidden" name="msg_content" id="hiddenContent">
	                  </div>
	                </div>
	                
	                <div class="row mb-3"></div>
	                
	                <div class="row mb-3">
	                  <div class="col-sm-12">
	                    <input class="form-control" type="file" id="formFile">
	                  </div>
	                </div>
	                
	                <div class="row mb-3">
	                  <div class="col-sm-12" style="text-align: center;">
	                    <button type="submit" class="btn btn-primary" style="display: inline-block">쪽지 전송</button>
	                    <button type="button" class="btn btn-secondary" id="reset" style="display: inline-block">입력 초기화</button>
	                    <button type="button" class="btn btn-danger" onclick="location.href='./recvMsg.do'" style="display: inline-block">작성 취소</button>
	                  </div>
	                </div>
	
	              </form><!-- End General Form Elements -->
	              
	              <script>
	              	 var quill = new Quill('#editor', {
	              		 theme: 'snow'
	              	 });
	              
	              	 document.getElementById("reset").addEventListener("click",function(){
	              		 quill.setContents([]);
	              	 });
	              	 
	              	 function sendDivContent(){
// 	              		 var plainText = quill.getText().trim(); // 텍스트만 가져옴
	              		 var plainText = quill.root.innerHTML.substr(3).slice(0,-4);
	              		 document.getElementById("hiddenContent").value = plainText;
	              	 }
	              </script>
	            </div>
	          </div>
	
	        </div>
	      </div>
		</section>
		

  	</main><!-- End #main -->

</body>

  <%@ include file="./footer.jsp" %>

</html>