<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>

<%@ include file="../comm/header.jsp"%>

<body>
	<%@ include file="../comm/sidebar.jsp"%>
	<main id="main" class="main">
		
		<c:forEach var="vo" items="${vo}" varStatus="vs">
			<tr>
				<td>${vo.emp_no}</td>
			</tr>
		</c:forEach>
		
		
		
		<script type="text/javascript"
			src="https://www.gstatic.com/charts/loader.js"></script>
		<script type="text/javascript">
			google.charts.load("current", {
				packages : [ "calendar" ]
			});
			google.charts.setOnLoadCallback(drawChart);
			function drawChart() {
				var dataTable = new google.visualization.DataTable();
				dataTable.addColumn({
					type : 'date',
					id : 'Date'
				});
				dataTable.addColumn({
					type : 'number',
					id : 'Won/Loss'
				});
				dataTable.addColumn({
					type : 'string',
					role : 'style'
				});
				var currentDate = new Date();
				var currentYear = new Date().getFullYear();
				var currentMonth = new Date().getMonth();
				//     var currentDate = new Date().getDate();
				console.log(currentMonth);
				console.log(currentYear);
				console.log(currentDate);
				dataTable
						.addRows([ [
								new Date(currentYear, currentMonth, currentDate
										.getDate()), 38830,
								'fill="color: #FF0000"' ] ]);
				var chart = new google.visualization.Calendar(document
						.getElementById('calendar_basic'));
				var options = {
					title : "근태기록부",
					height : 350
				};
				chart.draw(dataTable, options);
			}
			var intervalId = setInterval(
					function() {
						var svg = document.querySelector('#calendar_basic svg');
						if (svg) {
							var pathToRemove1 = svg
									.querySelector('path[fill*="url(http://localhost:8080/Proto_JobsInfo/#_ABSTRACT_RENDERER_ID_2)"]');
							if (pathToRemove1) {
								pathToRemove1.remove();
							}
							var pathToRemove2 = svg
									.querySelector('path[stroke="#EEEEEE"][fill-opacity="1"][fill="none"]');
							if (pathToRemove2) {
								pathToRemove2.remove();
							}
							var textToRemove1 = svg
									.querySelector('text[fill="#888888"][x="762"]');
							if (textToRemove1) {
								textToRemove1.remove();
							}
							var textToRemove2 = svg
									.querySelector('text[fill="#888888"][x="912"]');
							if (textToRemove2) {
								textToRemove2.remove();
							}
							if (pathToRemove1 || pathToRemove2 || textToRemove1
									|| textToRemove2) {
								clearInterval(intervalId);
							}
						}
					}, 0);
		</script>

		<div id="calendar_basic" style="width: 1000px; height: 350px;"></div>
		




	</main>
	<!-- End #main -->


</body>
<%@ include file="../comm/footer.jsp"%>


</html>