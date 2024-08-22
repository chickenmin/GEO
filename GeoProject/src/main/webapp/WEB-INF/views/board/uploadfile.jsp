<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>파일업로드</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
	<div>
		<!-- ~파일 다중 이미지 저장~
		form tag의 enctype 속성
		1.application/x-www-form-urlencoded : (default)문자
		2.multipart/form-data : fileupload 문자 + 데이터(post)
		3.text/plain : encode를 하지 않겠다
		
		파일업로드 Ajax 사용방법
		var form = document.forms[0];
		var formData = new FormData(frm);
		
		var file = document.querySelector("input[type=file]");
		var formData = new FormData();
		formData.append("file",file);
		
		$.ajax({
		url:"",
		enctype:"multipart/form-data",
		processData:false, //서버에 전송할 데이터가 쿼리스트링으로 되어 있는지 여부(true: 쿼리스트링, false:Data)
		contentType:false, //false로 작성하면 enctype을 사용할 수 있다
		data:formData,  //AJAX는 HTML의 Form 데이터를 전송하기 때문에 new FormData() 객체를 보내야 한다
		type:post,		
		success:function(){}
		})
		
		
	 -->

		<!-- TODO 064 -->
		<form action="./upload.do" method="post" enctype="multipart/form-data">
			<h3>업로드할 파일</h3>
			파일 : <input type="file" name="file"><br> 설명 : <br>
			<textarea rows="10" cols="40" name="desc" class="content"></textarea>
			<input type="submit" value="전송">
		</form>

		<!-- TODO 071 -->
		<fieldset>
			<legend>AJAX를 통한 이미지 업로드 및 미리보기</legend>
			<div>
				<input type="file" class="hidden_input" id="reviewImageFileInput"
					accept="image/*" multiple>
			</div>
			<div>
				<ul class="list_thumb"></ul>
			</div>

		</fieldset>
		<script type="text/javascript">
			window.onload = function() {
				document.getElementById("reviewImageFileInput").onchange = function() {
					console.log("파일 업로드 버튼 실행");
					var imgFile = this.value.toLowerCase();
					var fileForm = /(.*?)\.(jpg|jpeg|bmp|png|gif)/;
					var maxSize = 5 * 1024 * 1024;
					var fileSize = document
							.getElementById("reviewImageFileInput").files[0].size;

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
	</div>
</body>
</html>