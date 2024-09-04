<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html>

<%@ include file="../comm/header.jsp"%>

<body>
	<%@ include file="../comm/sidebar.jsp"%>
	<main id="main" class="main">
		<form action="${mode == 'insert' ? './writeBoard.do' : './modifyBoard.do'}" method="post">
		
		<br>
		<c:choose>
		<c:when test="${mode=='insert'}"><h1>글작성</h1></c:when>
		<c:when test="${mode=='modify'}"><h1>글수정</h1>
		</c:when>
		
		</c:choose>
		<br>
		<table id="BoardTable" class="table table-bordered">
			<tr>
				<td scope="row">게시판</td>
				<td>
					<select name="bo_status">
						<option value="announcements">공지사항</option>
						<option value="nomalBoard">게시판</option>
					</select>
				</td>
				<td>부서</td>
				<td>${loginVo.emp_dept}</td>
			</tr>
			<tr>
				<td scope="row">제목</td>
				<td colspan="3">
				<textarea rows="1" cols="50" name="bo_title" placeholder="제목 입력">${Vo.bo_title}</textarea>
				</td>
			</tr>
			<tr>
				<td scope="row">위젯에 표시</td>
				<td colspan="3">
				<i id="changeTiele" class="bi bi-check2-square" onclick="changeTitle()"></i><!-- ★★★★★★★★★★★★★★★★★★★ -->
				</td>
			</tr>
			<tr>
				<td colspan="4" rowspan="8">
				 <textarea id=txtArea name="bo_content" style="width: 1000px; height: 200px; box-sizing: border-box;" placeholder="내용 입력">${Vo.bo_content}</textarea>
				</td>
			</tr>
		</table>
		<input type="file" name="file">
		<c:choose>
		<c:when test="${mode=='insert'}">
		<button class="btn btn-primary" type="submit">게시</button>
		</c:when>
		<c:when test="${mode=='modify'}">
		<input type="hidden" name="bo_no" value="${Vo.bo_no}" />
		<button class="btn btn-warning" type="submit">수정</button>
		</c:when>
		</c:choose>
		<button class="btn btn-danger" onclick="history.back(-1)">취소</button>
	</form>
	
	
	</main>
	<!-- End #main -->
<div id="contentDisplay"></div>
</body>
<%@ include file="../comm/footer.jsp"%>

<style>
 .bi-check2-square {
            font-size: 24px; /* 아이콘 크기 조정 */
            cursor: pointer; /* 클릭 가능한 커서 */
        }
</style>

<script type="text/javascript">
function sendData() {
    var content = $('#txtArea').val();
    
    $.ajax({
        url: './writeBoard.do',  // 서버의 엔드포인트
        method: 'POST',
        data: { bo_content: content },
        success: function(response) {
            // 서버로부터 받은 데이터에서 줄바꿈을 <br> 태그로 변환
            var formattedContent = response.replace(/\n/g, '<br>');
            $('#contentDisplay').html(formattedContent);
        }
    });
}

function changeTitle() {
	document.getElementById('changeTitle').innerHTML='비공개입니다';
}
</script>

</html>