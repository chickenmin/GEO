<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
<!DOCTYPE html>
<html>

<%@ include file="../comm/header.jsp"%>

<body>
	<%@ include file="../comm/sidebar.jsp"%>
	<main id="main" class="main">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>

	function openPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 팝업에서 검색결과 항목을 클릭했을 때 실행할 코드입니다.
						var addr = ''; // 주소 변수
						var extraAddr = ''; // 참고항목 변수

						// 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
						if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
							addr = data.roadAddress;
						} else { // 사용자가 지번 주소를 선택했을 경우
							addr = data.jibunAddress;
						}

						// 사용자가 선택한 주소가 도로명 타입일 때 참고항목을 조합한다.
						if (data.userSelectedType === 'R') {
							// 법정동명이 있을 경우 추가한다.
							if (data.bname !== ''
									&& /[동|로|가]$/g.test(data.bname)) {
								extraAddr += data.bname;
							}
							// 건물명이 있고, 공동주택일 경우 추가한다.
							if (data.buildingName !== ''
									&& data.apartment === 'Y') {
								extraAddr += (extraAddr !== '' ? ', '
										+ data.buildingName : data.buildingName);
							}
							// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
							if (extraAddr !== '') {
								extraAddr = ' (' + extraAddr + ')';
							}
							// 조합된 참고항목을 해당 필드에 넣는다.
							document.getElementById("sample6_extraAddress").value = extraAddr;

						} else {
							document.getElementById("sample6_extraAddress").value = '';
						}

						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById('sample6_postcode').value = data.zonecode;
						document.getElementById("sample6_address").value = addr;
						// 커서를 상세주소 필드로 이동한다.
						document.getElementById("sample6_detailAddress")
								.focus();
						
					}
				
				}).open();	
// 		fullAddress();
		
		
	}
// 	function fullAddress() {
// 		let addr01 = document.getElementById("sample6_address").value;
// 		let addr02 = document.getElementById("sample6_detailAddress").value;
// 		let addr03 = document.getElementById("sample6_extraAddress").value;
// 		document.getElementById("emp_address").value = addr01 + addr02 + addr03;	
// 		return false;
		

	
	</script>
	<script type="text/javascript">
		window.onload = function() {
			document.querySelector('form').addEventListener(
					'submit',
					function(event) {
						const empNoInput = document.querySelector('input[name="emp_no"]');
						const empPhoneInput = document.querySelector('input[name="emp_phone"]')
						const empEmailInput = document.querySelector('input[name="emp_email"]')
						
						
						const empNoValue = empNoInput.value;
						const empPhoneValue = empPhoneInput.value;
						const empEmailValue = empEmailInput.value;
						const empNoRegex = /^[A-Z]{2}\d{3}$/;
						const empPhoneRegex = /^(010-\d{4}-\d{4})$/;
						const empEmailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
						if (!empNoRegex.test(empNoValue)) {
							alert("잘못된 사번 형식입니다.");
							event.preventDefault();
						}
						if (!empPhoneRegex.test(empPhoneValue)) {
							alert("잘못된 전화번호 형식입니다.");
							event.preventDefault();
						}
						if (!empEmailRegex.test(empEmailValue)) {
							alert("잘못된 이메일 형식입니다.");
							event.preventDefault();
						}
					});
		}
		
	
	
	
