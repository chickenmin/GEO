<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>


<head>
</head>
<%@ include file="../comm/header.jsp"%>
<meta charset="UTF-8">
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.8/dist/sweetalert2.all.min.js"></script>
<script src="./js/board.js" ></script>

<body>

	<%@ include file="../comm/sidebar.jsp"%>
	<main id="main" class="main">
		
	  
		<form action="./multiDeleteBoard.do" method="post" onsubmit="return chkSubmit()">
				<!-- 게시판 테이블 -->
	  <table class="table display" id="BoardTable">
				<!-- 게시판 선택 -->
					
							<br>
							<h1>삭제 게시판</h1>
							<thead>
								<tr>
									<th scope="col"  class="text-center"><input type="checkBox" id="chkbox" class="allCheckBox" onclick="checkAll(this.checked)"></th>
									<th scope="col"  class="text-center">No.</th>
									<th scope="col"  class="text-center">제목</th>
									<th scope="col"  class="text-center">작성자</th>
									<th scope="col"  class="text-center">작성일</th>
									<th scope="col"  class="text-center">추천</th>
									<th scope="col"  class="text-center">조회수</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="del" items="${delBoard}" varStatus="vs">
									<tr>
										<th  class="text-center" scope="row"><input type="checkbox" name="ch" class="ch" value="${del.bo_no}"></th>
										<td  class="text-center">${delBoard.size()-vs.index}</td>
										<td  class="text-center" onclick="location.href='./detailBoard.do?bo_no=${del.bo_no}'">${del.bo_title}</td>
										<td  class="text-center">${del.emp_no}${nomal.emp_no}</td>
										<td  class="text-center">${del.bo_regdate}</td>
										<td  class="text-center">${del.bo_like_count}</td>
										<td  class="text-center">${del.bo_view_count}</td>
									</tr>
								</c:forEach>
							</tbody>

				</table>
<!-- </table> -->
			<input type="submit" value="완전삭제" onclick="del(event)">
			
	<br>



	</main>
	<!-- End #main -->

</body>


<%@ include file="../comm/footer.jsp"%>
<script type="text/javascript">
$(document).ready(function() {
	$("#BoardTable").DataTable({
		"info": false,
		"columnDefs":[
			{"orderable": false, "targets":0}
		]
	});
});
</script>
</html>
