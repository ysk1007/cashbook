<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%
	// requset 값 받기
	// 날짜 형태
	String targetDate = request.getParameter("date"); // 2025-00-00
	
	// 수입/지출
	String kind = "수입";
	if(request.getParameter("kind") != null){
		kind = request.getParameter("kind");
	}
	
	int categoryNo = 0;
	
	if(request.getParameter("categoryNo") != null){
		categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	}
	
	// 카테고리 Model
	CategoryDao ctDao = new CategoryDao();
	
	// 내가 만든 카테고리들을 가져옴 ex) [수입or지출] (내용)
	ArrayList<Category> ctList = ctDao.selectCategoryValue(kind);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수입/지출 내역 추가</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
	body {
		font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	}

	.form-container {
		max-width: 650px;
		margin: 60px auto;
		background-color: #ffffff;
		padding: 50px 40px;
		border-radius: 20px;
		box-shadow: 0 10px 25px rgba(0, 0, 0, 0.08);
		transition: all 0.3s ease-in-out;
	}

	.form-container:hover {
		box-shadow: 0 12px 30px rgba(0, 0, 0, 0.12);
	}

	.form-title {
		font-size: 2rem;
		font-weight: 700;
		color: #0d6efd;
	}

	label.form-label {
		font-weight: 600;
		color: #343a40;
	}

	input.form-control,
	select.form-select {
		height: 48px;
		border-radius: 10px;
	}

	input[type="color"] {
		padding: 0;
		width: 60px;
		height: 40px;
		border-radius: 8px;
	}

	.btn-lg {
		height: 50px;
		border-radius: 12px;
		font-size: 1.1rem;
		font-weight: 600;
	}
</style>
</head>
<body class="bg-light">
<%@ include file="/inc/nav.jsp" %>

<div class="container">
	<div class="form-container">
		<div class="text-center mb-4">
			<div class="form-title">수입 / 지출 내역 추가</div>
		</div>

		<!-- 수입/지출 선택 폼 -->
		<form method="post" action="/cashbook/Form/insertCashForm.jsp" class="mb-4">
			<input type="hidden" name="date" value="<%=targetDate%>">
			
			<div class="mb-3">
				<label class="form-label">분류 선택</label>
				<select class="form-select" name="kind" onchange="this.form.submit()" required>
					<option value="수입">수입</option>
					<option value="지출" <%=kind.equals("지출") ? "selected" : "" %>>지출</option>
				</select>
			</div>
			
			<div class="mb-3">
				<label class="form-label">카테고리</label>
				<!-- onchange="this.form.submit()"로 값 변경되면 폼 다시 로딩 -->
				<select class="form-select" name="categoryNo" onchange="this.form.submit()" required>
					<!-- 카테고리 출력 -->
					<%
						for(Category ct : ctList){
					%>	
						<!-- 선택된 값으로 체크 -->
						<option value="<%=ct.getCategoryNo()%>" <%=categoryNo == ct.getCategoryNo() ? "selected" : "" %>>[<%=ct.getKind()%>] <%=ct.getTitle()%></option>
					<%
						}
					%>
				</select>
			</div>
		</form>

		<!-- 수입/지출 추가 입력 폼 -->
		<form action="/cashbook/Action/insertCashAction.jsp" method="post">
			<input type="hidden" name="date" value="<%=targetDate%>">
			<input type="hidden" name="kind" value="<%=kind%>">
			<input type="hidden" name="categoryNo" value="<%=categoryNo%>">

			<div class="mb-3">
				<label class="form-label">날짜</label>
				<input class="form-control" type="date" name="cashDate" value="<%=targetDate%>" required>
			</div>

			<div class="mb-3">
				<label class="form-label">금액</label>
				<input class="form-control" type="number" name="amount" required placeholder="예: 50000">
			</div>

			<div class="mb-3">
				<label class="form-label">메모</label>
				<input class="form-control" type="text" name="memo" placeholder="내용을 입력하세요">
			</div>

			<div class="mb-4">
				<label class="form-label">라벨 색상</label>
				<input class="form-control form-control-color" type="color" name="color" value="#ff0000">
			</div>

			<div class="d-grid">
				<button class="btn btn-primary btn-lg" type="submit">내역 추가하기</button>
			</div>
		</form>
	</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
