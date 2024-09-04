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
					<c:if test="${loginVo.emp_name == '관리자'}">
						<option value="announcements">공지사항</option>
					</c:if>
						<option value="nomalBoard">일반게시판</option>
					</select>
				</td>
				<td>부서</td>
				<td>${loginVo.emp_dept}</td>
			</tr>
			<tr>
				<td scope="row">제목</td>
				<td colspan="3">
				<textarea style="width: 100%; height: 30px;" name="bo_title" placeholder="제목 입력">${Vo.bo_title}</textarea>
				</td>
			</tr>
			<c:if test="${loginVo.emp_name == '관리자'}">
			<tr>
				<td scope="row">게시판 공개여부</td>
				<td colspan="3">
					<select name="delflag">
						<option value="delflagN">공개</option>
						<option value="delflagY">비공개</option>
					</select>
				</td>
			</tr>
			</c:if>
			<tr>
				<td colspan="4" rowspan="8">
				 <textarea name="bo_content" style="width: 100%; height: 500px; box-sizing: border-box;" placeholder="내용 입력">${Vo.bo_content}</textarea>
				</td>
			</tr>
		</table>
		<input class="form-control" type="file" id="reviewImageFileInput"><!-- ★★★★★★★★★★★★★★★★★★★★★★★ -->
		<c:choose>
		<c:when test="${mode=='insert'}">
		<button class="btn btn-primary" type="submit" onclick="submitForm()">게시</button>
		</c:when>
		<c:when test="${mode=='modify'}">
		<input type="hidden" name="bo_no" value="${Vo.bo_no}" />
		<button class="btn btn-warning" type="submit">수정</button>
		</c:when>
		</c:choose>
		<button class="btn btn-danger" type="button" onclick="window.history.back()">취소</button>
	</form>
	
	
	</main>
	<!-- End #main -->
</body>
<%@ include file="../comm/footer.jsp"%>


<script type="text/javascript">
			window.onload = function() {
				document.getElementById("reviewImageFileInput").onchange = function() {
					console.log("파일 업로드 버튼 실행");
					var imgFile = this.value.toLowerCase();
					var fileForm = /(.*?)\.(jpg|jpeg|bmp|png|gif)/;
					var maxSize = 5 * 1024 * 1024;
					var fileSize = document.getElementById("reviewImageFileInput").files[0].size;

					console.log(imgFile, fileForm, maxSize, fileSize);

					var checkImgTest = fileForm.test(imgFile); //true false
					if (checkImgTest) {
						console.log("")
					}
					var checkImgMatch = imgFile.match(fileForm); // 객체 혹은 null
					if (checkImgMatch) {
						console.log("if 객체가 있으면 true 이기 때문에]")
					}

					if (!checkImgTest) { // 정규화가 맞다면 true, 아니면 false
						alert("이미지 파일만 가능합니다");
						return;
					}
					if (maxSize < fileSize) {
						alert("이미지는 5M이하만 가능합니다");
						return;
					}

					//이미지 미리보기 작동 fn
					readUrl(this);

				}
			}
			function readUrl(input) {
				const target = document.getElementById("reviewImageFileInput");
				const fileLength = target.files.length;
				console.log("파일검색:", target.files);

				/*여러개의 JSON Array값을 출력하는 방법
				Object.keys(jArray).forEach(function(key){
					console.log(key, jArray[key], jArray[key].name);
					});
					for(var key in jArray){ // of
					console.log(key, jArray[key].name)
					}
					$.each(msg,function(key,value){})
				 */
				 
				$
						.each(
								target.files,
								function(index, file) {
									var render = new FileReader();
									render.onload = function(e) {
										// 					var info = e.target.result;
										// 					console.log(info);
										let reviewImg = "<li class='item' style=''>";
										reviewImg += "<a href='#' class='anchor'>";
										reviewImg += "<span class='subImage'>전송</span>";
										reviewImg += "</a>";
										reviewImg += "<img src='"+e.target.result+"' width='150px' class='item_thum'>";
										reviewImg += "<button class='deleteImg'>삭제</button>"
										reviewImg += "<span class='img_border'></span>"
										reviewImg += "</li>";
										$(".list_thumb").append(reviewImg);
									}
									render.readAsDataURL(file);
								});
			}

			document.querySelector(".list_thumb").addEventListener("click",
					function() {
						if (event.target.classList.contains('deleteImg')) {
							event.target.parentElement.remove();
						}
						if (event.target.classList.contains('subImage')) {
							imageSubmit();
						}
					});

			function imageSubmit() {
				console.log("이미지 AJAX 저장");
				let content = document.querySelector(".content").value;
				let reviewImageFileInput = document
						.getElementById("reviewImageFileInput").files;
				console.log("전송 글자 : ", content);
				console.log("전송 파일 : ", reviewImageFileInput.length);

				//######### input tag를 통한 방법				 			 	    
				// 	 		let formData = new FormData();//여기부터2
				// 	 		if(reviewImageFileInput.length >=1){
				// 	 			for(let i=0;i<reviewImageFileInput.length; i++){
				// 	 				formData.append("file",reviewImageFileInput[i]);
				// 	 			}
				// 	 		}
				// 	 		formData.append("desc",content);

				// 	 		console.log(formData.getAll("file"));
				// 	 		console.log(formData.get("desc"));	//여기까지2

				// ###########  li tag의 base64
				let formData = new FormData();
				formData.append("desc", content);

				let liImage = document.querySelectorAll('li');
				liImage.forEach(function(imgElem, index) {
					var img = imgElem.querySelector('img');
					var src = img.getAttribute("src"); // data:image/png;base64 이미지 파일
					var base64Data = src.split(',')[1]; // data:image/png;base64, 부분 제거
					var blob = b64toBlob(base64Data, 'image/png');
					var filename = 'image_' + index + '.png';
					formData.append("file", blob, filename);
				});

				console.log(formData.getAll("file"));
				$.ajax({
					url : "./uploadAjax.do",
					type : "post",
					async : false,
					data : formData,
					contentType : false,
					processData : false,
					dataType : "json",
					success : function(msg) {
						console.log(typeof msg, msg)
						if (msg.isc == "true") {
							alert("작성완료");
						}
					},
					error : function(request, error, status) {
						console.log(request, error)
					}
				});
			}

			// Base64 문자열을 Blob 객체로 변환하는 함수
			function b64toBlob(b64Data, contentType) {
				contentType = contentType || '';
				var sliceSize = 512;
				var byteCharacters = atob(b64Data);
				var byteArrays = [];

				for (var offset = 0; offset < byteCharacters.length; offset += sliceSize) {
					var slice = byteCharacters
							.slice(offset, offset + sliceSize);

					var byteNumbers = new Array(slice.length);
					for (var i = 0; i < slice.length; i++) {
						byteNumbers[i] = slice.charCodeAt(i);
					}

					var byteArray = new Uint8Array(byteNumbers);
					byteArrays.push(byteArray);
				}

				return new Blob(byteArrays, {
					type : contentType
				});
			}
</script>

</html>