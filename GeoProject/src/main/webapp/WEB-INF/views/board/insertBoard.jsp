<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html>

<%@ include file="../comm/header.jsp"%>

<body>
	<%@ include file="../comm/sidebar.jsp"%>
	<main id="main" class="main">
		<form action="${mode == 'insert' ? './writeBoard.do' : './modifyBoard.do'}" method="post" enctype="multipart/form-data">
		
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
					<c:if test="${loginVo.emp_auth=='AU002'}">
						<option value="announcements">공지사항</option>
					</c:if>
						<option value="nomalBoard">일반게시판</option>
					</select>
				</td>
				<td>부서</td>
				<td>
					<c:choose>
						<c:when test="${loginVo.emp_dept eq 'DE001'}">개발</c:when>
						<c:when test="${loginVo.emp_dept eq 'DE002'}">인사</c:when>
						<c:when test="${loginVo.emp_dept eq 'DE003'}">생산</c:when>
						<c:when test="${loginVo.emp_dept eq 'DE004'}">총무</c:when>
						<c:when test="${loginVo.emp_dept eq 'DE005'}">영업</c:when>
						<c:when test="${loginVo.emp_dept eq 'DE006'}">마케팅</c:when>
					</c:choose>
				</td>
			</tr>
			<tr>
				<td scope="row">제목</td>
				<td colspan="3">
				<textarea style="width: 100%; height: 30px;" name="bo_title" placeholder="제목 입력">${Vo.bo_title}</textarea>
				</td>
			</tr>
			<tr>
				<td colspan="4" rowspan="8">
				 <textarea name="bo_content" style="width: 100%; height: 450px; box-sizing: border-box;" placeholder="내용 입력">${Vo.bo_content}</textarea>
				</td>
			</tr>
		</table>
		 <input class="form-control" type="file" name="file" id="reviewImageFileInput" multiple /><!-- ★★★★★★★★★★★파일첨부★★★★★★★★★★★★ -->
		<c:choose>
		<c:when test="${mode=='insert'}">
		<button class="btn btn-primary" type="submit" onclick="submitForm(event)">게시</button>
		</c:when>
		<c:when test="${mode=='modify'}">
		<input type="hidden" name="bo_no" value="${Vo.bo_no}" />
		<button class="btn btn-warning" type="submit" onclick="submitForm(event)">수정</button>
		</c:when>
		</c:choose>
		<button class="btn btn-danger" type="button" onclick="confirmAndGoBack()">취소</button>
	</form>
	
	
	</main>
	<!-- End #main -->
</body>
<%@ include file="../comm/footer.jsp"%>


<script type="text/javascript">
if (document.getElementById('reviewImgFileInput')) {
    console.log("reviewImgFileInput 요소가 존재합니다.");
     document.getElementById("reviewImgFileInput").onchange = function(){
  			console.log("파일 업로드 버튼 실행");
  			var imgFile = this.value.toLowerCase();
  			var fileForm = /(.*?)\.(jpg|jpeg|bmp|png|gif|pdf|doc|docx|hwp|xls|xlsx)$/i;
  			var maxSize = 5*1024*1024;
  			var fileSize = document.getElementById("reviewImgFileInput").files[0].size;

  			console.log(imgFile, fileForm,maxSize, fileSize);

  			var checkImgTest = fileForm.test(imgFile);	//true/false
  			var checkImgMath = imgFile.match(fileForm)	//객체 혹은 null

  			if(checkImgMath){
  				console.log("if 객체가 있으면 true이기 때문에");
  			}

  			if(!checkImgTest){ 	//정규화가 맞다면 true, 아니라면 false
  				alert("가능한 파일 형식이 아닙니다.");
  				this.value = "";
  				return;
  			}
  			if(maxSize < fileSize){
  				alert("이미지 파일은 5MB만 이하만 가능합니다.");
  				return;
  			}

  		} // 파일 입력
} else {
    console.log("reviewImgFileInput 요소가 존재하지 않습니다.");
}

function confirmAndGoBack() {
    var userConfirmed = confirm("정말로 취소하시겠습니까?");
    if (userConfirmed) {
        window.history.back();
    }
}

function submitForm(event){
	 var Confirmed = confirm("완료하시겠습니까?");
   if (!Confirmed) {
       event.preventDefault();
   }
}
</script>

</html>