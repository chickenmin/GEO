<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 결재 창에 jsp:include로 넣을거라 위 아래 태그 정리함  -->


<!-- Basic Modal -->
<div class="modal fade" id="basicModal" tabindex="-1">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title"><b> 결재선 선택</b> </h5>
			</div>
			
			<form action="./return.do" method="post">
				<input type="hidden" name="apd_no" value="${vo.apd_no}">
				<!-- 모달 몸체 -->
				<div class="modal-body" style="height: 300px;">
					<!-- jstree / 선택칸 -->
					<div class="card info-card revenue-card main-card" style="height: 200px; width: 300px;">
					<span class="card-title">반려사유</span>
						<textarea class="form-control"  cols="20" rows="20" name="apl_msg"></textarea>
					</div>
				</div> <!-- 모달 몸체 끝 -->
				<div class="modal-footer">
					<button class="btn btn btn-outline-secondary" data-bs-dismiss="modal" type="button">취소</button>
					<button class="btn btn-outline-info" data-bs-dismiss="modal" >반려 완료</button>
				</div>
			</form>
		</div>
	</div>

</div>
<!-- End Basic Modal-->