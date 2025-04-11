<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%
	//requset 값 받기
	String cashDate = request.getParameter("cashDate");
	String kind = request.getParameter("kind");
	
	// 임시
	int category = Integer.parseInt(request.getParameter("categoryNo"));
	int amount = Integer.parseInt(request.getParameter("amount"));
	String memo = request.getParameter("memo");
	String color = request.getParameter("color");
	
	Cash cs = new Cash();
	cs.setCashDate(cashDate);
	cs.setKind(kind);
	cs.setCategoryNo(category);
	cs.setAmount(amount);
	cs.setMemo(memo);
	cs.setColor(color);
	
	CashDao cashDao = new CashDao();
	
	// 캐쉬 모델에서 insert 쿼리 실행
	cashDao.insertCash(cs);
	
	response.sendRedirect("/cashbook/Form/dateList.jsp?date="+cashDate);
%>