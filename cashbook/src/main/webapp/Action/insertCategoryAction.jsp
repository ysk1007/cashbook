<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%
	// requset 값 받기
	String title = request.getParameter("title");
	String kind = request.getParameter("kind");
	
	Category ct = new Category();
	CategoryDao ctDao = new CategoryDao();
	
	ct.setTitle(title);
	ct.setKind(kind);
	
	// 카테고리 모델에서 insert 쿼리 실행
	ctDao.insertCategory(ct);
	
	response.sendRedirect("/cashbook/Form/categoryList.jsp");
%>