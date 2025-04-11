<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*" %>

<%
	// 세션 초기화
	session.invalidate();
	response.sendRedirect("/cashbook/Form/loginForm.jsp");
%>