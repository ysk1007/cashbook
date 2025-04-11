<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*" %>
<%@ page import="dto.*" %>

<%
	// requset 값 받기
	int num = Integer.parseInt(request.getParameter("num"));
	String kind = request.getParameter("kind");
	String title = request.getParameter("title");
	
	// Category Model
	Category ct = new Category();
	ct.setCategoryNo(num);
	ct.setKind(kind);
	ct.setTitle(title);
	
	CategoryDao ctDao = new CategoryDao();
	
	// ctDao.updateCategory(카테고리) -> update 쿼리를 실행해서 성공 유무를 반환 함
	if(ctDao.updateCategory(ct)){	// 수정 성공
		
		// 리스트로
		response.sendRedirect("/cashbook/Form/categoryList.jsp");
	}
	else{	// 수정 실패
		
		// 다시 수정 페이지로
		response.sendRedirect("/cashbook/Form/updateCategoryTitleForm?num="+num);
	}
	
%>