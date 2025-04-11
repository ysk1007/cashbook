<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*" %>

<%
	// request 값 받기
	String id = request.getParameter("id");
	String pw = request.getParameter("password");
	
	// 디버깅
	//System.out.println(id);
	//System.out.println(pw);
	
	// admin DAO
	AdminDao adminDao = new AdminDao();
	
	// adminDao.login은 로그인 성공 유무에 따라 boolean 값 반환
	if(adminDao.login(id, pw)){	// 로그인 성공
		session.setAttribute("admin", id);	// 세션에 아이디 저장
		response.sendRedirect("/cashbook/Form/categoryList.jsp");
	}
	else{	// 로그인 실패
		response.sendRedirect("/cashbook/Form/loginForm.jsp?login=false");
	}
%>