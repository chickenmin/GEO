<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>

<%@ include file="../comm/header.jsp" %>
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
			<h1>받은 쪽지함</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item">쪽지</li>
					<li class="breadcrumb-item active"><a href="./recvMsg.do">받은 쪽지함</a></li>
				</ol>
			</nav>
		</div><!-- End Page Title -->
		
		<section class="section">
	      <div class="row">
	        <div class="col-lg-12">
	
	          <div class="card">
	            <div class="card-body">
	              <h5 class="card-title">받은 쪽지함</h5>
	
	              <!-- Default Table -->
	              <table class="table display" id="recvMsgTable">
	                <thead>
	                  <tr>
	                  	<th scope="col" class="text-center">
	                  		<input type="checkbox" id="checkbox"> <!-- 체크박스 -->
	                  	</th>
	                    <th scope="col" class="text-center">쪽지번호</th>
	                    <th scope="col" class="text-center">쪽지 내용</th>
	                    <th scope="col" class="text-center">보낸 사람</th>
	                    <th scope="col" class="text-center">보낸 날짜</th>
	                  </tr>
	                </thead>
	                
	                <!-- tbody -->
	                <tbody>
	                  <c:forEach var="vo" items="${msgListRecv}" varStatus="vs">
	                    <tr>
	                      <td class="text-center">
	                      	<input type="checkbox" id="msgNo" value="${vo.msg_no}"> <!-- 체크박스 -->
	                      </td>
	                      
	                      <th scope="row" class="text-center">${fn:length(msgListRecv) - vs.index}</th>
	                      
	                      <!-- 한번도 읽지않은 쪽지는 New 표시 -->
	                      <td><a href="./detailMsgRecv.do?no=${vo.msg_no}">
	                      	${vo.msg_content}
	                      	<span class="badge bg-primary">${vo.msg_recv_read_yn == 'N' ? 'New' : ''}</span>
	                      </a></td>
	                      
	                      <!-- 회원 상세 조회 추가시 그 쪽으로 이동 -->
	                      <td class="text-center">${vo.msg_send_id}</td> 
	                      <td class="text-center">${vo.msg_send_date}</td>
	                    </tr>
	                  </c:forEach>
	                </tbody>
	              </table>
	              <!-- End Default Table Example -->
	            </div>
	          </div>
	
	        </div>
	      </div>
		</section>
		
		<div style="text-align: center;">
			<button type="button" class="btn btn-primary" onclick="location.href='./insertMsg.do'" style="display: inline-block">쪽지 작성</button>
			<button type="button" class="btn btn-danger" id="deleteBtn" style="display: inline-block">쪽지 삭제</button>
<!-- 			<button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#disablebackdrop">쪽지 삭제</button> -->
		</div>
		
<!-- 		<div class="modal fade" id="disablebackdrop" tabindex="-1" data-bs-backdrop="false"> -->
<!-- 		  <div class="modal-dialog"> -->
<!-- 		    <div class="modal-content"> -->
<!-- 		      <div class="modal-header"> -->
<!-- 		        <h5 class="modal-title">경고</h5> -->
<!-- 		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button> -->
<!-- 		      </div> -->
		
<!-- 		      <div class="modal-body"> -->
<!-- 		        	선택한 게시글이 삭제됩니다. 계속하시겠습니까? -->
<!-- 		      </div> -->
		
<!-- 		      <div class="modal-footer"> -->
<!-- 		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button> -->
<!-- 		        <button type="button" id="deleteBtn" onclick="deleteMsg()" class="btn btn-primary">삭제</button> -->
<!-- 		      </div> -->
<!-- 		    </div> -->
<!-- 		  </div> -->
<!-- 		</div>End Disabled Backdrop Modal -->

  	</main><!-- End #main -->

</body>
  <%@ include file="../comm/footer.jsp" %>
<script type="text/javascript">

	$(document).ready(function() {
		$("#recvMsgTable").DataTable({
			"info": false,
			"columnDefs":[
				{"orderable": false, "targets":0}
			]
		});
	});

	$("#deleteBtn").click(function(){
		var i = "";
		$('tbody>tr>td>input[type=checkbox]:checked').each(function(index, item){
			i += item.value+",";
		});
		console.log(i);
		
		if(confirm("삭제하시겠습니까?")){
			$.ajax({
				url : "./deleteMsgRecv.do",
				type : "post",
				dataType:"text",
				data : 'msg_no='+i,
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