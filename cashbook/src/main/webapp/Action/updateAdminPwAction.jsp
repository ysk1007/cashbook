<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*" %>

<%
	// requset 값 받기
	String admin = request.getParameter("admin");
	String pw = request.getParameter("pw");
	String newPw = request.getParameter("newPw");

	// adminDao model
	AdminDao adminDao = new AdminDao();
	
	// admin.updatePw(계정, 기존 비밀번호, 새로운 비밀번호) -> update 쿼리를 실행해서 성공 유무를 반환 함
	if(adminDao.updatePw(admin, pw, newPw)){	// 수정 성공
		
		// 로그인 폼으로
		response.sendRedirect("/cashbook/Form/loginForm.jsp");
	}
	else{	// 수정 실패
		
		// 다시 수정 페이지로
		response.sendRedirect("/cashbook/Form/updateAdminPwForm.jsp?admin="+admin);
	}
	
%>