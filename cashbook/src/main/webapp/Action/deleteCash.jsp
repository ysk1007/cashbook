<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%
	// request 값 받기
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	String date = request.getParameter("date");

	CashDao csDao = new CashDao();
	
	ReceitDao reDao = new ReceitDao();
	
	// 영수증 먼저 지우기
	reDao.deleteReceit(cashNo);
	
	// csDao.deleteCash(번호) -> delete 쿼리를 실행해서 성공 유무를 반환 함
	if(csDao.deleteCash(cashNo)){	// 삭제 성공
		
		// 리스트 페이지로
		response.sendRedirect("/cashbook/Form/dateList.jsp?date="+date);
	}
	else{	// 삭제 실패
		
		// 일단 리스트 페이지로
		response.sendRedirect("/cashbook/Form/dateList.jsp?date="+date);
	}
%>