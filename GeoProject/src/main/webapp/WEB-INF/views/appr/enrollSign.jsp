<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 결재 창에 jsp:include로 넣을거라 위 아래 태그 정리함  -->


<!-- Basic Modal -->
<div class="modal fade" id="enroll" tabindex="-1">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title"><b>결재선 선택</b> </h5>
			</div>
			
			<form action="./signDraw.do" method="post" enctype="multipart/form-data" id="signForm">
				<input type="hidden" name="apd_no" value="${vo.apd_no}">
				<input type="hidden" name="signatureImage" id="signatureImageInput">
				<!-- 모달 몸체 -->
				<div class="modal-body" style="height: 300px; width: 600px;">
						<div class="pad">
							<h1>서명 패드</h1>
						    <canvas id="signature-pad" width="500" height="200"></canvas>
						</div>
				</div> <!-- 모달 몸체 끝 -->
				<div class="modal-footer">
			        <button type="button" class="btn btn-outline-danger" id="clear">초기화</button>
					<button class="btn btn btn-outline-secondary" data-bs-dismiss="modal" type="button">취소</button>
					<button class="btn btn-outline-info frm" data-bs-dismiss="modal" id="submitSign">생성</button>
				</div>
			</form>
		</div>
	</div>
</div>
<!-- End Basic Modal-->