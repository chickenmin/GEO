<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
  <meta charset="UTF-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">
  <meta content="" name="description">
  <meta content="" name="keywords">

<!-- Favicons -->
<link href="assets/img/favicon.png" rel="icon">
<link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">

<!-- Google Fonts -->
<link href="https://fonts.gstatic.com" rel="preconnect">
<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

<!-- Vendor CSS Files -->
<link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
<link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
<link href="assets/vendor/quill/quill.snow.css" rel="stylesheet">
<link href="assets/vendor/quill/quill.bubble.css" rel="stylesheet">
<link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet">
<link href="assets/vendor/simple-datatables/style.css" rel="stylesheet">

<!-- Template Main CSS File -->
<link href="assets/css/style.css" rel="stylesheet">

<!-- =======================================================
* Template Name: NiceAdmin
* Template URL: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/
* Updated: Apr 20 2024 with Bootstrap v5.3.3
* Author: BootstrapMade.com
* License: https://bootstrapmade.com/license/
======================================================== -->

<!-- multi DATE PICKER  주말 안나오게 하려면 jQuery ui 필요 -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<!-- jQuery , multiDatesPicker -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<link href="https://cdn.rawgit.com/dubrox/Multiple-Dates-Picker-for-jQuery-UI/master/jquery-ui.multidatespicker.css" rel="stylesheet"/>
<link href="https://code.jquery.com/ui/1.12.1/themes/pepper-grinder/jquery-ui.css" rel="stylesheet"/>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<script src="https://cdn.rawgit.com/dubrox/Multiple-Dates-Picker-for-jQuery-UI/master/jquery-ui.multidatespicker.js"></script>

<!-- MESSAGE -->
<script src="https://cdn.quilljs.com/1.3.6/quill.js"></script>
<link href="https://cdn.datatables.net/v/bs5/dt-2.1.4/datatables.min.css" rel="stylesheet">