</script>
<script type="text/javascript">
            window.onload = function() {
                document.querySelector('form').addEventListener('submit', function(event) {
                    const empNoInput = document.querySelector('input[name="emp_no"]');
                    const empPhoneInput = document.querySelector('input[name="emp_phone"]');
                    const empEmailInput = document.querySelector('input[name="emp_email"]');
                    
                    const empNoValue = empNoInput.value;
                    const empPhoneValue = empPhoneInput.value;
                    const empEmailValue = empEmailInput.value;
                    const empNoRegex = /^[A-Z]{2}\d{3}$/;
                    const empPhoneRegex = /^(010-\d{4}-\d{4})$/;
                    const empEmailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
                    if (!empNoRegex.test(empNoValue)) {
                        alert("잘못된 사번 형식입니다.");
                        event.preventDefault();
                    }
                    if (!empPhoneRegex.test(empPhoneValue)) {
                        alert("잘못된 전화번호 형식입니다.");
                        event.preventDefault();
                    }
                    if (!empEmailRegex.test(empEmailValue)) {
                        alert("잘못된 이메일 형식입니다.");
                        event.preventDefault();
                    }
                });

                document.getElementById("formFile").onchange = function() {
                    console.log("파일 업로드 버튼 실행");
                    var imgFile = this.value.toLowerCase();
                    var fileForm = /(.*?)\.(jpg|jpeg|bmp|png|gif|pdf)$/;
                    var maxSize = 5 * 1024 * 1024;
                    var fileSize = this.files[0].size;

                    if (!fileForm.test(imgFile)) {
                        alert("이미지 파일만 가능합니다");
                        return;
                    }
                    if (fileSize > maxSize) {
                        alert("이미지 파일은 5Mb 이하만 가능합니다");
                        return;
                    }

                    readUrl(this);
                };

//                 document.querySelector(".list_thumb").addEventListener("click", function(event) {
//                     if (event.target.classList.contains('deleteImg')) {
//                         event.target.parentElement.remove();
//                     }
//                 });
            }

            function readUrl(input) {
                const target = input;
                const fileLength = target.files.length;

                $.each(target.files, function(index, file) {
                    var render = new FileReader();
                    render.onload = function(e) {
                        var reviewImg = "<li class='item'>";
                        reviewImg += "<a href='#' class='anchor'>";
                        reviewImg += "<span class='subImage'>전송</span>";
                        reviewImg += "</a>";
                        reviewImg += "<img src='" + e.target.result + "' width='50px' class='item_thumb'>";
                        reviewImg += "<button class='deleteImg'>삭제</button>";
                        reviewImg += "<span class='img_border'></span>";
                        reviewImg += "</li>";
                        $(".list_thumb").append(reviewImg);
                    }
                    render.readAsDataURL(file);
                });
            }
        </script>

		<div class="card">
			<form action="./insertEmp.do" method="post" enctype="multipart/form-data">
			<div class="card-body">
				<h5 class="card-title">사원 추가</h5>
				<div class="row mb-3">
					<label for="inputNumber" class="col-sm-2 col-form-label">프로필 사진</label>
					<div class="col-sm-10" style="width: 50%;">
						<input class="form-control" type="file" id="formFile" name="file">
					</div>
				</div>
				<div class="row mb-3">
					<label for="inputText" class="col-sm-2 col-form-label">사번</label>
					<div class="col-sm-10" style="width: 50%;">
						<input type="text" class="form-control" name="emp_no" placeholder="영어 대문자 2자 + 숫자 3자 형식으로 입력해주세요.">
					</div>
				</div>
				<div>
					<div class="row mb-3">
						<label for="inputText" class="col-sm-2 col-form-label">비밀번호</label>
						<div class="col-sm-10" style="width: 50%;">
							<input type="password" class="form-control" name="emp_pw">
						</div>
					</div>
					<div>
						<div class="row mb-3">
							<label for="inputText" class="col-sm-2 col-form-label">이름</label>
							<div class="col-sm-10" style="width: 50%;">
								<input type="text" class="form-control" name="emp_name">
							</div>
						</div>
					</div>
					<div class="row mb-3">
						<label for="inputText" class="col-sm-2 col-form-label">성별</label>
						<div class="col-sm-10" style="width: 50%;">
							<select class="form-select" aria-label="Default select example" name="emp_gender">
								<option value="남">남</option>
								<option value="여">여</option>
							</select>
						</div>
					</div>
						<div class="row mb-3">
							<label for="inputDate" class="col-sm-2 col-form-label">생년월일</label>
							<div class="col-sm-10" style="width: 50%">
								<input type="date" class="form-control" name="emp_birth">
							</div>
						</div>

						<div class="row mb-3">
						<label for="inputText" class="col-sm-2 col-form-label">직급</label>
						<div class="col-sm-10" style="width: 50%;">
							<select class="form-select" aria-label="Default select example" name="emp_pos">
								<option value="PO001">사원</option>
								<option value="PO002">주임</option>
								<option value="PO003">대리</option>
								<option value="PO004">과장</option>
								<option value="PO005">차장</option>
								<option value="PO006">부장</option>
							</select>
						</div>
					</div>
					<div class="row mb-3">
						<label for="inputText" class="col-sm-2 col-form-label">부서</label>
						<div class="col-sm-10" style="width: 50%;">
							<select class="form-select" aria-label="Default select example" name="emp_dept">
								<option value="DE001">개발</option>
								<option value="DE002">인사</option>
								<option value="DE003">생산</option>
								<option value="DE004">총무</option>
								<option value="DE005">영업</option>
								<option value="DE006">마케팅</option>
							</select>
						</div>
					</div>
					<div>
						<div class="row mb-3">
							<label for="inputText" class="col-sm-2 col-form-label">연락처</label>
							<div class="col-sm-10" style="width: 50%;">
								<input type="text" class="form-control" placeholder="ex) 000-0000-0000(' - '포함)" name="emp_phone">
							</div>
						</div>
					</div>
					<div>
						<div class="row mb-3">
							<label for="inputText" class="col-sm-2 col-form-label">이메일</label>
							<div class="col-sm-10" style="width: 50%;">
								<div class="input-group mb-3">
									<input type="text" class="form-control" placeholder="ex) email@gmail.com" name="emp_email">
								</div>
							</div>
						</div>
					</div>
				</div>
				<div>
					<div class="row mb-3">
						<label for="sample6_postcode" class="col-sm-2 col-form-label">주소</label>
							<div class="col-sm-10">
								<div class="input-group mb-3" style="width: 25%;">
									<input type="text" class="form-control" id="sample6_postcode" name="emp_postcode" placeholder="우편번호" readonly="readonly">
							
								</div>
								<div>
									<button type="button" class="btn btn-primary" onclick="openPostcode()">우편번호 찾기</button>
								</div>
								<br>
								<input type="text" class="form-control" id="sample6_address" name="emp_address1" placeholder="주소" readonly="readonly" style="width: 50%; margin-bottom: 10px;">
								<input type="text" class="form-control" id="sample6_detailAddress" name="emp_address2" placeholder="상세주소" style="margin-bottom: 10px;">
								<input type="text" class="form-control" id="sample6_extraAddress" name="emp_address3" placeholder="참고항목" readonly="readonly" style="width: 50%;">
							</div>
						
					</div>
				</div>
				
				
				<div class=col-sm-10>
					<button type="submit" class="btn btn-primary" value="사원추가">사원추가</button>
				</div>
			</div>
			</form>
		</div>
	</main>
	<!-- End #main -->

	<%@ include file="../comm/footer.jsp"%>

</body>

</html>