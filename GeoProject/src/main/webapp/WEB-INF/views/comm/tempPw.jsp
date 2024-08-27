<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<%@ include file="./header.jsp" %>

<body>
	<%@ include file="./sidebar.jsp" %>
 	<main id="main" class="main">
	    <div class="container">
	
	      <section class="section register min-vh-100 d-flex flex-column align-items-center justify-content-center py-4">
	        <div class="container">
	          <div class="row justify-content-center">
	            <div class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center">
	
	              <div class="d-flex justify-content-center py-4">
	                <a href="index.html" class="logo d-flex align-items-center w-auto">
	                  <img src="assets/img/logo.png" alt="">
	                  <span class="d-none d-lg-block">NiceAdmin</span>
	                </a>
	              </div><!-- End Logo -->
	
	              <div class="card mb-3">
	
	                <div class="card-body">
	
	                  <div class="pt-4 pb-2">
	                    <h5 class="card-title text-center pb-0 fs-4">임시 비밀번호 발급</h5>
	                    <p class="text-center small">비밀번호 발급을 위해 사원정보를 입력해주세요.</p>
	                  </div>
	
	                  <form class="row g-3 needs-validation" id="tempPwForm" action="./tempPw.do" method="POST">
	                    <div class="col-12">
	                      <label for="yourUsername" class="form-label">사원번호</label>
	                      <div class="input-group has-validation">
	                        <span class="input-group-text" id="inputGroupPrepend">@</span>
	                        <input type="text" name="emp_no" class="form-control" id="emp_no" required>
	                        <div class="invalid-feedback">사원번호를 입력하세요!</div>
	                      </div>
	                    </div>
	                    
	                    <div class="col-12">
	                      <label for="yourName" class="form-label">이름</label>
	                      <input type="text" name="emp_name" class="form-control" id="emp_name" required>
	                      <div class="invalid-feedback">이름을 입력하세요!</div>
	                    </div>
	                    
	                    <div class="col-12">
	                      <label for="yourEmail" class="form-label">이메일</label>
	                      <input type="email" name="emp_email" class="form-control" id="emp_email" required>
	                      <div class="invalid-feedback">이메일을 입력하세요!</div>
	                    </div>
	
<!-- 	                    <div class="col-12"> -->
<!-- 	                      <div class="form-check"> -->
<!-- 	                        <input class="form-check-input" name="terms" type="checkbox" value="" id="acceptTerms" required> -->
<!-- 	                        <label class="form-check-label" for="acceptTerms">I agree and accept the <a href="#">terms and conditions</a></label> -->
<!-- 	                        <div class="invalid-feedback">You must agree before submitting.</div> -->
<!-- 	                      </div> -->
<!-- 	                    </div> -->

						<div class="pd-2"></div>

	                    <div class="col-12">
	                      <button class="btn btn-primary w-100" type="submit">임시 비밀번호 전송</button>
	                    </div>
	                    
	                    <div class="pd-2"></div>
	                  </form>
	
	                </div>
	              </div>
	
	              <div class="credits">
	                <!-- All the links in the footer should remain intact. -->
	                <!-- You can delete the links only if you purchased the pro version. -->
	                <!-- Licensing information: https://bootstrapmade.com/license/ -->
	                <!-- Purchase the pro version with working PHP/AJAX contact form: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/ -->
	                Designed by <a href="https://bootstrapmade.com/">BootstrapMade</a>
	              </div>
	
	            </div>
	          </div>
	        </div>
	
	      </section>
	
	    </div>
	  </main><!-- End #main -->


</body>
  <%@ include file="./footer.jsp" %>


</html>