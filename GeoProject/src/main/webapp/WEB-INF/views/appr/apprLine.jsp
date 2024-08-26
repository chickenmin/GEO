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
			
			<!-- 모달 몸체 -->
			<div class="modal-body"
				style="display: flex; justify-content: space-evenly;">
				
				<!-- jstree / 선택칸 -->
				<div class="card info-card revenue-card main-card">
					<div>결재라인</div>
					<div id="tree"></div>
					<div style="display: flex; justify-content: space-between; margin-top: 10px;">
						<input type="text" id="schName" value="" style="flex: 1; margin-right: 10px; width: 80px;">
						<button onclick="fSch()" style="flex-shrink: 0;" type="button">탐색</button>
					</div>
				</div>
				<div class="choices-container">
					<div class="choice card info-card revenue-card">
						<span>결재자</span>
						<div id="appr" style="flex: 1; margin-top: 10px;"></div>
						<input id="apprCho" name="apprLine" type="hidden">
					</div>
					<div class="choice card info-card revenue-card">
						<span>참조자</span>
						<div id="cc" style="flex: 1; margin-top: 10px;"></div>
						<input id="ccCho" name="ccLine" type="hidden">
					</div>
					
					    <button id="apC" type="button" onclick="choice(event)">결재선택</button>
					    <button id="apR" type="button" onclick="choice(event)">결재취소</button>
					    <button id="reC"  type="button" onclick="choice(event)">참조선택</button>
					    <button  id="reR" type="button" onclick="choice(event)">참조취소</button>
					
				</div>
			
			</div> <!-- 모달 몸체 끝 -->
			
			
			<div class="modal-footer">
				<button type="button" class="btn btn-primary"
					data-bs-dismiss="modal" >선택완료
				</button>
			</div>
		</div>
	</div>

</div>
<!-- End Basic Modal-->