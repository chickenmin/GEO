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
	              <table class="table">
	                <thead>
	                  <tr>
	                  	<th scope="col" class="text-center">
	                  		<input type="checkbox" id="checkbox" style="display: none;"> <!-- 체크박스 -->
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
	                      	<input type="checkbox" id="msgNo" value="${vo.msg_no}" style="display: none;"> <!-- 체크박스 -->
	                      </td>
	                      
	                      <!-- 페이징하려면 수정 -->
	                      <th scope="row" class="text-center">${fn:length(msgListRecv) - vs.index}</th>
	                      
	                      <!-- 링크처럼 안보이게 CSS 수정 -->
	                      <td><a href="./detailMsgRecv.do?no=${vo.msg_no}">
	                      	${vo.msg_content}
	                      	<span class="badge bg-primary">${vo.msg_recv_read_yn == 'N' ? 'New' : ''}</span>
<!-- 	                      	<span class="">Primary</span> -->
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
			<button type="button" class="btn btn-danger" id="deleteBtn" onclick="deleteMsg()" style="display: inline-block">쪽지 삭제</button>
		</div>

  	</main><!-- End #main -->

</body>
  <%@ include file="../comm/footer.jsp" %>
  <script type="text/javascript">
  		$(document).ready(function() {
	  			$("#deleteBtn").click(function(){
	  				$("input[type=checkbox]").show();
	  			});
  		});
  		
		function deleteMsg(){
  			
			var msgNo = document.getElementById("msgNo").value;
			console.log(msgNo);
			
			var checkedLength = $('tbody>tr>td>input[type=checkbox]:checked').length;
			console.log(checkedLength);
			
// 			if(){
				
// 			}
			
// 			fetch("./deleteMsgRecv.do?msg_no="+msgNo,{
// 				method:"get"
// 			})
// 			.then(response => {
// 				if(!response.ok){
// 					throw new Error("잘못된 요청처리입니다.");
// 				}
// 				return response.text();
// 			})
// 			.then(msg => {
// 				if(msg == "true"){
// 					document.getElementById();
// 				}
// 			});
			
		}
</script>
</html>