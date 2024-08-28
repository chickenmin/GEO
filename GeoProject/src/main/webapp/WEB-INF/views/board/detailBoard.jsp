<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>

<%@ include file="../comm/header.jsp" %>

<body>
	<%@ include file="../comm/sidebar.jsp" %>
 	<main id="main" class="main">
		<br>
		<h1>${Vo.bo_title}</h1>
		${Vo.emp_no} · ${Vo.bo_regdate}
		<button>첨부파일</button>
		<br><a onclick="history.back(-1)">뒤로가기</a><br>
		<br><br>
		${Vo.bo_title}
		<br><br>
		${Vo.bo_content}
		<hr>
		<form action="./likeCount.do" method="post">
		<input type="hidden" name="bo_no" value="${Vo.bo_no}">
		<input type="hidden" name="emp_no" value="${Vo.emp_no}">
		<input type="submit" value="추천">
		</form>	
		<button>댓글</button>		
		<button onclick="location.href='./modifyBoard.do?bo_no=${Vo.bo_no}'">글수정</button>		
		<button onclick="del(event)">삭제</button>
  	</main><!-- End #main -->

</body>
  <%@ include file="../comm/footer.jsp" %>

</html>