<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String admin = (String)session.getAttribute("admin");
	if(admin == null){
		response.sendRedirect("/cashbook/Form/loginForm.jsp");
		return;
	}
%>

<link href="/cashbook/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
<link href="/cashbook/css/sb-admin-2.min.css" rel="stylesheet">

<nav class="navbar navbar-expand-lg navbar-light bg-white shadow mb-4">
  <div class="container">
    <a class="navbar-brand font-weight-bold text-primary" href="/cashbook/Form/monthList.jsp">💰 가계부</a>
    
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navMenu">
      <span class="navbar-toggler-icon"></span>
    </button>
    
    <div class="collapse navbar-collapse" id="navMenu">
      <ul class="navbar-nav ml-auto">
        <li class="nav-item">
          <a class="nav-link" href="/cashbook/Form/categoryList.jsp">카테고리 관리</a>
        </li>
        <li class="nav-item">
                    <a class="nav-link" href="/cashbook/Form/monthList.jsp">달력 보기</a> <!-- 👈 달력 메뉴 추가 -->
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/cashbook/Form/statistics.jsp">통계 보기</a>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="adminMenu" role="button" data-toggle="dropdown">
            관리자 <%=admin %>
          </a>
          <div class="dropdown-menu dropdown-menu-right">
            <a class="dropdown-item" href="/cashbook/Form/updateAdminPwForm.jsp">비밀번호 변경</a>
            <div class="dropdown-divider"></div>
            <a class="dropdown-item text-danger" href="/cashbook/Action/logout.jsp">로그아웃</a>
          </div>
        </li>
      </ul>
    </div>
  </div>
</nav>
