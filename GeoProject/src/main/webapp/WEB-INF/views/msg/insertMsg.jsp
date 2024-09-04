<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<%@ include file="../comm/header.jsp" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
<style type="text/css">
    .modal-body {
        display: flex; /* Flexbox를 사용 */
        justify-content: space-evenly; /* 요소들 사이에 균등한 간격을 두고 정렬 */
        align-items: start; /* 요소들을 컨테이너의 시작 부분에 정렬 */
    }
    .modal-content {
   		height: 700px;
   	}
    #tree {
    	width: 200px;
    }
    .info-card {
        width: 200px; 
        background: white;
        display: flex;
        align-items: center;
        justify-content: center;
        position: relative;
    }
    .main-card {
        height: 400px; /* 첫 번째 카드의 높이 */
    }
    .choices-container {
        display: flex; /* 내부 카드들을 세로로 배치 */
        flex-direction: column; /* 세로 방향으로 요소들을 배치 */
        justify-content: space-between; /* 요소 사이의 간격을 균등하게 배분 */
    }
    .selTitle{
    	background-color: lightgreen;
    }
</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
<script type="text/javascript" src="./js/msgJsTree.js"></script>
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
	                
	                <div class="row mb-4" style="display: none;">
	                  <label for="inputText" class="col-sm-2 col-form-label">받는 사람</label>
	                  <div class="col-sm-10">
	                    <input type="text" id="msg_recv_id" name="msg_recv_id" class="form-control">
	                  </div>
	                </div>

	                <div class="row mb-4">
	                  <label for="inputText" class="col-sm-2 col-form-label">받는 사람</label>
	                  <div class="col-sm-2">
	                    <input type="text" id="recv_jsTree" class="form-control">
	                  </div>
	                  <div class="col-sm-8">
	                    <button type="button" id="recvJsTree" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#basicModal">
	                  		선택
	                  	</button>
	                  </div>
	                </div>
	                
	                <!-- modal -->
	                <div class="modal fade" id="basicModal" tabindex="-1">
						<div class="modal-dialog">
							<div class="modal-content">
							
								<!-- modal-header -->
								<div class="modal-header">
									<h5 class="modal-title"><b>받는사람 선택</b></h5>
								</div>
								
								<!-- modal-body -->
								<div class="modal-body" style="display: flex; justify-content: space-evenly;">
									<div class="card info-card revenue-card main-card">
										<div class="row mb-1"></div> <!-- 여백 -->
										<div id="tree"></div>
										<div style="display: flex; justify-content: space-between; margin-top: 10px;">
											<input type="text" id="schName" value="" style="flex: 1; margin-right: 10px; width: 80px;">
											<button onclick="fSch()" style="flex-shrink: 0;" type="button">탐색</button>
										</div>
									</div>
								</div> <!-- END modal-body -->
								
								<!-- modal-footer -->
								<div class="modal-footer">
									<button type="button" class="btn btn-primary" id="select" data-bs-dismiss="modal">선택완료</button>
									<button type="button" class="btn btn-danger" id="close" data-bs-dismiss="modal">닫기</button>
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
	              	 
	              	 // form에 제출하기 직전 거쳐가는 function
	              	 function sendDivContent(){
	              		 // 에디터에서 가져온 값 서버로 보내기
//  	              	 var plainText = quill.getText().trim(); // 텍스트만 가져옴
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