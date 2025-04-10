<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>

<%
	int lastDate, dayOfWeek, startBlank, endBlank, totalCell;
	Calendar cal = Calendar.getInstance();

	cal.set(Calendar.DATE, 1);
	if(request.getParameter("year") != null){
		cal.set(Calendar.YEAR, Integer.parseInt(request.getParameter("year")));
	}
	if(request.getParameter("month") != null){
		cal.set(Calendar.MONTH, Integer.parseInt(request.getParameter("month")));
	}

	lastDate = cal.getActualMaximum(Calendar.DATE);
	dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
	startBlank = dayOfWeek - 1;
	endBlank = 0;
	totalCell = startBlank + lastDate;
	if(totalCell % 7 != 0){
		endBlank = 7 - (totalCell % 7);
		totalCell += endBlank;
	}
	int year = cal.get(Calendar.YEAR);
	int month = cal.get(Calendar.MONTH);

	CashDao cashDao = new CashDao();
	Map<String, ArrayList<Cash>> cashMap = cashDao.selectMonthList(year, month + 1);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부 달력</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
	.calendar-container {
		max-width: 1000px;
		margin: auto;
		background-color: #fff;
		border-radius: 12px;
		box-shadow: 0 4px 15px rgba(0,0,0,0.1);
	}
	.calendar-header {
		background-color: #f0f2f5;
		text-align: center;
		padding: 2rem;
		font-size: 2rem;
		font-weight: bold;
		border-bottom: 1px solid #dee2e6;
	}
	.calendar-table th {
		text-align: center;
		padding: 0.75rem;
		font-weight: 600;
		font-size: 1.1rem;
		background-color: #f9fafb;
	}
	.calendar-table td {
		height: 120px;
		vertical-align: top;
		padding: 0.6rem;
		background-color: #ffffff;
		position: relative;
		transition: background-color 0.2s ease;
	}
	.calendar-table td:hover {
		background-color: #f4f4f4;
	}
	.calendar-day-number a {
		text-decoration: none;
		color: #000;
		font-weight: bold;
	}
	.memo-badge {
		display: block;
		margin-top: 6px;
		font-size: 0.85rem;
		padding: 3px 7px;
		border-radius: 10px;
		color: white;
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
		background-color: #6c757d;
	}
	.memo-badge:hover {
		opacity: 0.9;
	}
	.btn-nav {
		width: 140px;
	}
</style>
</head>
<body class="bg-light">

<%@ include file="/inc/nav.jsp" %>

<div class="container py-5">
	<div class="calendar-container">
		<div class="calendar-header">
			<%= year %>년 <%= month + 1 %>월
		</div>
		<table class="table table-bordered calendar-table mb-0">
			<thead>
				<tr>
					<th class="text-danger">일</th>
					<th>월</th>
					<th>화</th>
					<th>수</th>
					<th>목</th>
					<th>금</th>
					<th class="text-primary">토</th>
				</tr>
			</thead>
			<tbody>
				<%
					for(int i = 1; i <= totalCell; i++) {
						if(i % 7 == 1) { %><tr><% }
						int day = i - startBlank;
						String formattedMonth = String.format("%02d", month + 1);
						String formattedDay = String.format("%02d", day);
						String formattedDate = year + "-" + formattedMonth + "-" + formattedDay;
				%>
				<td>
					<% if(day > 0 && day <= lastDate) { %>
						<div class="calendar-day-number">
							<a href="/cashbook/dateList.jsp?date=<%=formattedDate%>"><%=day%></a>
						</div>
						<% if (cashMap.containsKey(formattedDate)) {
							for (Cash c : cashMap.get(formattedDate)) {
						%>
							<a href="/cashbook/dateList.jsp?date=<%=formattedDate%>" class="memo-badge" style="background-color:<%=c.getColor()%>;">
								[<%=c.getKind()%>] <%=c.getTitle()%>
							</a>
						<% } } %>
					<% } %>
				</td>
				<% if(i % 7 == 0) { %></tr><% } } %>
			</tbody>
		</table>
		<div class="d-flex justify-content-between p-4">
			<a class="btn btn-outline-secondary btn-nav" href="/cashbook/monthList.jsp?year=<%=year%>&month=<%=month - 1%>">← 이전 달</a>
			<a class="btn btn-outline-secondary btn-nav" href="/cashbook/monthList.jsp?year=<%=year%>&month=<%=month + 1%>">다음 달 →</a>
		</div>
	</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
