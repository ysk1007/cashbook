<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%
	String targetDate = request.getParameter("date"); // 2025-00-00
	CategoryDao ctDao = new CategoryDao();
	ArrayList<Category> ctList = ctDao.selectCategoryValue();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수입/지출 내역 추가</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
	.form-container {
		max-width: 600px;
		margin: 50px auto;
		background-color: #ffffff;
		padding: 30px;
		border-radius: 12px;
		box-shadow: 0 4px 10px rgba(0,0,0,0.1);
	}
</style>
</head>
<body class="bg-light">
<%@ include file="/inc/nav.jsp" %>
<div class="container">
	<div class="form-container">
		<h2 class="text-center mb-4">수입 / 지출 내역 추가</h2>
		<form action="/cashbook/insertCashAction.jsp" method="post">
			<div class="mb-3">
				<label class="form-label">날짜</label>
				<input class="form-control" type="date" name="cashDate" value="<%=targetDate%>" required>
			</div>
			<div class="mb-3">
				<label class="form-label">분류</label>
				<select class="form-select" name="kind" required>
					<option value="수입">수입</option>
					<option value="지출">지출</option>
				</select>
			</div>
			<div class="mb-3">
				<label class="form-label">카테고리</label>
				<select class="form-select" name="categoryNo">
					<%
						for(Category ct : ctList){
							%>
								<option value="<%=ct.getCategoryNo()%>">[<%=ct.getKind()%>] <%=ct.getTitle()%></option>
							<%
						}
					%>
				</select>
			</div>
			<div class="mb-3">
				<label class="form-label">금액</label>
				<input class="form-control" type="number" name="amount" required>
			</div>
			<div class="mb-3">
				<label class="form-label">메모</label>
				<input class="form-control" type="text" name="memo">
			</div>
			<div class="mb-3">
				<label class="form-label">라벨 색깔</label>
				<input class="form-control" type="color" name="color">
			</div>
			<div class="d-grid">
				<button class="btn btn-primary" type="submit">추가</button>
			</div>
		</form>
	</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
