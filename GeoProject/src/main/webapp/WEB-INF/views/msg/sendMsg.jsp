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
			<h1>보낸 쪽지함</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item">쪽지</li>
					<li class="breadcrumb-item active"><a href="./sendMsg.do">보낸 쪽지함</a></li>
				</ol>
			</nav>
		</div><!-- End Page Title -->
		
		<section class="section">
	      <div class="row">
	        <div class="col-lg-12">
	
	          <div class="card">
	            <div class="card-body">
	              <h5 class="card-title">보낸 쪽지함</h5>
	
	              <!-- Default Table -->
	              <table class="table display" id="sendMsgTable">
	                <thead>
	                  <tr>
	                  	<th scope="col" class="text-center">
	                  		<input type="checkbox"> <!-- 체크박스 -->
	                  	</th>
	                    <th scope="col" class="text-center">쪽지번호</th>
	                    <th scope="col" class="text-center">쪽지 내용</th>
	                    <th scope="col" class="text-center">받은 사람</th>
	                    <th scope="col" class="text-center">보낸 날짜</th>
	                  </tr>
	                </thead>
	                
	                <!-- tbody -->
	                <tbody>
	                  <c:forEach var="vo" items="${msgListSend}" varStatus="vs">
	                    <tr>
	                      <td class="text-center">
	                      	<input type="checkbox" value="${vo.msg_no}"> <!-- 체크박스 -->
	                      </td>
	                      
	                      <th scope="row" class="text-center">${fn:length(msgListSend) - vs.index}</th>
	                      
	                      <td><a href="./detailMsgSend.do?no=${vo.msg_no}">${vo.msg_content}</a></td>
	                      
	                      <!-- 회원 상세 조회 추가시 그 쪽으로 이동 -->
	                      <td class="text-center">${vo.msg_recv_id}</td> 
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
		</div>
  

  	</main><!-- End #main -->

</body>

  <%@ include file="../comm/footer.jsp" %>
<script type="text/javascript">

	$(document).ready(function() {
		$("#sendMsgTable").DataTable({
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
				url : "./deleteMsgSend.do",
				type : "post",
				dataType:"text",
				data : 'msg_no='+i,
				success : function(msg) {
					alert('삭제되었습니다.');
					location.href="./sendMsg.do"
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