<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.nike.geo.vo.hr.EmpVo"%>
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
		<script
			src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		<script>
			function openPostcode() {
				new daum.Postcode(
						{
							oncomplete : function(data) {
								// 팝업에서 검색결과 항목을 클릭했을 때 실행할 코드입니다.
								var addr = ''; // 주소 변수
								var extraAddr = ''; // 참고항목 변수

								// 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
								if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
									addr = data.roadAddress;
								} else { // 사용자가 지번 주소를 선택했을 경우
									addr = data.jibunAddress;
								}

								// 사용자가 선택한 주소가 도로명 타입일 때 참고항목을 조합한다.
								if (data.userSelectedType === 'R') {
									// 법정동명이 있을 경우 추가한다.
									if (data.bname !== ''
											&& /[동|로|가]$/g.test(data.bname)) {
										extraAddr += data.bname;
									}
									// 건물명이 있고, 공동주택일 경우 추가한다.
									if (data.buildingName !== ''
											&& data.apartment === 'Y') {
										extraAddr += (extraAddr !== '' ? ', '
												+ data.buildingName
												: data.buildingName);
									}
									// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
									if (extraAddr !== '') {
										extraAddr = ' (' + extraAddr + ')';
									}
									// 조합된 참고항목을 해당 필드에 넣는다.
									document
											.getElementById("sample6_extraAddress").value = extraAddr;

								} else {
									document
											.getElementById("sample6_extraAddress").value = '';
								}

								// 우편번호와 주소 정보를 해당 필드에 넣는다.
								document.getElementById('sample6_postcode').value = data.zonecode;
								document.getElementById("sample6_address").value = addr;
								// 커서를 상세주소 필드로 이동한다.
								document
										.getElementById("sample6_detailAddress")
										.focus();

							}

						}).open();
				fullAddress();

// 			}
// 			function fullAddress() {
// 				let addr01 = document.getElementById("sample6_address").value;
// 				let addr02 = document.getElementById("sample6_detailAddress").value;
// 				let addr03 = document.getElementById("sample6_extraAddress").value;
// 				document.getElementById("emp_address").value = addr01 + addr02
// 						+ addr03;
				// 		return false;

			}
		</script>

		<div
			class="card-body profile-card pt-4 d-flex flex-column align-items-center">
			<img src="<c:url value='/storage/${vo.emp_img}'/>" alt="Profile"
				class="rounded-circle" style="width: 200px; height: 200px;">
