<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>

<%@ include file="./header.jsp" %>

<body>
	<%@ include file="./sidebar.jsp" %>
 	<main id="main" class="main">

		<c:choose>
			<c:when test="${loginStatus eq 'success'}">
				<script>
					alert("로그인에 성공하였습니다.");
					self.location = "./index.do";
				</script>
			</c:when>
			
			<c:when test="${loginStatus eq 'fail'}">
				<script>
					alert("사원번호 또는 비밀번호를 확인해주세요.");
					self.location = "./login.do";
				</script>
			</c:when>
			
			<c:when test="${loginStatus eq 'login-Needed'}">
				<script>
					alert("로그인이 필요합니다.");
					self.location = "./login.do";
				</script>
			</c:when>
			
			<c:when test="${loginStatus eq 'update-Password-Needed'}">
				<script>
					alert("비밀번호 변경 대상입니다.");
					// 내 정보 변경 - 비밀번호 변경 탭으로 이동
					self.location = "./index.do";
// 					self.location = "./clearPw.do";
				</script>
			</c:when>
		</c:choose>

  	</main><!-- End #main -->


</body>
  <%@ include file="./footer.jsp" %>


</html>