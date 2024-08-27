<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<%@ include file="./header.jsp" %>

<body>
	<%@ include file="./sidebar.jsp" %>
 	<main id="main" class="main">

		<script>
			alert("로그인이 필요합니다.");
			self.location = "./login.do"
		</script>
		


  	</main><!-- End #main -->


</body>
  <%@ include file="./footer.jsp" %>


</html>