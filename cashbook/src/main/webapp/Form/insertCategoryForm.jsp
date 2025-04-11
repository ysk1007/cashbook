<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/inc/nav.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리 추가</title>
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
<div class="container">
	<div class="form-container">
		<h2 class="text-center mb-4">카테고리 추가</h2>
		<form action="/cashbook/Action/insertCategoryAction.jsp" method="post">
			<div class="mb-3">
				<label class="form-label">분류</label><br>
				<div class="form-check form-check-inline">
					<input class="form-check-input" type="radio" name="kind" value="수입" checked required>
					<label class="form-check-label">수입</label>
				</div>
				<div class="form-check form-check-inline">
					<input class="form-check-input" type="radio" name="kind" value="지출" required>
					<label class="form-check-label">지출</label>
				</div>
			</div>
			<div class="mb-3">
				<label class="form-label">제목</label>
				<input class="form-control" type="text" name="title" required>
			</div>
			<div class="d-grid">
				<button class="btn btn-primary" type="submit">추가</button>
			</div>
		</form>
	</div>
</div>

<!-- JS -->
<script src="/cashbook/vendor/jquery/jquery.min.js"></script>
<script src="/cashbook/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="/cashbook/vendor/jquery-easing/jquery.easing.min.js"></script>
<script src="/cashbook/js/sb-admin-2.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
