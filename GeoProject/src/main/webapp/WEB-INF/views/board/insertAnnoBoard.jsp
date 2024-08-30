<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html>

<%@ include file="../comm/header.jsp"%>

<body>
	<%@ include file="../comm/sidebar.jsp"%>
	<main id="main" class="main">
		<form action="${mode == 'insert' ? './writeBoard.do' : './modifyBoard.do'}" method="post">
		
		<br>
		<c:choose>
		<c:when test="${mode=='insert'}"><h1>글작성</h1></c:when>
		<c:when test="${mode=='modify'}"><h1>글수정</h1>
		</c:when>
		
		</c:choose>
		<br>
		<table class="table table-bordered">
			<tr>
				<td scope="row">게시판</td>
				<td>공지사항</td>
				<td>부서</td>
				<td>${loginVo.emp_dept}</td>
			</tr>
			<tr>
				<td scope="row">제목</td>
				<td colspan="3">
				<textarea rows="1" cols="50" name="bo_title" placeholder="제목 입력">${Vo.bo_title}</textarea>
				</td>
			</tr>
			<tr>
				<td scope="row">위젯에 표시</td>
				<td colspan="3">**위젯에 표시입력</td>
			</tr>
			<tr>
				<td colspan="4" rowspan="8">
				 <textarea name="bo_content" style="width: 1000px; height: 200px; box-sizing: border-box;" placeholder="내용 입력">${Vo.bo_content}</textarea>
				</td>
			</tr>
		</table>
		<input type="file" name="file">
		<c:choose>
		<c:when test="${mode=='insert'}">
		<button type="submit">게시</button>
		</c:when>
		<c:when test="${mode=='modify'}">
		<input type="hidden" name="bo_no" value="${Vo.bo_no}" />
		<button type="submit">수정</button>
		</c:when>
		</c:choose>
		<button onclick="history.back(-1)">취소</button>
	</form>
	
	
	</main>
	<!-- End #main -->


</body>
<%@ include file="../comm/footer.jsp"%>

</html>