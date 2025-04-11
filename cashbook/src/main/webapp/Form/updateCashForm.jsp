<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%
	// requset 값 받기
	int cashNo = 0;
	if(request.getParameter("cashNo") != null){
		cashNo = Integer.parseInt(request.getParameter("cashNo"));
	}

	CashDao cashDao = new CashDao();
	CategoryDao ctDao = new CategoryDao();

	HashMap<String,Object> map = cashDao.selectCashOne(cashNo);

	String kind = map.get("kind").toString();
	if(request.getParameter("kind") != null){
		kind = request.getParameter("kind");
	}

	int categoryNo = Integer.parseInt(map.get("categoryNo").toString());
	if(request.getParameter("categoryNo") != null){
		categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	}

	String targetDate = map.get("cashDate").toString();

	ArrayList<Category> ctList = ctDao.selectCategoryValue(kind);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수입/지출 내역 수정</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
	.form-container {
		max-width: 700px;
		margin: 60px auto;
		background-color: #fff;
		padding: 40px;
		border-radius: 16px;
		box-shadow: 0 6px 24px rgba(0, 0, 0, 0.08);
	}
	.form-title {
		font-size: 2rem;
		font-weight: bold;
		color: #0d6efd;
	}
</style>
</head>
<body class="bg-light">
<%@ include file="/inc/nav.jsp" %>

<div class="container">
	<div class="form-container">
		<div class="text-center mb-4">
			<div class="form-title">수입 / 지출 내역 수정</div>
		</div>

		<!-- 수입/지출 선택 폼 -->
		<form method="post" action="/cashbook/Form/updateCashForm.jsp" class="row g-3 mb-4">
			<input type="hidden" name="date" value="<%=targetDate%>">
			<input type="hidden" name="cashNo" value="<%=cashNo%>">
			
			<div class="col-md-6">
				<label class="form-label fw-semibold">분류 선택</label>
				<select class="form-select" name="kind" onchange="this.form.submit()" required>
					<option value="수입" <%=kind.equals("수입") ? "selected" : "" %>>수입</option>
					<option value="지출" <%=kind.equals("지출") ? "selected" : "" %>>지출</option>
				</select>
			</div>
			
			<div class="col-md-6">
				<label class="form-label fw-semibold">카테고리</label>
				<select class="form-select" name="categoryNo" onchange="this.form.submit()" required>
					<% for(Category ct : ctList) { %>
						<option value="<%=ct.getCategoryNo()%>" <%=categoryNo == ct.getCategoryNo() ? "selected" : "" %>>[<%=ct.getKind()%>] <%=ct.getTitle()%></option>
					<% } %>
				</select>
			</div>
		</form>

		<!-- 수입/지출 수정 폼 -->
		<form action="/cashbook/Action/updateCashAction.jsp" method="post" class="row g-3">
			<input type="hidden" name="date" value="<%=map.get("cashDate")%>">
			<input type="hidden" name="kind" value="<%=kind%>">
			<input type="hidden" name="categoryNo" value="<%=categoryNo%>">
			<input type="hidden" name="cashNo" value="<%=cashNo%>">

			<div class="col-md-6">
				<label class="form-label fw-semibold">날짜</label>
				<input class="form-control" type="date" name="cashDate" value="<%=map.get("cashDate")%>" readonly>
			</div>

			<div class="col-md-6">
				<label class="form-label fw-semibold">금액</label>
				<input class="form-control" type="number" name="amount" required value="<%=map.get("amount")%>">
			</div>

			<div class="col-12">
				<label class="form-label fw-semibold">메모</label>
				<input class="form-control" type="text" name="memo" value="<%=map.get("memo")%>">
			</div>

			<div class="col-12">
				<label class="form-label fw-semibold">라벨 색상</label>
				<input class="form-control form-control-color" type="color" name="color" value="<%=map.get("color")%>">
			</div>

			<div class="col-12 d-grid">
				<button class="btn btn-primary btn-lg" type="submit">내역 수정하기</button>
			</div>
		</form>
	</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