<link href="./css/Msg.css" rel="stylesheet">
<script src="./js/msg.js" type="text/javascript"></script>
<title>GEO</title>
</head>
<!-- ======= Header ======= -->
<header id="header" class="header fixed-top d-flex align-items-center">

  <div class="d-flex align-items-center justify-content-between">
    <a href="./index.do" class="logo d-flex align-items-center">
      <img src="assets/img/logo.png" alt="">
      <span class="d-none d-lg-block">NiceAdmin123</span>
    </a>
    <i class="bi bi-list toggle-sidebar-btn"></i>
  </div><!-- End Logo -->

 <!--  <div class="search-bar">
    <form class="search-form d-flex align-items-center" method="POST" action="#">
      <input type="text" name="query" placeholder="Search" title="Enter search keyword">
      <button type="submit" title="Search"><i class="bi bi-search"></i></button>
    </form>
  </div> --><!-- End Search Bar -->

  <nav class="header-nav ms-auto">
    <ul class="d-flex align-items-center">

    <!--   <li class="nav-item d-block d-lg-none">
        <a class="nav-link nav-icon search-bar-toggle " href="#">
          <i class="bi bi-search"></i>
        </a>
      </li> --><!-- End Search Icon-->

      <li class="nav-item dropdown">
        <a class="nav-link nav-icon" href="#" data-bs-toggle="dropdown">
          <i class="bi bi-bell"></i>
          
          <!-- 확인안한 알림 갯수 -->
          <span class="badge bg-primary badge-number">
          		10
          </span>
          
        </a><!-- End Notification Icon -->

        <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow notifications">
          <li class="dropdown-header">
             읽지않은 알림 4개 / 여기가 길어야 dropdown이 길어짐
            <a href="#"><span class="badge rounded-pill bg-primary p-2 ms-2">View all</span></a>
          </li>
          <li>
            <hr class="dropdown-divider">
          </li>

          <li class="notification-item">
            <i class="bi bi-exclamation-circle text-warning"></i>
            <div>
              <h4>사내 공지사항</h4>
              <p>사내 공지사항 - '안전교육 안내' 게시글이 등록되었습니다.</p>
              <p>30분 전</p>
            </div>
          </li>


          <li>
            <hr class="dropdown-divider">
          </li>

          <li class="notification-item">
            <i class="bi bi-x-circle text-danger"></i>
            <div>
              <h4>결재 문서 반려</h4>
              <p>결재 문서 반려 - '강정민 대표님'께 상신한 '기안서2'가 반려되었습니다.</p>
              <p>1시간 전</p>
            </div>
          </li>


          <li>
            <hr class="dropdown-divider">
          </li>

          <li class="notification-item">
            <i class="bi bi-check-circle text-success"></i>
            <div>
              <h4>결재 문서 승인</h4>
              <p>결재 문서 승인 - '강정민 대표님'께 상신한 '기안서1'가 승인되었습니다.</p>
              <p>2시간 전</p>
            </div>
          </li>


          <li>
            <hr class="dropdown-divider">
          </li>


          <li class="notification-item">
            <i class="bi bi-info-circle text-primary"></i>
            <div>
              <h4>Dicta reprehenderit</h4>
              <p>Quae dolorem earum veritatis oditseno</p>
              <p>4 hrs. ago</p>
            </div>
          </li>

          <li>
            <hr class="dropdown-divider">
          </li>
          <li class="dropdown-footer">
            <a href="#">모든 알림 보기</a>
          </li>


        </ul><!-- End Notification Dropdown Items -->

      </li><!-- End Notification Nav -->



	  <!-- 쪽지 알림 -->
      <li class="nav-item dropdown">

        <a class="nav-link nav-icon" href="#" id="msgIcon" data-bs-toggle="dropdown">
          <i class="bi bi-chat-left-text"></i>
          
          <span class="badge bg-success badge-number" id="cntUnreadMsg">
	          <!-- 안읽은 쪽지 갯수 -->
          </span>
          
        </a><!-- End Messages Icon -->

        <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow messages" id="msgUl" style="width: 350px;">
          <li class="dropdown-header" id="cntDropdown">
            <a href="#">
	            <span class="badge rounded-pill bg-primary p-2 ms-2">
		          	<!-- 'n개의 읽지않은 쪽지가 있습니다.' 텍스트 들어가는 곳 -->
	            </span>
            </a>
          </li>
          
          <li>
            <hr class="dropdown-divider">
          </li>

          <li class="message-item">
            <a href="#">
              <img src="assets/img/messages-1.jpg" alt="" class="rounded-circle">
              <div>
                <h4>강정민 대표</h4>
                <p>회의실로 오세요</p>
                <p>30분 전</p>
              </div>
            </a>
          </li>
          
          <li>
            <hr class="dropdown-divider">
          </li>
          
          <li class="dropdown-footer">
            <a href="./recvMsg.do">모든 쪽지 보기</a>
          </li>
        </ul><!-- End Messages Dropdown Items -->
      </li><!-- End Messages Nav -->
      
      
      
      
      
      
      <li class="nav-item dropdown pe-3">

        <a class="nav-link nav-profile d-flex align-items-center pe-0" href="#" data-bs-toggle="dropdown">
          <img src="<c:url value='/storage/${loginVo.emp_img}'/>" alt="Profile" class="rounded-circle">
          <span class="d-none d-md-block dropdown-toggle ps-2">${loginVo.emp_name}</span>
        </a><!-- End Profile Iamge Icon -->

        <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow profile">
          <li class="dropdown-header">
            <h6>${loginVo.emp_name}</h6>
            <span>
            	<c:choose>
            		<c:when test="${loginVo.emp_dept eq 'DE001'}">개발팀</c:when>
            		<c:when test="${loginVo.emp_dept eq 'DE002'}">인사팀</c:when>
            		<c:when test="${loginVo.emp_dept eq 'DE003'}">생산팀</c:when>
            		<c:when test="${loginVo.emp_dept eq 'DE004'}">총무팀</c:when>
            		<c:when test="${loginVo.emp_dept eq 'DE005'}">영업팀</c:when>
            		<c:when test="${loginVo.emp_dept eq 'DE006'}">마케팅팀</c:when>	
            	</c:choose>
            	<c:choose>
            		<c:when test="${loginVo.emp_pos eq 'PO001'}">사원</c:when>
            		<c:when test="${loginVo.emp_pos eq 'PO002'}">주임</c:when>
            		<c:when test="${loginVo.emp_pos eq 'PO003'}">대리</c:when>
            		<c:when test="${loginVo.emp_pos eq 'PO004'}">과장</c:when>
            		<c:when test="${loginVo.emp_pos eq 'PO005'}">차장</c:when>
            		<c:when test="${loginVo.emp_pos eq 'PO006'}">부장</c:when>	
            	</c:choose>
            </span>
          </li>
          <li>
            <hr class="dropdown-divider">
          </li>

          <li>
            <a class="dropdown-item d-flex align-items-center" href="./myPage.do?tab=overview">
              <i class="bi bi-person"></i>
              <span>내 정보 보기</span>
            </a>
          </li>
          <li>
            <hr class="dropdown-divider">
          </li>

          <li>
            <a class="dropdown-item d-flex align-items-center" href="./myPage.do?tab=edit">
              <i class="bi bi-gear"></i>
              <span>내 정보 수정</span>
            </a>
          </li>
    	  <li>
            <hr class="dropdown-divider">
          </li>
          
          <li>
            <a class="dropdown-item d-flex align-items-center" href="./myPage.do?tab=password">
              <i class="bi bi-key"></i>
              <span>비밀번호 변경</span>
            </a>
          </li>
    	  <li>
            <hr class="dropdown-divider">
          </li>

          <li>
            <a class="dropdown-item d-flex align-items-center" href="./logout.do">
              <i class="bi bi-box-arrow-right"></i>
              <span>로그아웃</span>
            </a>
          </li>

        </ul><!-- End Profile Dropdown Items -->
      </li><!-- End Profile Nav -->

    </ul>
  </nav><!-- End Icons Navigation -->

</header><!-- End Header -->