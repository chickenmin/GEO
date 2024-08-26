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
		                  <span class="d-none d-lg-block">GEO</span>
		                </a>
		              </div><!-- End Logo -->
		
		              <div class="card mb-3">
		
		                <div class="card-body">
		
		                  <div class="pt-4 pb-2">
		                    <h5 class="card-title text-center pb-0 fs-4">Login to Your Account</h5>
		                    <p class="text-center small">Enter your username & password to login</p>
		                  </div>
		
		                  <!-- form -->
		                  <form class="row g-3 needs-validation" action="./login.do" method="post">
		
		                    <div class="col-12">
		                      <label for="yourUsername" class="form-label">사원번호</label>
		                      <div class="input-group has-validation">
		                        <span class="input-group-text" id="inputGroupPrepend">@</span>
		                        <input type="text" name="emp_no" class="form-control" id="emp_no" required>
		                        <div class="invalid-feedback">사원번호를 입력해주세요.</div>
		                      </div>
		                    </div>
		
		                    <div class="col-12">
		                      <label for="yourPassword" class="form-label">비밀번호</label>
		                      <input type="password" name="emp_pw" class="form-control" id="emp_pw" required>
		                      <div class="invalid-feedback">비밀번호를 입력해주세요.</div>
		                    </div>
		
		                    <div class="col-12">
		                      <div class="form-check">
		                        <input class="form-check-input" type="checkbox" name="remember" value="true" id="rememberMe">
		                        <label class="form-check-label" for="rememberMe">사원번호 저장</label>
		                      </div>
		                    </div>
		                    <div class="col-12">
		                      <button class="btn btn-primary w-100" type="submit">로그인</button>
		                    </div>
		                    <div class="col-12">
		                      <p class="small mb-0">비밀번호를 잊어버리셨나요?&nbsp&nbsp<a href="pages-register.html">임시 비밀번호 발급</a></p>
		                    </div>
		                  </form> <!-- End form-->
		
		                </div>
		              </div>
		
		              <!-- credits -->
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