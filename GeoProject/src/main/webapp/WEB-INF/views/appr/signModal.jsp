<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!-- 결재 창에 jsp:include로 넣을거라 위 아래 태그 정리함  -->


<!-- Basic Modal -->
<div class="modal fade" id="sign" tabindex="-1">
	<div class="modal-dialog">
		<div class="modal-content">
			<form action="./approve.do" method="post">
				<div class="modal-header">
					<h5 class="modal-title"><b>결재선 선택</b> </h5>
				</div>
				
					<input type="hidden" name="apd_no" value="${vo.apd_no}">
					<!-- 모달 몸체 -->
					<div class="modal-body" style="height: 300px;">
						<c:choose>
				      	<c:when test="${fn:length(mySign) != 0}">
				      		<div style="display: flex; justify-content: space-evenly;">
					      		<c:forEach var="sign" items="${mySign}" varStatus="vs"> 
							       <div class="card info-card revenue-card" style="margin: 5px;">
									    <h5 class="card-title">전자서명 ${vs.index+1 }</h5>
									    <div class="position-relative">
									        <!-- 이미지 -->
									        <img alt="전자서명" src="./signature/${sign.file_oname }" style="height: 200px; width: 200px;">
									        <!-- 체크박스 -->
									        <input type="radio" name="file_oname" value="${sign.file_oname}" 
									               class="position-absolute" style="top: 10px; left: 10px;">
									    </div>
									</div>
							       
					      		</c:forEach>
					      	</div>
				      	</c:when>
				      	<c:otherwise>
				      		<div class="card">
				      			<div class="card-body" style="text-align: center;"><br><h4>등록된 서명이 없습니다.</h4></div>
				      			<button onclick="location.href='/signHome.do'">서명 만들기</button>
							</div>
				      	</c:otherwise>
				      </c:choose>
					</div> <!-- 모달 몸체 끝 -->
					<div class="modal-footer">
						<button class="btn btn btn-outline-secondary" data-bs-dismiss="modal" type="button">취소</button>
						<button class="btn btn-outline-info" data-bs-dismiss="modal" >승인</button>
					</div>
				
				</form>
		</div>
	</div>
</div>
<!-- End Basic Modal-->