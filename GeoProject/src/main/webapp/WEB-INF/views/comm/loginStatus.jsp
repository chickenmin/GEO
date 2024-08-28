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
			<c:when test="${loginStatus eq 'login-Needed'}">
				<script>
					alert("로그인이 필요합니다.");
					self.location = "./login.do";
				</script>
			</c:when>
		</c:choose>

  	</main><!-- End #main -->


</body>
  <%@ include file="./footer.jsp" %>


</html>