<%-- 				<input type="text" name="saveFileName" value="${saveFileName}" readonly="readonly"> --%>
				<input type="hidden" name="emp_no">
			<h2>${vo.emp_name}</h2>
			<h3>
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

			</h3>

			<h3>
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
			</h3>

		</div>

		<div class="card-body pt-30">
			<!-- Bordered Tabs -->
			<ul class="nav nav-tabs nav-tabs-bordered" role="tablist">

				<li class="nav-item" role="presentation">
					<button class="nav-link active" data-bs-toggle="tab"
						data-bs-target="#profile-overview" aria-selected="true" role="tab">사원
						정보</button>
				</li>

				<li class="nav-item" role="presentation">
					<button class="nav-link" data-bs-toggle="tab"
						data-bs-target="#profile-edit" aria-selected="false" tabindex="-1"
						role="tab">정보 수정</button>
				</li>
				
				<c:if test="${loginVo.emp_auth eq 'AU002'}">
					<li class="nav-item" role="presentation">
						<button class="nav-link" data-bs-toggle="tab"
							data-bs-target="#profile-change-password" aria-selected="false"
							tabindex="-1" role="tab">비밀번호 초기화</button>
					</li>
				</c:if>
				<c:if test="${loginVo.emp_auth eq 'AU002'}">
					<li class="nav-item" role="presentation">
						<button class="nav-link" data-bs-toggle="tab"
							data-bs-target="#profile-att" aria-selected="false"
							tabindex="-1" role="tab">근태 조회</button>
					</li>
				</c:if>
				<c:if test="${loginVo.emp_auth eq 'AU002'}">
					<li class="nav-item" role="presentation">
						<button class="nav-link" data-bs-toggle="tab"
							data-bs-target="#profile-vaca" aria-selected="false"
							tabindex="-1" role="tab">사원 연차 조회</button>
					</li>
				</c:if>
				<c:if test="${loginVo.emp_auth eq 'AU002'}">
					<li class="nav-item" role="presentation">
						<button class="nav-link" data-bs-toggle="tab"
							data-bs-target="#profile-entire" aria-selected="false"
							tabindex="-1" role="tab">퇴사 처리</button>
					</li>
				</c:if>

			</ul>

			<div class="tab-content pt-30">

				<div class="tab-pane fade show active profile-overview"
					id="profile-overview" role="tabpanel" >
					

					<h5 class="card-title">Profile</h5>

					<div class="row" style="margin-bottom: 10px;">
						<div class="col-lg-3 col-md-4 label ">이름</div>
						<div class="col-lg-9 col-md-8">${vo.emp_name}</div>
					</div>

					<div class="row" style="margin-bottom: 10px;">
						<div class="col-lg-3 col-md-4 label">부서</div>
						<div class="col-lg-9 col-md-8">
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
						</div>
					</div>

					<div class="row" style="margin-bottom: 10px;">
						<div class="col-lg-3 col-md-4 label">직급</div>
						<div class="col-lg-9 col-md-8">
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
						</div>
					</div>

					<div class="row" style="margin-bottom: 10px;">
						<div class="col-lg-3 col-md-4 label">성별</div>
						<div class="col-lg-9 col-md-8">${vo.emp_gender}</div>
					</div>

					<div class="row" style="margin-bottom: 10px;">
						<div class="col-lg-3 col-md-4 label">생년월일</div>
						<div class="col-lg-9 col-md-8">
							<fmt:parseDate var="cDate01" value="${vo.emp_birth}" type="date"
								pattern="yyyy-MM-dd" />
							<fmt:formatDate var="emp_birth02" value="${cDate01}" />
							${emp_birth02}
						</div>
					</div>

					<div class="row" style="margin-bottom: 10px;">
						<div class="col-lg-3 col-md-4 label">연락처</div>
						<div class="col-lg-9 col-md-8">${vo.emp_phone}</div>
					</div>

					<div class="row" style="margin-bottom: 10px;">
						<div class="col-lg-3 col-md-4 label">Email</div>
						<div class="col-lg-9 col-md-8">${vo.emp_email}</div>
					</div>

					<div class="row" style="margin-bottom: 10px;">
						<div class="col-lg-3 col-md-4 label">주소</div>
						<div class="col-lg-9 col-md-8">${vo.emp_address1} ${vo.emp_address2} ${vo.emp_address3}</div>
					</div>

					<div class="row" style="margin-bottom: 10px;">
						<div class="col-lg-3 col-md-4 label">입사일자</div>
						<div class="col-lg-9 col-md-8">
							<fmt:parseDate var="cDate02" value="${vo.emp_hiredate}"
								type="date" pattern="yyyy-MM-dd" />
							<fmt:formatDate var="emp_hiredate02" value="${cDate02}" />
							${emp_hiredate02}
						</div>
					</div>

				</div>

				<div class="tab-pane fade profile-edit pt-3" id="profile-edit"
					role="tabpanel">

					<!-- Profile Edit Form -->
					<form action="./updateEmp.do" method="post">
						<input type="hidden" name="emp_no" value="${vo.emp_no}">
						<div class="row mb-3">
							<label for="profileImage"
								class="col-md-4 col-lg-3 col-form-label"></label>
							<div class="col-md-8 col-lg-9" style="display: none;">
								<img src="assets/img/profile-img.jpg" alt="Profile">
								<div class="pt-2">
									<a href="#" class="btn btn-primary btn-sm"
										title="Upload new profile image"><i class="bi bi-upload"></i></a>
									<a href="#" class="btn btn-danger btn-sm"
										title="Remove my profile image"><i class="bi bi-trash"></i></a>
								</div>
							</div>
						</div>


						<div class="row mb-3">
							<label for="name" class="col-md-4 col-lg-3 col-form-label">이름</label>
							<div class="col-md-8 col-lg-9">
								<input name="emp_name" type="text" class="form-control"
									id="name" value="${vo.emp_name}" readonly="readonly"
									style="background-color: silver;">
							</div>
						</div>



						<div class="row mb-3">
							<label for="dept" class="col-md-4 col-lg-3 col-form-label">부서</label>
							<div class="col-md-8 col-lg-9">
								<select class="form-select" aria-label="Default select example"
									name="emp_dept">
									<option value="DE001">개발</option>
									<option value="DE002">인사</option>
									<option value="DE003">생산</option>
									<option value="DE004">총무</option>
									<option value="DE005">영업</option>
									<option value="DE006">마케팅</option>
								</select>
							</div>
						</div>

						<div class="row mb-3">
							<label for="pos" class="col-md-4 col-lg-3 col-form-label">직급</label>
							<div class="col-md-8 col-lg-9">
								<select class="form-select" aria-label="Default select example"
									name="emp_pos">
									<option value="PO001">사원</option>
									<option value="PO002">주임</option>
									<option value="PO003">대리</option>
									<option value="PO004">과장</option>
									<option value="PO005">차장</option>
									<option value="PO006">부장</option>
								</select>
							</div>
						</div>

						<div class="row mb-3">
							<label for="gender" class="col-md-4 col-lg-3 col-form-label">성별</label>
							<div class="col-md-8 col-lg-9">
								<input name="emp_gender" type="text" class="form-control"
									value="남" readonly="readonly" style="background-color: silver;">
							</div>
						</div>

						<div class="row mb-3">
							<label for="birth" class="col-md-4 col-lg-3 col-form-label">생년월일</label>
							<div class="col-md-8 col-lg-9">
								<fmt:parseDate var="cDate" value="${vo.emp_birth}"
									pattern="yyyy-MM-dd" />
								<fmt:formatDate var="emp_birth01" value="${cDate}" />
								<input name="emp_birth" type="text" class="form-control"
									value="${emp_birth01}" readonly="readonly"
									style="background-color: silver;">
							</div>
						</div>

						<div class="row mb-3">
							<label for="phone" class="col-md-4 col-lg-3 col-form-label">연락처</label>
							<div class="col-md-8 col-lg-9">
								<input name="emp_phone" type="text" class="form-control"
									value="${vo.emp_phone}">
							</div>
						</div>

						<div class="row mb-3">
							<label for="email" class="col-md-4 col-lg-3 col-form-label">Email</label>
							<div class="col-md-8 col-lg-9">
								<input name="emp_email" type="text" class="form-control"
									id="email" value="${vo.emp_email}">
							</div>
						</div>

						<div class="row mb-3">
							<label for="address" class="col-md-4 col-lg-3 col-form-label">주소</label>
							<div class="col-md-8 col-lg-9">
								<!-- 								<input name="emp_address" type="text" class="form-control" id="address" -->
								<%-- 									value="${vo.emp_address}"> --%>
								<div class="col-sm-10">
									<div class="input-group mb-3" style="width: 25%;">
										<input type="text" class="form-control" id="sample6_postcode"
											value="${vo.emp_postcode}" name="emp_postcode" placeholder="우편번호" readonly="readonly">

									</div>
									<div>
										<button type="button" class="btn btn-primary"
											onclick="openPostcode()">우편번호 찾기</button>
									</div>
									<br> <input type="text" class="form-control"
										id="sample6_address" placeholder="주소" readonly="readonly"
										style="width: 80%; margin-bottom: 10px;" value="${vo.emp_address1}" name="emp_address1"> <input
										type="text" class="form-control" id="sample6_detailAddress"
										placeholder="상세주소" style="margin-bottom: 10px;" value="${vo.emp_address2}" name="emp_address2"> <input
										type="text" class="form-control" id="sample6_extraAddress"
										placeholder="참고항목" readonly="readonly" style="width: 80%;" value="${vo.emp_address3}" name="emp_address3">
								</div>
							</div>
						</div>

						<div class="row mb-3">
							<label for="hiredate" class="col-md-4 col-lg-3 col-form-label">입사일자</label>
							<div class="col-md-8 col-lg-9">
								<fmt:parseDate var="cDate" value="${vo.emp_hiredate}"
									pattern="yyyy-MM-dd" />
								<fmt:formatDate var="emp_hireDate01" value="${cDate}" />
								<input name="emp_hiredate" type="text" class="form-control"
									id="hiredate" value="${emp_hireDate01}" readonly="readonly"
									style="background-color: silver;">
							</div>
						</div>



						<div class="text-center">
							<button type="submit" class="btn btn-primary">정보 수정</button>
						</div>
					</form>
					<!-- End Profile Edit Form -->

				</div>


				<div class="tab-pane fade pt-3" id="profile-change-password"
					role="tabpanel">
					<form action="./clearPw.do" method="post">
						<div class="text-center">
							<input type="hidden" name="emp_no" value="${vo.emp_no}">
							<button type="submit" class="btn btn-primary">비밀번호 초기화</button>
						</div>
					</form>
				</div>
				<div class="tab-pane fade pt-3" id="profile-att"
					role="tabpanel">
					<div>
					<h3 class="card-title">사원 근태</h3>
					</div>
					<div class="row" style="margin-bottom: 10px;">
						<div class="col-lg-3 col-md-4 label">출근</div>
						<div class="col-lg-9 col-md-8" id="right_count">
							<c:out value="${attVo.right_count}" />
						</div>
					</div>
					<div class="row" style="margin-bottom: 10px;">
						<div class="col-lg-3 col-md-4 label">조퇴</div>
						<div class="col-lg-9 col-md-8" id="early_count">
							<c:out value="${attVo.early_count}" />
						</div>
					</div>
					<div class="row" style="margin-bottom: 10px;">
						<div class="col-lg-3 col-md-4 label">지각</div>
						<div class="col-lg-9 col-md-8" id="late_count">
							<c:out value="${attVo.late_count}" />
						</div>
					</div>
					<div class="row" style="margin-bottom: 10px;">
						<div class="col-lg-3 col-md-4 label">결근</div>
						<div class="col-lg-9 col-md-8" id="empty_count">
							<c:out value="${attVo.empty_count}" />
						</div>
					</div>
				</div>
				<div class="tab-pane fade pt-3" id="profile-vaca"
					role="tabpanel">
						<div>
					<h3 class="card-title">사원 연차 정보</h3>
					</div>
							<input type="hidden" name="emp_no" value="${vo.emp_no}">
							<div class="row" style="margin-bottom: 10px;">
						<div class="col-lg-3 col-md-4 label">올해 남은 연차</div>
						<div class="col-lg-9 col-md-8" id="right_count">
							<c:forEach var="item" items="${usedDate}" varStatus="status">
								<c:if test="${item.va_use_date != null}">
									<c:out value="${item.va_use_date}" />
									<c:if test="${!status.last}">
           								 ,
        							</c:if>
								</c:if>
							</c:forEach>
						</div>
					</div>
					<div class="row" style="margin-bottom: 10px;">
						<div class="col-lg-3 col-md-4 label">반차 사용 날짜</div>
						<div class="col-lg-9 col-md-8" id="early_count">
							<c:forEach var="item" items="${usedHalf}" varStatus="status">
								<c:if test="${item.va_use_date != null}">
									<c:out value="${item.va_use_date}" />
									<c:if test="${!status.last}">
           								 ,
        							</c:if>
								</c:if>
							</c:forEach>
						</div>
					</div>
					<div class="row" style="margin-bottom: 10px;">
						<div class="col-lg-3 col-md-4 label">올해 연차 사용 횟수</div>
						<div class="col-lg-9 col-md-8" id="late_count">
							${usedNum.va_use_day}
						</div>
					</div>
					<div class="row" style="margin-bottom: 10px;">
						<div class="col-lg-3 col-md-4 label">올해 반차 사용 횟수</div>
						<div class="col-lg-9 col-md-8" id="empty_count">
							${usedHalfNum.va_use_half}
						</div>
						</div>
				</div>
				<div class="tab-pane fade pt-3" id="profile-entire"
					role="tabpanel">
					<form action="./retireEmp.do" method="post">
						<div class="text-center">
							<input type="hidden" name="emp_no" value="${vo.emp_no}">
							<button type="submit" class="btn btn-primary">퇴사 처리</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</main>
	<!-- End #main -->

	<%@ include file="../comm/footer.jsp"%>

</body>

</html>
