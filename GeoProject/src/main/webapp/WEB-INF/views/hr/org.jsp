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
		<div class="card-body">
			<div>
				<h5 class="card-title">조직도</h5>

				<!-- Default Tabs -->
				<ul class="nav nav-tabs" id="myTab" role="tablist">
					<li class="nav-item" role="presentation">
						<button class="nav-link active" id="home-tab" data-bs-toggle="tab"
							data-bs-target="#de001" type="button" role="tab"
							aria-controls="de001" aria-selected="true">개발</button>
					</li>
					<li class="nav-item" role="presentation">
						<button class="nav-link" id="profile-tab" data-bs-toggle="tab"
							data-bs-target="#de002" type="button" role="tab"
							aria-controls="de002" aria-selected="false" tabindex="-1">인사</button>
					</li>
					<li class="nav-item" role="presentation">
						<button class="nav-link" id="contact-tab" data-bs-toggle="tab"
							data-bs-target="#de003" type="button" role="tab"
							aria-controls="de003" aria-selected="false" tabindex="-1">생산</button>
					</li>
					<li class="nav-item" role="presentation">
						<button class="nav-link" id="contact-tab" data-bs-toggle="tab"
							data-bs-target="#de004" type="button" role="tab"
							aria-controls="de004" aria-selected="false" tabindex="-1">총무</button>
					</li>
					<li class="nav-item" role="presentation">
						<button class="nav-link" id="contact-tab" data-bs-toggle="tab"
							data-bs-target="#de005" type="button" role="tab"
							aria-controls="de005" aria-selected="false" tabindex="-1">영업</button>
					</li>
					<li class="nav-item" role="presentation">
						<button class="nav-link" id="contact-tab" data-bs-toggle="tab"
							data-bs-target="#de006" type="button" role="tab"
							aria-controls="de006" aria-selected="false" tabindex="-1">마케팅</button>
					</li>
				</ul>
				<div class="tab-content pt-2" id="myTabContent">
					<div class="tab-pane fade show active" id="de001" role="tabpanel"
						aria-labelledby="home-tab">
						<p>부장</p>
						<div style="display: flex; flex-wrap: wrap; gap: 10px;">
							<c:forEach var="vo" items="${vo}">
								<c:if test="${vo.emp_dept eq 'DE001' && vo.emp_pos eq 'PO006'}">
									<div class="card"
										style="flex: 0 1 calc(25% - 10px); box-sizing: border-box; width: 200px; height: 200px;">
										<div class="card-body" style="text-align: center;">
											<img src="<c:url value='/storage/${vo.emp_img}'/>"
												class="card-img-top" alt="...">
											<h5 class="card-title" style="display: inline-block">${vo.emp_name}</h5>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</div>
						<p>차장</p>
						<div style="display: flex; flex-wrap: wrap; gap: 10px;">
							<c:forEach var="vo" items="${vo}">
								<c:if test="${vo.emp_dept eq 'DE001' && vo.emp_pos eq 'PO005'}">
									<div class="card"
										style="flex: 0 1 calc(25% - 10px); box-sizing: border-box; width: 200px; height: 200px;">
										<div class="card-body" style="text-align: center;">
											<img src="<c:url value='/storage/${vo.emp_img}'/>"
												class="card-img-top" alt="...">
											<h5 class="card-title" style="display: inline-block">${vo.emp_name}</h5>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</div>
						<p>과장</p>
						<div style="display: flex; flex-wrap: wrap; gap: 10px;">
							<c:forEach var="vo" items="${vo}">
								<c:if test="${vo.emp_dept eq 'DE001' && vo.emp_pos eq 'PO004'}">
									<div class="card"
										style="flex: 0 1 calc(25% - 10px); box-sizing: border-box; width: 200px; height: 200px;">
										<div class="card-body" style="text-align: center;">
											<img src="<c:url value='/storage/${vo.emp_img}'/>"
												class="card-img-top" alt="...">
											<h5 class="card-title" style="display: inline-block">${vo.emp_name}</h5>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</div>
						<p>대리</p>
						<div style="display: flex; flex-wrap: wrap; gap: 10px;">
							<c:forEach var="vo" items="${vo}">
								<c:if test="${vo.emp_dept eq 'DE001' && vo.emp_pos eq 'PO003'}">
									<div class="card"
										style="flex: 0 1 calc(25% - 10px); box-sizing: border-box; width: 200px; height: 200px;">
										<div class="card-body" style="text-align: center;">
											<img src="<c:url value='/storage/${vo.emp_img}'/>"
												class="card-img-top" alt="...">
											<h5 class="card-title" style="display: inline-block">${vo.emp_name}</h5>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</div>
						<p>주임</p>
						<div style="display: flex; flex-wrap: wrap; gap: 10px;">
							<c:forEach var="vo" items="${vo}">
								<c:if test="${vo.emp_dept eq 'DE001' && vo.emp_pos eq 'PO002'}">
									<div class="card"
										style="flex: 0 1 calc(25% - 10px); box-sizing: border-box; width: 200px; height: 200px;">
										<div class="card-body" style="text-align: center;">
											<img src="<c:url value='/storage/${vo.emp_img}'/>"
												class="card-img-top" alt="...">
											<h5 class="card-title" style="display: inline-block">${vo.emp_name}</h5>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</div>
						<p>사원</p>
						<div style="display: flex; flex-wrap: wrap; gap: 10px;">
							<c:forEach var="vo" items="${vo}">
								<c:if test="${vo.emp_dept eq 'DE001' && vo.emp_pos eq 'PO001'}">
									<div class="card"
										style="flex: 0 1 calc(25% - 10px); box-sizing: border-box; width: 200px; height: 200px;">
										<div class="card-body" style="text-align: center;">
											<img src="<c:url value='/storage/${vo.emp_img}'/>"
												class="card-img-top" alt="...">
											<h5 class="card-title" style="display: inline-block">${vo.emp_name}</h5>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</div>
					</div>
					<div class="tab-pane fade" id="de002" role="tabpanel"
						aria-labelledby="profile-tab">
						<p>부장</p>
						<div style="display: flex; flex-wrap: wrap; gap: 10px;">
							<c:forEach var="vo" items="${vo}">
								<c:if test="${vo.emp_dept eq 'DE002' && vo.emp_pos eq 'PO006'}">
									<div class="card"
										style="flex: 0 1 calc(25% - 10px); box-sizing: border-box; width: 200px; height: 200px;">
										<div class="card-body" style="text-align: center;">
											<img src="<c:url value='/storage/${vo.emp_img}'/>"
												class="card-img-top" alt="...">
											<h5 class="card-title" style="display: inline-block">${vo.emp_name}</h5>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</div>
						<p>차장</p>
						<div style="display: flex; flex-wrap: wrap; gap: 10px;">
							<c:forEach var="vo" items="${vo}">
								<c:if test="${vo.emp_dept eq 'DE002' && vo.emp_pos eq 'PO005'}">
									<div class="card"
										style="flex: 0 1 calc(25% - 10px); box-sizing: border-box; width: 200px; height: 200px;">
										<div class="card-body" style="text-align: center;">
											<img src="<c:url value='/storage/${vo.emp_img}'/>"
												class="card-img-top" alt="...">
											<h5 class="card-title" style="display: inline-block">${vo.emp_name}</h5>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</div>
						<p>과장</p>
						<div style="display: flex; flex-wrap: wrap; gap: 10px;">
							<c:forEach var="vo" items="${vo}">
								<c:if test="${vo.emp_dept eq 'DE002' && vo.emp_pos eq 'PO004'}">
									<div class="card"
										style="flex: 0 1 calc(25% - 10px); box-sizing: border-box; width: 200px; height: 200px;">
										<div class="card-body" style="text-align: center;">
											<img src="<c:url value='/storage/${vo.emp_img}'/>"
												class="card-img-top" alt="...">
											<h5 class="card-title" style="display: inline-block">${vo.emp_name}</h5>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</div>
						<p>대리</p>
						<div style="display: flex; flex-wrap: wrap; gap: 10px;">
							<c:forEach var="vo" items="${vo}">
								<c:if test="${vo.emp_dept eq 'DE002' && vo.emp_pos eq 'PO003'}">
									<div class="card"
										style="flex: 0 1 calc(25% - 10px); box-sizing: border-box; width: 200px; height: 200px;">
										<div class="card-body" style="text-align: center;">
											<img src="<c:url value='/storage/${vo.emp_img}'/>"
												class="card-img-top" alt="...">
											<h5 class="card-title" style="display: inline-block">${vo.emp_name}</h5>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</div>
						<p>주임</p>
						<div style="display: flex; flex-wrap: wrap; gap: 10px;">
							<c:forEach var="vo" items="${vo}">
								<c:if test="${vo.emp_dept eq 'DE002' && vo.emp_pos eq 'PO002'}">
									<div class="card"
										style="flex: 0 1 calc(25% - 10px); box-sizing: border-box; width: 200px; height: 200px;">
										<div class="card-body" style="text-align: center;">
											<img src="<c:url value='/storage/${vo.emp_img}'/>"
												class="card-img-top" alt="...">
											<h5 class="card-title" style="display: inline-block">${vo.emp_name}</h5>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</div>
						<p>사원</p>
						<div style="display: flex; flex-wrap: wrap; gap: 10px;">
							<c:forEach var="vo" items="${vo}">
								<c:if test="${vo.emp_dept eq 'DE002' && vo.emp_pos eq 'PO001'}">
									<div class="card"
										style="flex: 0 1 calc(25% - 10px); box-sizing: border-box; width: 200px; height: 200px;">
										<div class="card-body" style="text-align: center;">
											<img src="<c:url value='/storage/${vo.emp_img}'/>"
												class="card-img-top" alt="...">
											<h5 class="card-title" style="display: inline-block">${vo.emp_name}</h5>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</div>
					</div>
					<div class="tab-pane fade" id="de003" role="tabpanel">
						<p>부장</p>
						<div style="display: flex; flex-wrap: wrap; gap: 10px;">
							<c:forEach var="vo" items="${vo}">
								<c:if test="${vo.emp_dept eq 'DE003' && vo.emp_pos eq 'PO006'}">
									<div class="card"
										style="flex: 0 1 calc(25% - 10px); box-sizing: border-box; width: 200px; height: 200px;">
										<div class="card-body" style="text-align: center;">
											<img src="<c:url value='/storage/${vo.emp_img}'/>"
												class="card-img-top" alt="...">
											<h5 class="card-title" style="display: inline-block">${vo.emp_name}</h5>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</div>
						<p>차장</p>
						<div style="display: flex; flex-wrap: wrap; gap: 10px;">
							<c:forEach var="vo" items="${vo}">
								<c:if test="${vo.emp_dept eq 'DE003' && vo.emp_pos eq 'PO005'}">
									<div class="card"
										style="flex: 0 1 calc(25% - 10px); box-sizing: border-box; width: 200px; height: 200px;">
										<div class="card-body" style="text-align: center;">
											<img src="<c:url value='/storage/${vo.emp_img}'/>"
												class="card-img-top" alt="...">
											<h5 class="card-title" style="display: inline-block">${vo.emp_name}</h5>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</div>
						<p>과장</p>
						<div style="display: flex; flex-wrap: wrap; gap: 10px;">
							<c:forEach var="vo" items="${vo}">
								<c:if test="${vo.emp_dept eq 'DE003' && vo.emp_pos eq 'PO004'}">
									<div class="card"
										style="flex: 0 1 calc(25% - 10px); box-sizing: border-box; width: 200px; height: 200px;">
										<div class="card-body" style="text-align: center;">
											<img src="<c:url value='/storage/${vo.emp_img}'/>"
												class="card-img-top" alt="...">
											<h5 class="card-title" style="display: inline-block">${vo.emp_name}</h5>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</div>
						<p>대리</p>
						<div style="display: flex; flex-wrap: wrap; gap: 10px;">
							<c:forEach var="vo" items="${vo}">
								<c:if test="${vo.emp_dept eq 'DE003' && vo.emp_pos eq 'PO003'}">
									<div class="card"
										style="flex: 0 1 calc(25% - 10px); box-sizing: border-box; width: 200px; height: 200px;">
										<div class="card-body" style="text-align: center;">
											<img src="<c:url value='/storage/${vo.emp_img}'/>"
												class="card-img-top" alt="...">
											<h5 class="card-title" style="display: inline-block">${vo.emp_name}</h5>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</div>
						<p>주임</p>
						<div style="display: flex; flex-wrap: wrap; gap: 10px;">
							<c:forEach var="vo" items="${vo}">
								<c:if test="${vo.emp_dept eq 'DE003' && vo.emp_pos eq 'PO002'}">
									<div class="card"
										style="flex: 0 1 calc(25% - 10px); box-sizing: border-box; width: 200px; height: 200px;">
										<div class="card-body" style="text-align: center;">
											<img src="<c:url value='/storage/${vo.emp_img}'/>"
												class="card-img-top" alt="...">
											<h5 class="card-title" style="display: inline-block">${vo.emp_name}</h5>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</div>
						<p>사원</p>
						<div style="display: flex; flex-wrap: wrap; gap: 10px;">
							<c:forEach var="vo" items="${vo}">
								<c:if test="${vo.emp_dept eq 'DE003' && vo.emp_pos eq 'PO001'}">
									<div class="card"
										style="flex: 0 1 calc(25% - 10px); box-sizing: border-box; width: 200px; height: 200px;">
										<div class="card-body" style="text-align: center;">
											<img src="<c:url value='/storage/${vo.emp_img}'/>"
												class="card-img-top" alt="...">
											<h5 class="card-title" style="display: inline-block">${vo.emp_name}</h5>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</div>
					</div>
					<div class="tab-pane fade" id="de004" role="tabpanel"
						aria-labelledby="contact-tab">
						<p>부장</p>
						<div style="display: flex; flex-wrap: wrap; gap: 10px;">
							<c:forEach var="vo" items="${vo}">
								<c:if test="${vo.emp_dept eq 'DE004' && vo.emp_pos eq 'PO006'}">
									<div class="card"
										style="flex: 0 1 calc(25% - 10px); box-sizing: border-box; width: 200px; height: 200px;">
										<div class="card-body" style="text-align: center;">
											<img src="<c:url value='/storage/${vo.emp_img}'/>"
												class="card-img-top" alt="...">
											<h5 class="card-title" style="display: inline-block">${vo.emp_name}</h5>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</div>
						<p>차장</p>
						<div style="display: flex; flex-wrap: wrap; gap: 10px;">
							<c:forEach var="vo" items="${vo}">
								<c:if test="${vo.emp_dept eq 'DE004' && vo.emp_pos eq 'PO005'}">
									<div class="card"
										style="flex: 0 1 calc(25% - 10px); box-sizing: border-box; width: 200px; height: 200px;">
										<div class="card-body" style="text-align: center;">
											<img src="<c:url value='/storage/${vo.emp_img}'/>"
												class="card-img-top" alt="...">
											<h5 class="card-title" style="display: inline-block">${vo.emp_name}</h5>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</div>
						<p>과장</p>
						<div style="display: flex; flex-wrap: wrap; gap: 10px;">
							<c:forEach var="vo" items="${vo}">
								<c:if test="${vo.emp_dept eq 'DE004' && vo.emp_pos eq 'PO004'}">
									<div class="card"
										style="flex: 0 1 calc(25% - 10px); box-sizing: border-box; width: 200px; height: 200px;">
										<div class="card-body" style="text-align: center;">
											<img src="<c:url value='/storage/${vo.emp_img}'/>"
												class="card-img-top" alt="...">
											<h5 class="card-title" style="display: inline-block">${vo.emp_name}</h5>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</div>
						<p>대리</p>
						<div style="display: flex; flex-wrap: wrap; gap: 10px;">
							<c:forEach var="vo" items="${vo}">
								<c:if test="${vo.emp_dept eq 'DE004' && vo.emp_pos eq 'PO003'}">
									<div class="card"
										style="flex: 0 1 calc(25% - 10px); box-sizing: border-box; width: 200px; height: 200px;">
										<div class="card-body" style="text-align: center;">
											<img src="<c:url value='/storage/${vo.emp_img}'/>"
												class="card-img-top" alt="...">
											<h5 class="card-title" style="display: inline-block">${vo.emp_name}</h5>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</div>
						<p>주임</p>
						<div style="display: flex; flex-wrap: wrap; gap: 10px;">
							<c:forEach var="vo" items="${vo}">
								<c:if test="${vo.emp_dept eq 'DE004' && vo.emp_pos eq 'PO002'}">
									<div class="card"
										style="flex: 0 1 calc(25% - 10px); box-sizing: border-box; width: 200px; height: 200px;">
										<div class="card-body" style="text-align: center;">
											<img src="<c:url value='/storage/${vo.emp_img}'/>"
												class="card-img-top" alt="...">
											<h5 class="card-title" style="display: inline-block">${vo.emp_name}</h5>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</div>
						<p>사원</p>
						<div style="display: flex; flex-wrap: wrap; gap: 10px;">
							<c:forEach var="vo" items="${vo}">
								<c:if test="${vo.emp_dept eq 'DE004' && vo.emp_pos eq 'PO001'}">
									<div class="card"
										style="flex: 0 1 calc(25% - 10px); box-sizing: border-box; width: 200px; height: 200px;">
										<div class="card-body" style="text-align: center;">
											<img src="<c:url value='/storage/${vo.emp_img}'/>"
												class="card-img-top" alt="...">
											<h5 class="card-title" style="display: inline-block">${vo.emp_name}</h5>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</div>
					</div>
					<div class="tab-pane fade" id="de005" role="tabpanel"
						aria-labelledby="contact-tab">
						<p>부장</p>
						<div style="display: flex; flex-wrap: wrap; gap: 10px;">
							<c:forEach var="vo" items="${vo}">
								<c:if test="${vo.emp_dept eq 'DE005' && vo.emp_pos eq 'PO006'}">
									<div class="card"
										style="flex: 0 1 calc(25% - 10px); box-sizing: border-box; width: 200px; height: 200px;">
										<div class="card-body" style="text-align: center;">
											<img src="<c:url value='/storage/${vo.emp_img}'/>"
												class="card-img-top" alt="...">
											<h5 class="card-title" style="display: inline-block">${vo.emp_name}</h5>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</div>
						<p>차장</p>
						<div style="display: flex; flex-wrap: wrap; gap: 10px;">
							<c:forEach var="vo" items="${vo}">
								<c:if test="${vo.emp_dept eq 'DE005' && vo.emp_pos eq 'PO005'}">
									<div class="card"
										style="flex: 0 1 calc(25% - 10px); box-sizing: border-box; width: 200px; height: 200px;">
										<div class="card-body" style="text-align: center;">
											<img src="<c:url value='/storage/${vo.emp_img}'/>"
												class="card-img-top" alt="...">
											<h5 class="card-title" style="display: inline-block">${vo.emp_name}</h5>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</div>
						<p>과장</p>
						<div style="display: flex; flex-wrap: wrap; gap: 10px;">
							<c:forEach var="vo" items="${vo}">
								<c:if test="${vo.emp_dept eq 'DE005' && vo.emp_pos eq 'PO004'}">
									<div class="card"
										style="flex: 0 1 calc(25% - 10px); box-sizing: border-box; width: 200px; height: 200px;">
										<div class="card-body" style="text-align: center;">
											<img src="<c:url value='/storage/${vo.emp_img}'/>"
												class="card-img-top" alt="...">
											<h5 class="card-title" style="display: inline-block">${vo.emp_name}</h5>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</div>
						<p>대리</p>
						<div style="display: flex; flex-wrap: wrap; gap: 10px;">
							<c:forEach var="vo" items="${vo}">
								<c:if test="${vo.emp_dept eq 'DE005' && vo.emp_pos eq 'PO003'}">
									<div class="card"
										style="flex: 0 1 calc(25% - 10px); box-sizing: border-box; width: 200px; height: 200px;">
										<div class="card-body" style="text-align: center;">
											<img src="<c:url value='/storage/${vo.emp_img}'/>"
												class="card-img-top" alt="...">
											<h5 class="card-title" style="display: inline-block">${vo.emp_name}</h5>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</div>
						<p>주임</p>
						<div style="display: flex; flex-wrap: wrap; gap: 10px;">
							<c:forEach var="vo" items="${vo}">
								<c:if test="${vo.emp_dept eq 'DE005' && vo.emp_pos eq 'PO002'}">
									<div class="card"
										style="flex: 0 1 calc(25% - 10px); box-sizing: border-box; width: 200px; height: 200px;">
										<div class="card-body" style="text-align: center;">
											<img src="<c:url value='/storage/${vo.emp_img}'/>"
												class="card-img-top" alt="...">
											<h5 class="card-title" style="display: inline-block">${vo.emp_name}</h5>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</div>
						<p>사원</p>
						<div style="display: flex; flex-wrap: wrap; gap: 10px;">
							<c:forEach var="vo" items="${vo}">
								<c:if test="${vo.emp_dept eq 'DE005' && vo.emp_pos eq 'PO001'}">
									<div class="card"
										style="flex: 0 1 calc(25% - 10px); box-sizing: border-box; width: 200px; height: 200px;">
										<div class="card-body" style="text-align: center;">
											<img src="<c:url value='/storage/${vo.emp_img}'/>"
												class="card-img-top" alt="...">
											<h5 class="card-title" style="display: inline-block">${vo.emp_name}</h5>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</div>
					</div>
					<div class="tab-pane fade" id="de006" role="tabpanel"
						aria-labelledby="contact-tab">
						<p>부장</p>
						<div style="display: flex; flex-wrap: wrap; gap: 10px;">
							<c:forEach var="vo" items="${vo}">
								<c:if test="${vo.emp_dept eq 'DE006' && vo.emp_pos eq 'PO006'}">
									<div class="card"
										style="flex: 0 1 calc(25% - 10px); box-sizing: border-box; width: 200px; height: 200px;">
										<div class="card-body" style="text-align: center;">
											<img src="<c:url value='/storage/${vo.emp_img}'/>"
												class="card-img-top" alt="...">
											<h5 class="card-title" style="display: inline-block">${vo.emp_name}</h5>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</div>
						<p>차장</p>
						<div style="display: flex; flex-wrap: wrap; gap: 10px;">
							<c:forEach var="vo" items="${vo}">
								<c:if test="${vo.emp_dept eq 'DE006' && vo.emp_pos eq 'PO005'}">
									<div class="card"
										style="flex: 0 1 calc(25% - 10px); box-sizing: border-box; width: 200px; height: 200px;">
										<div class="card-body" style="text-align: center;">
											<img src="<c:url value='/storage/${vo.emp_img}'/>"
												class="card-img-top" alt="...">
											<h5 class="card-title" style="display: inline-block">${vo.emp_name}</h5>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</div>
						<p>과장</p>
						<div style="display: flex; flex-wrap: wrap; gap: 10px;">
							<c:forEach var="vo" items="${vo}">
								<c:if test="${vo.emp_dept eq 'DE006' && vo.emp_pos eq 'PO004'}">
									<div class="card"
										style="flex: 0 1 calc(25% - 10px); box-sizing: border-box; width: 200px; height: 200px;">
										<div class="card-body" style="text-align: center;">
											<img src="<c:url value='/storage/${vo.emp_img}'/>"
												class="card-img-top" alt="...">
											<h5 class="card-title" style="display: inline-block">${vo.emp_name}</h5>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</div>
						<p>대리</p>
						<div style="display: flex; flex-wrap: wrap; gap: 10px;">
							<c:forEach var="vo" items="${vo}">
								<c:if test="${vo.emp_dept eq 'DE006' && vo.emp_pos eq 'PO003'}">
									<div class="card"
										style="flex: 0 1 calc(25% - 10px); box-sizing: border-box; width: 200px; height: 200px;">
										<div class="card-body" style="text-align: center;">
											<img src="<c:url value='/storage/${vo.emp_img}'/>"
												class="card-img-top" alt="...">
											<h5 class="card-title" style="display: inline-block">${vo.emp_name}</h5>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</div>
						<p>주임</p>
						<div style="display: flex; flex-wrap: wrap; gap: 10px;">
							<c:forEach var="vo" items="${vo}">
								<c:if test="${vo.emp_dept eq 'DE006' && vo.emp_pos eq 'PO002'}">
									<div class="card"
										style="flex: 0 1 calc(25% - 10px); box-sizing: border-box; width: 200px; height: 200px;">
										<div class="card-body" style="text-align: center;">
											<img src="<c:url value='/storage/${vo.emp_img}'/>"
												class="card-img-top" alt="...">
											<h5 class="card-title" style="display: inline-block">${vo.emp_name}</h5>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</div>
						<p>사원</p>
						<div style="display: flex; flex-wrap: wrap; gap: 10px;">
							<c:forEach var="vo" items="${vo}">
								<c:if test="${vo.emp_dept eq 'DE006' && vo.emp_pos eq 'PO001'}">
									<div class="card"
										style="flex: 0 1 calc(25% - 10px); box-sizing: border-box; width: 200px; height: 200px;">
										<div class="card-body" style="text-align: center;">
											<img src="<c:url value='/storage/${vo.emp_img}'/>"
												class="card-img-top" alt="...">
											<h5 class="card-title" style="display: inline-block">${vo.emp_name}</h5>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</div>
					</div>
				</div>
				<!-- End Default Tabs -->

			</div>
		</div>




	</main>
	<!-- End #main -->


</body>
<%@ include file="../comm/footer.jsp"%>



</html>