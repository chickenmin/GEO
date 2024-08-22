<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<body>

  <!-- ======= Sidebar ======= -->
  <aside id="sidebar" class="sidebar">

    <ul class="sidebar-nav" id="sidebar-nav">

      <li class="nav-item">
        <a class="nav-link collapsed" href="index.jsp">
          <i class="bi bi-grid"></i>
          <span>메인 화면</span>
        </a>
      </li><!-- End Dashboard Nav -->

	  <li class="nav-item">
        <a class="nav-link collapsed" data-bs-target="#approval-nav" data-bs-toggle="collapse" href="#">
          <i class="bi bi-journal-text"></i><span>전자 결재</span><i class="bi bi-chevron-down ms-auto"></i>
        </a>
        <ul id="approval-nav" class="nav-content collapse " data-bs-parent="#sidebar-nav">
          <li>
            <a href="#">
              <i class="bi bi-circle"></i><span>전자 결재 홈</span>
            </a>
          </li>
          
          <li>
            <a href="#">
              <i class="bi bi-circle"></i><span>결재 양식</span>
            </a>
          </li>
          
          <li>
            <a href="#">
              <i class="bi bi-circle"></i><span>결재 문서함</span>
            </a>
          </li>
          
          <li>
            <a href="#">
              <i class="bi bi-circle"></i><span>상신 문서함</span>
            </a>
          </li>
          
          <li>
            <a href="#">
              <i class="bi bi-circle"></i><span>참조 문서함</span>
            </a>
          </li>
          
          <li>
            <a href="#">
              <i class="bi bi-circle"></i><span>임시 문서함</span>
            </a>
          </li>
          
          <li>
            <a href="#">
              <i class="bi bi-circle"></i><span>전자 서명 관리</span>
            </a>
          </li>
          
        </ul>
      </li><!-- End Approval Nav -->
	
	  <li class="nav-item">
        <a class="nav-link collapsed" data-bs-target="#hr-nav" data-bs-toggle="collapse" href="#">
          <i class="bi bi-person"></i><span>근태 관리</span><i class="bi bi-chevron-down ms-auto"></i>
        </a>
        <ul id="hr-nav" class="nav-content collapse " data-bs-parent="#sidebar-nav">
          <li>
            <a href="#">
              <i class="bi bi-circle"></i><span>근태 관리</span>
            </a>
            <ul>
            	<li>
            		<a href="#">
		              <i class="bi bi-circle"></i><span>사유서 제출</span>
		            </a>
            	</li>
            	
            	<li>
            		<a href="#">
		              <i class="bi bi-circle"></i><span>사유서 관리</span>
		            </a>
            	</li>
            </ul>
          </li>
          
          <li>
            <a href="#">
              <i class="bi bi-circle"></i><span>인사 관리</span>
            </a>
            <ul>
            	<li>
            		<a href="#">
		              <i class="bi bi-circle"></i><span>사원 조회</span>
		            </a>
            	</li>
            	
            	<li>
            		<a href="#">
		              <i class="bi bi-circle"></i><span>사원 추가(관리자만 보이게)</span>
		            </a>
            	</li>
            </ul>
          </li>
        </ul>
      </li><!-- End HR Nav -->
      
      <li class="nav-item">
        <a class="nav-link collapsed" data-bs-target="#orgChart-nav" data-bs-toggle="collapse" href="#">
          <i class="bi bi-diagram-3"></i><span>조직도</span>
        </a>
      </li><!-- End orgChart Nav -->
      
      <li class="nav-item">
        <a class="nav-link collapsed" data-bs-target="#calendar-nav" data-bs-toggle="collapse" href="#">
          <i class="bi bi-calendar-check"></i><span>일정 관리</span><i class="bi bi-chevron-down ms-auto"></i>
        </a>
        <ul id="calendar-nav" class="nav-content collapse " data-bs-parent="#sidebar-nav">
          <li>
            <a href="#">
              <i class="bi bi-circle"></i><span>회사 일정 관리</span>
            </a>
            <ul>
            	<li>
            		<a href="#">
		              <i class="bi bi-circle"></i><span>월별 일정 조회</span>
		            </a>
            	</li>
            	
            	<li>
            		<a href="#">
		              <i class="bi bi-circle"></i><span>카테고리별 일정 조회</span>
		            </a>
            	</li>
            	
            	<li>
            		<a href="#">
		              <i class="bi bi-circle"></i><span>일정 등록</span>
		            </a>
            	</li>
            </ul>
          </li>
          
          <li>
            <a href="#">
              <i class="bi bi-circle"></i><span>개인 스케줄 관리</span>
            </a>
            <ul>
            	<li>
            		<a href="#">
		              <i class="bi bi-circle"></i><span>스케줄 조회</span>
		            </a>
            	</li>
            	
            	<li>
            		<a href="#">
		              <i class="bi bi-circle"></i><span>스케줄 등록</span>
		            </a>
            	</li>
            </ul>
          </li>
        </ul>
      </li><!-- End Calendar Nav -->
      
      <li class="nav-item">
        <a class="nav-link collapsed" data-bs-target="#board-nav" data-bs-toggle="collapse" href="#">
          <i class="bi bi-layout-text-window-reverse"></i><span>게시판</span><i class="bi bi-chevron-down ms-auto"></i>
        </a>
        <ul id="board-nav" class="nav-content collapse " data-bs-parent="#sidebar-nav">
          <li>
            <a href="./announcements.do">
              <i class="bi bi-circle"></i><span>공지 게시판</span>
            </a>
          </li>
          
          <li>
            <a href="./nomalBoard.do">
              <i class="bi bi-circle"></i><span>일반 게시판</span>
            </a>
          </li>
          
          <li>
            <a href="./delBoard.do">
              <i class="bi bi-circle"></i><span>삭제 게시판</span>
            </a>
          </li>
        </ul>
      </li><!-- End Board Nav -->
      
      <li class="nav-item">
        <a class="nav-link collapsed" data-bs-target="#message-nav" data-bs-toggle="collapse" href="#">
          <i class="bi bi-envelope"></i><span>쪽지</span><i class="bi bi-chevron-down ms-auto"></i>
        </a>
        <ul id="message-nav" class="nav-content collapse " data-bs-parent="#sidebar-nav">
          <li>
            <a href="#">
              <i class="bi bi-circle"></i><span>받은 쪽지함</span>
            </a>
          </li>
          
          <li>
            <a href="#">
              <i class="bi bi-circle"></i><span>보낸 쪽지함</span>
            </a>
          </li>
        </ul>
      </li><!-- End Message Nav -->
      
      
      
    </ul>

  </aside><!-- End Sidebar-->




</body>
