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
	              <form action="./insertMsg.do" method="post" enctype="multipart/form-data" onsubmit="sendDivContent()">
	                
	                <div class="row mb-4">
	                  <label for="inputText" class="col-sm-2 col-form-label">받는 사람</label>
	                  <div class="col-sm-10">
	                    <input type="text" id="msg_recv_id" name="msg_recv_id" class="form-control">
	                  </div>
	                </div>

	                <div class="row mb-4">
	                  <label for="inputText" class="col-sm-2 col-form-label">받는 사람 Jstree</label>
	                  <div class="col-sm-10">
	                    <input type="text" id="msg_recv_id" name="msg_recv_id2" class="form-control">
	                    <button type="button" class="btn btn-primary" onclick="selectRecv()">선택</button>
	                    <button type="button" id="recvJsTree" class="btn btn-primary rounded-pill" data-bs-toggle="modal" style="float: right; margin-bottom: 10px;" data-bs-target="#basicModal">
	                  		JsTree
	                  	</button>
	                  </div>
	                </div>
	                
	                <!-- modal -->
	                <div class="modal fade" id="basicModal" tabindex="-1">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title"><b> 결재선 선택</b> </h5>
								</div>
								
								<!-- 모달 몸체 -->
								<div class="modal-body"
									style="display: flex; justify-content: space-evenly;">
									
									<!-- jstree / 선택칸 -->
									<div class="card info-card revenue-card main-card">
										<div>결재라인</div>
										<div id="tree"></div>
										<div style="display: flex; justify-content: space-between; margin-top: 10px;">
											<input type="text" id="schName" value="" style="flex: 1; margin-right: 10px; width: 80px;">
											<button onclick="fSch()" style="flex-shrink: 0;" type="button">탐색</button>
										</div>
									</div>
									<div class="choices-container">
										<div class="choice card info-card revenue-card">
											<span>결재자</span>
											<div class="must"  id="appr" style="flex: 1; margin-top: 10px;"></div>
											<input id="apprCho" name="apprLine" type="hidden">
										</div>
										<div class="choice card info-card revenue-card">
											<span>참조자</span>
											<div id="cc" style="flex: 1; margin-top: 10px;"></div>
											<input id="ccCho" name="ccLine" type="hidden">
										</div>
										
										    <button id="apC" type="button" onclick="choice(event)">결재선택</button>
										    <button id="apR" type="button" onclick="choice(event)">결재취소</button>
										    <button id="reC"  type="button" onclick="choice(event)">참조선택</button>
										    <button  id="reR" type="button" onclick="choice(event)">참조취소</button>
										
									</div>
								
								</div> <!-- 모달 몸체 끝 -->
								
								
								<div class="modal-footer">
									<button type="button" class="btn btn-primary"
										data-bs-dismiss="modal" >선택완료
									</button>
								</div>
							</div>
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
	                    <input class="form-control" type="file" name="file">
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
	              
	              	 // 클릭하면 에디터 내부의 텍스트 비우기
	              	 document.getElementById("reset").addEventListener("click",function(){
	              		 quill.setContents([]);
	              		 document.getElementById("msg_recv_id").value = "";
	              	 });
	              	 
	              	 // form에 제출하기 위해 에디터 내부의 텍스트를 hiddenContent 내용으로 가져오기
	              	 function sendDivContent(){
//  	              		 var plainText = quill.getText().trim(); // 텍스트만 가져옴
// 	              		 var plainText = quill.root.innerHTML.substr(3).slice(0,-4);
	              		 var plainText = quill.root.innerHTML; // HTML만 가져옴
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

  <%@ include file="../comm/footer.jsp" %>

</html>