<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@ include file="./header.jsp" %>
<body>
	<%@ include file="./sidebar.jsp" %>
 	<main id="main" class="main">
		
		<div id="mdp-demo"></div>
		
		<script type="text/javascript">
		var date = new Date();
		$('#mdp-demo').multiDatesPicker({
		});
		</script>
  	</main><!-- End #main -->
</body>
  <%@ include file="./footer.jsp" %>
</html>