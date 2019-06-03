<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <!-- Sidebar -->
    <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

      <!-- Sidebar - Brand -->
      <a class="sidebar-brand d-flex align-items-center justify-content-center" href="main.jsp">
        <div class="sidebar-brand-icon rotate-n-15">
          <i class="fas fa-laugh-wink"></i>
        </div>
        <div class="sidebar-brand-text mx-3">수강신청 시스템</div>
      </a>
       <!-- Divider -->
      <hr class="sidebar-divider">
      <!-- Heading -->
      <div class="sidebar-heading">
        	개인정보
      </div>
      
      <% String session_id = (String)session.getAttribute("user");
	if (session_id == null){
		%>
		<li class="nav-item">
        <b><a class="nav-link" href=login.jsp><i class="fas fa-fw fa-cog"></i>
          <span>로그인</span></a></b>
      </li>
      <li class="nav-item">
        <b><a class="nav-link" href=update.jsp><i class="fas fa-fw fa-wrench"></i>
          <span>비밀번호 수정</span></a></b>
      </li>
      
      <!-- Divider -->
      <hr class="sidebar-divider">
      <!-- Heading -->
      <div class="sidebar-heading">
        	수강신청
      </div>
      <li class="nav-item">
        <b><a class="nav-link" href=login.jsp><i class="fas fa-fw fa-mouse-pointer"></i>
          <span>수강신청 입력</span></a></b>
      </li>
      <li class="nav-item">
        <b><a class="nav-link" href=delete2.jsp><i class="fas fa-fw fa-times"></i>
          <span>수강신청 삭제</span></a></b>
      </li>
      <li class="nav-item">
        <b><a class="nav-link" href=select.jsp?year_semester=201902><i class="fas fa-fw fa-table"></i>
          <span>수강신청 조회</span></a></b>
      </li>
       <!-- Divider -->
      <hr class="sidebar-divider d-none d-md-block">
     
    </ul>
    <!-- End of Sidebar -->
    <!-- Topbar -->
        <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
            <h2 style="text-align:center" >로그인 후 사용하세요.</h2>
        </nav>
        <!-- End of Topbar -->
    
		<%
	}
	else { 
		%>
		<li class="nav-item">
        <b><a class="nav-link" href=logout.jsp><i class="fas fa-fw fa-cog"></i>
          <span>로그아웃</span></a></b>
      </li>
      <li class="nav-item">
        <b><a class="nav-link" href=update.jsp><i class="fas fa-fw fa-wrench"></i>
          <span>비밀번호 수정</span></a></b>
      </li>
      
      <!-- Divider -->
      <hr class="sidebar-divider">
      <!-- Heading -->
      <div class="sidebar-heading">
        	수강신청
      </div>
      <li class="nav-item">
        <b><a class="nav-link" href=insert.jsp?year_semester=201902><i class="fas fa-fw fa-mouse-pointer"></i>
          <span>수강신청 입력</span></a></b>
      </li>
      <li class="nav-item">
        <b><a class="nav-link" href=delete2.jsp><i class="fas fa-fw fa-times"></i>
          <span>수강신청 삭제</span></a></b>
      </li>
      <li class="nav-item">
        <b><a class="nav-link" href=select.jsp?year_semester=201902><i class="fas fa-fw fa-table"></i>
          <span>수강신청 조회</span></a></b>
      </li>   
    <!-- Divider -->
      <hr class="sidebar-divider d-none d-md-block">
    </ul>
    <!-- End of Sidebar -->
    <!-- Topbar -->
        <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
            <!-- Nav Item - User Information -->
            <h2><%=session_id%>님 방문을 환영합니다.</h2>
        </nav>
        <!-- End of Topbar -->
		<%
	}
%>
     
    
     