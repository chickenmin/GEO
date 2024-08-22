
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


		<div class="card">
			<div class="card-body">
				<h5 class="card-title">사원 조회</h5>
				

				<!-- Table with stripped rows -->
				<div
					class="datatable-wrapper datatable-loading no-footer sortable searchable fixed-columns">
					<div class="datatable-top">
						<div class="datatable-dropdown">
							<label> 
								<select class="datatable-selector" name="per-page">
								<option value="사번">사번</option>
								<option value="직급">직급</option>
								<option value="부서">부서</option>
								<option value="이름">이름</option>
								</select>
							</label>
						</div>
						<div class="datatable-search">
							<input class="datatable-input" placeholder="내용을 입력해주세요"
								type="search" name="search" title="Search within table">
								<button type="submit" class="btn btn-primary">검색</button>
						</div>

						
					</div>
					<div class="datatable-container">
						<table class="table datatable datatable-table">
							<thead>
								<tr>
									<th data-sortable="true" style="width: 22%;">
										<button	class="datatable-sorter">
											<b>사번</b>
										</button>
									</th>
									<th data-sortable="true" style="width: 22%;">
										<button class="datatable-sorter">직급</button>
									</th>
									<th data-sortable="true" style="width: 22%;">
										<button class="datatable-sorter">부서</button>
									</th>
									<th data-format="YYYY/DD/MM" data-sortable="true" data-type="date" style="width: 22%;">
										<button class="datatable-sorter">이름</button>
									</th>
									<th data-sortable="true" class="red" style="width: 12%;">
										정보조회
									</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="vo" items="${vo}" varStatus="vs">
									<tr data-index="0">
										<td>${vo.emp_no}</td>
										<td>
											<c:choose>
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
											
											</c:choose>
										</td>
										<td>
											<c:choose>
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
											</c:choose>
										
										</td>
										<td>${vo.emp_name}</td>
										<td class="green">
											<button type="submit" class="btn btn-primary" onclick="location.href='./selectOneEmp.do?emp_no=${vo.emp_no}'">조회</button>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<div class="datatable-bottom" style="margin-right: 300px;">
						<nav class="datatable-pagination">
							<ul class="datatable-pagination-list">
								<li
									class="datatable-pagination-list-item datatable-hidden datatable-disabled"><button
										data-page="1" class="datatable-pagination-list-item-link"
										aria-label="Page 1">‹</button></li>
								<li class="datatable-pagination-list-item datatable-active"><button
										data-page="1" class="datatable-pagination-list-item-link"
										aria-label="Page 1">1</button></li>
								<li class="datatable-pagination-list-item"><button
										data-page="2" class="datatable-pagination-list-item-link"
										aria-label="Page 2">2</button></li>
								<li class="datatable-pagination-list-item"><button
										data-page="3" class="datatable-pagination-list-item-link"
										aria-label="Page 3">3</button></li>
								<li class="datatable-pagination-list-item"><button
										data-page="4" class="datatable-pagination-list-item-link"
										aria-label="Page 4">4</button></li>
								<li class="datatable-pagination-list-item"><button
										data-page="5" class="datatable-pagination-list-item-link"
										aria-label="Page 5">5</button></li>
								<li class="datatable-pagination-list-item"><button
										data-page="6" class="datatable-pagination-list-item-link"
										aria-label="Page 6">6</button></li>
								<li class="datatable-pagination-list-item"><button
										data-page="7" class="datatable-pagination-list-item-link"
										aria-label="Page 7">7</button></li>
								<li
									class="datatable-pagination-list-item datatable-ellipsis datatable-disabled"><button
										class="datatable-pagination-list-item-link">…</button></li>
								<li class="datatable-pagination-list-item"><button
										data-page="10" class="datatable-pagination-list-item-link"
										aria-label="Page 10">10</button></li>
								<li class="datatable-pagination-list-item"><button
										data-page="2" class="datatable-pagination-list-item-link"
										aria-label="Page 2">›</button></li>
							</ul>
						</nav>
					</div>
				</div>
				<!-- End Table with stripped rows -->

			</div>
		</div>


	</main>
	<!-- End #main -->

	<%@ include file="../comm/footer.jsp"%>

</body>

</html>