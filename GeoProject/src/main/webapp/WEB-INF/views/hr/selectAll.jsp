<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>

<%@ include file="../comm/header.jsp"%>
<style>
td a {
	color: inherit; /* 링크 색상을 부모 요소의 색상으로 설정 */
}

td strong {
	font-weight: normal; /* strong 효과 제거 */
}

td em {
	font-style: normal; /* em 효과 제거 */
}

td u {
	text-decoration: none;
}
/* 데이터테이블의 정렬 화살표를 숨깁니다 */
th.sorting_asc::after,
th.sorting_desc::after {
	display: none;
}

/* 특정 열의 정렬 화살표만 숨기기 */
th[data-dt-column="4"]::after {
	display: none;
}
</style>
<body>
	<%@ include file="../comm/sidebar.jsp"%>
	<main id="main" class="main">

		<div class="pagetitle">
			<h1>사원 조회</h1>
		</div>
		<!-- End Page Title -->

		<section class="section">
			<div class="row">
				<div class="col-lg-12">

					<div class="card">
						<div class="card-body">
							<h5 class="card-title">사원 조회</h5>
							

							<!-- Default Table -->
							<table class="table display" id="allEmpTable">
								<thead>
									<tr>
										<th scope="col" class="text-center">사번</th>
										<th scope="col" class="text-center">직급</th>
										<th scope="col" class="text-center">부서</th>
										<th scope="col" class="text-center">이름</th>
										<th scope="col" class="text-center">정보조회</th>
									</tr>
								</thead>

								<!-- tbody -->
								<tbody>
									<c:forEach var="vo" items="${vo}" varStatus="vs">
										<tr>
											<td class="text-center">${vo.emp_no}</td>

											<td class="text-center"><c:choose>
													<c:when test="${vo.emp_pos eq 'PO001'}">
													사원
												</c:when>
													<c:when test="${vo.emp_pos eq 'PO002'}">
													주임
												</c:when>
													<c:when test="${vo.emp_pos eq 'PO003'}">
													대리
												</c:when>
													<c:when test="${vo.emp_pos eq 'PO004'}">
													과장
												</c:when>
													<c:when test="${vo.emp_pos eq 'PO005'}">
													차장
												</c:when>
													<c:when test="${vo.emp_pos eq 'PO006'}">
													부장
												</c:when>

												</c:choose></td>
											<td class="text-center"><c:choose>
													<c:when test="${vo.emp_dept eq 'DE001'}">
													개발
												</c:when>
													<c:when test="${vo.emp_dept eq 'DE002'}">
													인사
												</c:when>
													<c:when test="${vo.emp_dept eq 'DE003'}">
													생산
												</c:when>
													<c:when test="${vo.emp_dept eq 'DE004'}">
													총무
												</c:when>
													<c:when test="${vo.emp_dept eq 'DE005'}">
													영업
												</c:when>
													<c:when test="${vo.emp_dept eq 'DE006'}">
													마케팅
												</c:when>
												</c:choose></td>
											<td class="text-center">${vo.emp_name}</td>
											<td class="text-center">
												<button type="submit" class="btn btn-primary"
													onclick="location.href='./selectOneEmp.do?emp_no=${vo.emp_no}'">조회</button>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							<!-- End Default Table Example -->
						</div>
					</div>

				</div>
			</div>
		</section>





	</main>
	<!-- End #main -->

</body>
<%@ include file="../comm/footer.jsp"%>
<script type="text/javascript">
	$(document).ready(function() {
		$("#allEmpTable").DataTable({
			"info" : false,
			"columnDefs" : [ {
				"orderable" : false,
				"targets" : 0
			} ]
		});
	});
	
	document.addEventListener('DOMContentLoaded', function() {
		var spanElement = document.querySelector('.dt-column-order');


		if (spanElement) {
			spanElement.remove();
		}
	});
	
	
	
</script>

</html>