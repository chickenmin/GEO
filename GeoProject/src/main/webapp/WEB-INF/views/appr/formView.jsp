<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<%@ include file="../comm/header.jsp"%>
<head>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
<link rel="stylesheet" href="./css/appr_formView.css">
<script type="text/javascript" src="./js/approve.js"></script>
</head>

<body>
	<%@ include file="../comm/sidebar.jsp"%>
	<main id="main" class="main">
		
		<div style="width: 800px;">
			<!-- 시작 -->
			<!-- 결재칸 -->
			<div style="text-align: right;">
				<c:forEach var="signer" items="${apprLists}">
					<div class="sign">
						<div class="sign-name">${signer.emp_name }</div>
						<div class="sign-signature" style="height: 100px;">
							<c:choose>
								<c:when test="${empty signer.file_oname}">
									<span style="text-align: center;">-</span>
								</c:when>
								<c:otherwise>
									<img alt="서명이미지" src="./signature/${signer.file_oname}" style="width: 100px; height: 100px;">
								</c:otherwise>
							</c:choose>
						</div>
						<div class="sign-date">
							<c:choose>
								<c:when test="${empty signer.file_oname}">
									<span style="text-align: center;">-</span>
								</c:when>
								<c:otherwise>
						        	${signer.apl_date}
				        		</c:otherwise>
							</c:choose>
						</div>
					</div>
				</c:forEach>
			</div>
			<!-- right끝 -->


			<br>


			<table class="__se_tbl"
				style="width: 800px; border-collapse: collapse !important; color: black; background: white; border: 1px solid black; font-size: 12px; font-family: malgun gothic, dotum, arial, tahoma;">
				<thead>
					<tr>
						<td
							style="width: 100%; padding: 10px; border: 1px solid black; font-size: 22px; font-weight: bold; text-align: center; vertical-align: middle;"
							colspan="3"><c:choose>
								<c:when test="${vo.apd_form eq 'AP001'}">
				                		일일 업무 일지
				                	</c:when>
								<c:when test="${vo.apd_form eq 'AP002'}">
				                		연차 신청서
				                	</c:when>
								<c:when test="${vo.apd_form eq 'AP003'}">
				                		지출결의서
				                	</c:when>
								<c:when test="${vo.apd_form eq 'AP004'}">
				                		사유서
				                	</c:when>
								<c:otherwise>
				                		출장보고서
				                	</c:otherwise>
							</c:choose></td>
					</tr>
				</thead>
				<tbody>

					<!-- 기안자 -->
					<tr>
						<td
							style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; text-align: center; color: rgb(0, 0, 0); font-size: 14px; font-weight: bold;">
							기안자</td>
						<td
							style="padding: 5px; border: 1px solid black; text-align: center; color: rgb(0, 0, 0); font-size: 14px;"
							colspan="2">${vo.emp_name}</td>
					</tr>

					<!-- 날짜 -->
					<tr>
						<td
							style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; text-align: center; color: rgb(0, 0, 0); font-size: 14px; font-weight: bold;">
							<c:choose>
								<c:when test="${vo.apd_form eq 'AP001'}">
				                		업무일자
				                	</c:when>
								<c:when test="${vo.apd_form eq 'AP002'}">
				                		연차일자
				                	</c:when>
								<c:when test="${vo.apd_form eq 'AP003'}">
				                		발의일자
				                	</c:when>
								<c:when test="${vo.apd_form eq 'AP004'}">
				                		사유일자
				                	</c:when>
								<c:otherwise>
				                		출장일자
				                	</c:otherwise>
							</c:choose>
						</td>
						<td
							style="padding: 5px; border: 1px solid black; text-align: center; color: rgb(0, 0, 0); font-size: 14px;"
							colspan="2">${vo.apd_days}</td>
					</tr>
					<c:if test="${vo.apd_form eq 'AP002'}">
						<td
							style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; text-align: center; color: rgb(0, 0, 0); font-size: 14px; font-weight: bold;">
							반차사용</td>
						<td
							style="padding: 5px; border: 1px solid black; text-align: center; color: rgb(0, 0, 0); font-size: 14px;"
							colspan="2"><c:choose>
								<c:when test="${vo.apd_half_yn eq 'A'}">
				            			오전반차
				            	</c:when>
								<c:when test="${vo.apd_half_yn eq 'P'}">
				            			오후반차
				            	</c:when>
				            	<c:otherwise>
				            		연차
				            	</c:otherwise>
							</c:choose></td>
					</c:if>


					<!-- 사유 -->
					<tr>
						<td
							style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; text-align: center; color: rgb(0, 0, 0); font-size: 14px; font-weight: bold;"
							colspan="3"><b style="color: rgb(255, 0, 0);">*</b>&nbsp; <c:choose>
								<c:when test="${vo.apd_form eq 'AP001'}">
				                		업무내용
				                	</c:when>
								<c:when test="${vo.apd_form eq 'AP002'}">
				                		연차사유
				                	</c:when>
								<c:when test="${vo.apd_form eq 'AP003'}">
				                		지출내용
				                	</c:when>
								<c:when test="${vo.apd_form eq 'AP004'}">
				                		사유
				                	</c:when>
								<c:otherwise>
				                		출장보고
				                	</c:otherwise>
							</c:choose></td>
					</tr>
					<tr>
						<td colspan="3"
							style="padding: 5px; border: 1px solid black; height: 300px; text-align: left; color: rgb(0, 0, 0); font-size: 12px; vertical-align: top; background: rgb(255, 255, 255);">
							${vo.apd_con }</td>
					</tr>


					<!-- 파일 -->
					<c:if
						test="${vo.apd_form eq 'AP003' or vo.apd_form eq 'AP004' or vo.apd_form eq 'AP005'}">
						<tr>
							<td colspan="3"
								style="padding: 5px; border: 1px solid black; height: 100px; text-align: left; color: rgb(0, 0, 0); font-size: 12px; vertical-align: top; background: rgb(255, 255, 255);">
								<c:choose>
									<c:when test="${file == null}">
								  				첨부파일 없음
								  			</c:when>
									<c:otherwise>
										<c:forEach var="f" items="${file}">
											<form action="./apprFile.do" method="post">
												${f.file_oname} &nbsp&nbsp 
												<input type="hidden" name="file_no" value="${f.file_no}">
												<button type="submit">다운로드</button>
											</form>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</c:if>

				</tbody>
			</table>
			
			<c:if test="${apl_msg != null}">
				<br>
				<div class="container">
					<div>반려메시지</div>
					<textarea class="form-control" style="width: 800px;">${apl_msg }</textarea>
				</div>
			</c:if>

			<!--반려  -->
			<jsp:include page="./returnModal.jsp"></jsp:include>
			<!--승인하기  -->
			<jsp:include page="./signModal.jsp"></jsp:include>
	
			<c:if test="${variety eq 'appr'}">
				<c:choose>
					<c:when test="${order == 1}">
						<!-- 문서 하단 버튼 -->
						<div style="display: flex; justify-content: flex-end;">
							<button type="button" class="btn btn-outline-primary "
								data-bs-toggle="modal"
								style="height: auto; margin: 5px 10px 0 0;"
								data-bs-target="#basicModal">반려하기</button>
	
							<button class="btn btn-primary frmbtn"
								style="height: auto; margin: 5px 10px 0 0;"
								data-bs-target="#sign" data-bs-toggle="modal">결재하기</button>
						</div>
					</c:when>
				</c:choose>
			</c:if>
			<c:if test="${variety eq 'submit' && vo.apd_status eq 'W'}">
				<button type="button" class="btn btn-outline-danger category" onclick="location.href=`./cancel.do?apd_no=${vo.apd_no}`">철회</button>
			</c:if>
		</div>
		
		<!-- 끝 -->
	</main>
	<!-- End #main -->


</body>
<%@ include file="../comm/footer.jsp"%>

<script type="text/javascript">
	
</script>

</html>