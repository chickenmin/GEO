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
		<form action="./readsearch.do" method="post">
			<input type="text" id="search" value="" placeholder="검색할 내용을 입력하세요.">
			<button type="submit">
				<span>검색</span>
			</button>
		</form>
		<form action="./multiDeleteBoard.do" method="post" onsubmit="return chkSubmit()">
				<!-- 게시판 테이블 -->
				<table class="table table-bordered">
				<!-- 게시판 선택 -->
					<c:choose>
						<c:when test="${type == 'announcements'}">
							<br>
							<h1>공지 게시판</h1>
							<div>
							</div>
							<br>
							<thead>
								<tr class="table-active">
									<th scope="col"><input type="checkBox" id="chkbox" name="allCheckBox" class="allCheckBox" onclick="checkAll(this.checked)"></th>
									<th scope="col">No.</th>
									<th scope="col">제목</th>
									<th scope="col">작성자</th>
									<th scope="col">작성일</th>
									<th scope="col">추천</th>
									<th scope="col">조회수</th>
								</tr>
							</thead>
							<tbody>
							
								<c:forEach var="anno" items="${announcements}" varStatus="vs">
									<tr>
										<th scope="row"><input type="checkbox" name="ch" class="ch" value="${anno.bo_no}"></th>
										<td>${announcements.size()-vs.index}</td>
										<td onclick="location.href='./detailBoard.do?bo_no=${anno.bo_no}'">${anno.bo_title}</td>
										<td>${anno.emp_no}</td>
										<td>${anno.bo_regdate}</td>
										<td>${anno.bo_like_count}</td>
										<td>${anno.bo_view_count}</td>
									</tr>
								</c:forEach>
							</tbody>
						</c:when>
						
						<c:when test="${type == 'nomalBoard'}">
							<br>
							<h1>일반 게시판</h1>
							<thead>
								<tr class="table-active">
									<th scope="col">No.</th>
									<th scope="col">제목</th>
									<th scope="col">작성자</th>
									<th scope="col">작성일</th>
									<th scope="col">추천</th>
									<th scope="col">조회수</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="nomal" items="${nomalBoard}" varStatus="vs">
									<tr>
										<th scope="row"><input type="checkbox" name="ch" class="ch" value="${nomal.bo_no}"></th>
										<td>${nomalBoard.size()-vs.index}</td>
										<td onclick="location.href='./detailBoard.do?bo_no=${nomal.bo_no}'">${nomal.bo_title}</td>
										<td>${nomal.emp_no}</td>
										<td>${nomal.bo_regdate}</td>
										<td>${nomal.bo_like_count}</td>
										<td>${nomal.bo_view_count}</td>
									</tr>
								</c:forEach>
							</tbody>
						</c:when>

						<c:when test="${type == 'delBoard'}">
							<br>
							<h1>삭제 게시판</h1>
							<thead>
								<tr class="table-active">
									<th scope="col"><input type="checkBox" id="chkbox" class="allCheckBox" onclick="checkAll(this.checked)"></th>
									<th scope="col">No.</th>
									<th scope="col">제목</th>
									<th scope="col">작성자</th>
									<th scope="col">작성일</th>
									<th scope="col">추천</th>
									<th scope="col">조회수</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="del" items="${delBoard}" varStatus="vs">
									<tr>
										<th scope="row"><input type="checkbox" name="ch" class="ch" value="${del.bo_no}"></th>
										<td>${delBoard.size()-vs.index}</td>
										<td onclick="location.href='./detailBoard.do?bo_no=${del.bo_no}'">${del.bo_title}</td>
										<td>${del.emp_no}${nomal.emp_no}</td>
										<td>${del.bo_regdate}</td>
										<td>${del.bo_like_count}</td>
										<td>${del.bo_view_count}</td>
									</tr>
								</c:forEach>
							</tbody>
						</c:when>

					</c:choose>
				</table>

			<c:choose>
			<c:when test="${type=='delBoard'}">
			<input type="submit" value="완전삭제" onclick="del(event)">
			</c:when>
			
			<c:otherwise>
			<input type="submit" value="삭제">
			<input type="button" onclick="location.href='./writeBoard.do'" value="새글쓰기">
			</c:otherwise>
			</c:choose>
			</form>
	<br>


		<ul class="pagination">
			<li class="page-item">
			<a class="page-link" href="#"aria-label="Previous"> 
			<span aria-hidden="true">&laquo;</span>
			</a>
			</li>
			<c:choose>
				<c:when test="">
				
				</c:when>
			</c:choose>
			<c:forEach var="p" items="page" varStatus="vs">
			<li class="page-item"><a class="page-link" href="#">${vs.index+1}</a></li>
			</c:forEach>
			<li class="page-item"><a class="page-link" href="#" aria-label="Next"> 
			<span aria-hidden="true">&raquo;</span>
			</a></li>
		</ul>

	</main>
	<!-- End #main -->

</body>


<%@ include file="../comm/footer.jsp"%>

</html>
