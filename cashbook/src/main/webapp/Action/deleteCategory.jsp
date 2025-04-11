<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%
	// request 값 받기
	int num = Integer.parseInt(request.getParameter("num"));

	CategoryDao ctDao = new CategoryDao();
	
	// ctDao.deleteCategory(번호) -> delete 쿼리를 실행해서 성공 유무를 반환 함
	if(ctDao.deleteCategory(num)){	// 삭제 성공
		
		// 리스트 페이지로
		response.sendRedirect("/cashbook/Form/categoryList.jsp");
	}
	else{	// 삭제 실패
		
		// 일단 리스트 페이지로
		response.sendRedirect("/cashbook/Form/categoryList.jsp");
	}
%>