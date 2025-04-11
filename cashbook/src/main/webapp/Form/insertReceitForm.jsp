<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// request 값 받기
    int cashNo = Integer.parseInt(request.getParameter("cashNo"));
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>영수증 첨부</title>
    <link href="/cashbook/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    <link href="/cashbook/css/sb-admin-2.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fc;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .receipt-form-container {
            max-width: 600px;
            margin: 80px auto;
            background-color: #ffffff;
            padding: 40px 35px;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        h3.title {
            font-weight: 700;
            color: #4e73df;
        }

        label.form-label {
            font-weight: 600;
            color: #343a40;
        }

        .btn-primary {
            height: 48px;
            font-size: 1rem;
            font-weight: 600;
            border-radius: 10px;
        }

        .back-link {
            display: inline-block;
            margin-top: 16px;
            font-weight: 500;
            color: #6c757d;
            text-decoration: none;
            transition: color 0.2s;
        }

        .back-link:hover {
            color: #4e73df;
            text-decoration: underline;
        }
    </style>
</head>
<body id="page-top">
<jsp:include page="/inc/nav.jsp" />

<div class="container">
    <div class="receipt-form-container">
        <h3 class="title mb-4">🧾 영수증 첨부</h3>

        <form action="/cashbook/Action/insertReceitAction.jsp" method="post" enctype="multipart/form-data">
            <!-- cashNo 넘기기 -->
            <input type="hidden" name="cashNo" value="<%=cashNo%>">

            <!-- 파일 업로드 -->
            <div class="mb-3">
                <label class="form-label">영수증 파일 선택</label>
                <input type="file" name="receiptFile" class="form-control" accept="image/*,.pdf" required>
                <small class="text-muted">이미지(jpg, png 등) 또는 PDF 파일 업로드 가능</small>
            </div>

            <!-- 제출 -->
            <div class="d-grid">
                <button type="submit" class="btn btn-primary">업로드</button>
            </div>

            <!-- 뒤로가기 -->
            <a class="back-link" href="/cashbook/Form/cashOne.jsp?cashNo=<%=cashNo%>">
                ← 뒤로가기
            </a>
        </form>
    </div>
</div>

<!-- JS -->
<script src="/cashbook/vendor/jquery/jquery.min.js"></script>
<script src="/cashbook/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="/cashbook/vendor/jquery-easing/jquery.easing.min.js"></script>
<script src="/cashbook/js/sb-admin-2.min.js"></script>
</body>
</html>
