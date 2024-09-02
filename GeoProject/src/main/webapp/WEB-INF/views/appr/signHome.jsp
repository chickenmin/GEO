<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>

<%@ include file="../comm/header.jsp" %>
<head>
	<style type="text/css">
        #signature-pad {
            border: 2px solid #000;
            width: 400px;
            height: 200px;
            margin-bottom: 10px;
        }
        .btn {
            margin-right: 10px;
        }
	</style>
	 <script src="https://cdn.jsdelivr.net/npm/signature_pad@4.0.0/dist/signature_pad.umd.min.js"></script>
</head>
<body>
	<%@ include file="../comm/sidebar.jsp" %>
 	<main id="main" class="main" style="height: 600px;">
		
		<div class="pagetitle">
			<h1>결재 문서함</h1>
		</div><!-- End Page Title -->
		
			<section class="section">
		      <div class="row">
		     	 <div class="formDiv" >
		      	<form action="./deleteSign.do" method="post"> <!-- 삭제 -->
		      		<button class="btn btn-primary ">삭제</button>
		      		<button type="button" class="btn btn-primary rounded-pill" data-bs-toggle="modal" data-bs-target="#enroll">생성</button>
			      <c:choose>
			      	<c:when test="${fn:length(signs) != 0}">
			      		<div style="display: flex; justify-content: space-evenly;">
				      		<c:forEach var="sign" items="${signs}" varStatus="vs"> 
						       <div class="card info-card revenue-card">
								    <h5 class="card-title">전자서명 ${vs.index+1 }</h5>
								    <div class="position-relative">
								        <!-- 이미지 -->
								        <img alt="전자서명" src="./signature/${sign.file_oname }" style="height: 200px; width: 200px;">
								        <!-- 체크박스 -->
								        <input type="checkbox" name="signName" value="${sign.file_oname}" 
								               class="position-absolute" style="top: 10px; left: 10px;">
								    </div>
								</div>
						       
				      		</c:forEach>
				      	</div>
			      	</c:when>
			      	<c:otherwise>
			      		<div class="card">
			      			<div class="card-body" style="text-align: center;"><br><h4>등록된 서명이 없습니다.</h4></div>
						</div>
			      	</c:otherwise>
			      </c:choose>
		      </form>
		      </div>
		      </div>
			</section>
		
<jsp:include page="./enrollModal.jsp"></jsp:include>

  	</main><!-- End #main -->

  <%@ include file="../comm/footer.jsp" %>
</body>
 <script>
 
 $(document).ready(function(){
	 
//         // 캔버스 요소와 SignaturePad 초기화
//         const canvas = document.getElementById('signature-pad');
//         const signaturePad = new SignaturePad(canvas, {
//             backgroundColor: 'rgba(255, 255, 255, 0)', // 투명 배경
//             penColor: 'black' // 펜 색상
//         });


//         // 저장 버튼 클릭 시 PNG 저장 기능
//         document.getElementById('save').addEventListener('click', function () {
//             if (signaturePad.isEmpty()) {
//                 alert('서명이 비어 있습니다.');
//                 return;
//             }

//             const dataURL = signaturePad.toDataURL('image/png');

   

//             // 또는 서버로 전송하려면 아래 코드를 사용
//             fetch('./saveSignature.do', {
//                 method: 'POST',
//                 headers: {
//                     'Content-Type': 'application/json'
//                 },
//                 body: JSON.stringify({ image: dataURL })
//             })
//             .then(response => response.json())
//             .then(data => {
//                 alert('서명이 성공적으로 저장되었습니다.');
//                 console.log('성공:', data);
//             })
//             .catch((error) => {
//                 console.error('오류:', error);
//                 alert('서명 저장에 실패했습니다.');
//             });
            
//         });

//         // 초기화 버튼 클릭 시 서명 초기화
//         document.getElementById('clear').addEventListener('click', function () {
//             signaturePad.clear();
//         });

//         // 캔버스 크기 조절 (반응형 지원)
//         function resizeCanvas() {
//             const ratio = Math.max(window.devicePixelRatio || 1, 1);
//             canvas.width = canvas.offsetWidth * ratio;
//             canvas.height = canvas.offsetHeight * ratio;
//             canvas.getContext('2d').scale(ratio, ratio);
//             signaturePad.clear(); // 캔버스 초기화
//         }

//         window.addEventListener('resize', resizeCanvas);
//         resizeCanvas();


	//파일 양식 유효성
	if (document.getElementById('reviewImgFileInput')) {
		    console.log("reviewImgFileInput 요소가 존재합니다.");
	         document.getElementById("reviewImgFileInput").onchange = function(){
		  			console.log("파일 업로드 버튼 실행");
		  			var imgFile = this.value.toLowerCase();
		  			var fileForm = /(.*?)\.(jpg|jpeg|bmp|png)$/i;
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
        
 });
    </script>
</html>