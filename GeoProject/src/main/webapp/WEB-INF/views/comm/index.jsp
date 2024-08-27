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
		
		<div>
			<form action="./arriveWork.do" method="post">
				<input type="hidden" name="emp_no" value="aa001">
				<button type="submit">출근</button>
			</form>
			<form action="./leftWork.do" method="post">
				<input type="hidden" name="emp_no" value="aa001">
				<button type="submit">퇴근</button>
			</form>
		</div>


  	</main><!-- End #main -->


</body>
  <%@ include file="./footer.jsp" %>


</html>