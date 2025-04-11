<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>

<%
    // 로그인 확인
    String admin = (String)session.getAttribute("admin");
    if(admin == null){
        response.sendRedirect("/cashbook/loginForm.jsp");
        return;
    }

    // 요청 파라미터 값 받아오기
    int num = Integer.parseInt(request.getParameter("num"));

    // 카테고리 정보 가져오기
    CategoryDao ctDao = new CategoryDao();
    Category ct = ctDao.selectCategoryOne(num);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>카테고리 수정</title>
    <!-- SB Admin 2 스타일 -->
    <link href="/cashbook/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    <link href="/cashbook/css/sb-admin-2.min.css" rel="stylesheet">
</head>
<body id="page-top">

<jsp:include page="/inc/nav.jsp" />

<div class="container mt-5">
    <h3 class="mb-4 text-gray-800 font-weight-bold">✏️ 카테고리 수정</h3>

    <!-- 카테고리 수정 폼 -->
    <form action="/cashbook/updateCategoryTitleAction.jsp" method="post" class="card shadow p-4">
        <!-- 카테고리 번호 (숨김) -->
        <input type="hidden" name="num" value="<%=num%>">

        <div class="mb-3">
            <label class="form-label fw-semibold">분류</label><br>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="kind" value="수입" <%=ct.getKind().equals("수입") ? "checked" : "" %>>
                <label class="form-check-label">수입</label>
            </div>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="kind" value="지출" <%=ct.getKind().equals("지출") ? "checked" : "" %>>
                <label class="form-check-label">지출</label>
            </div>
        </div>

        <div class="mb-3">
            <label class="form-label fw-semibold">제목</label>
            <input type="text" name="title" class="form-control" value="<%=ct.getTitle()%>" required>
        </div>

        <div class="d-grid">
            <button type="submit" class="btn btn-primary">카테고리 수정</button>
        </div>
    </form>
</div>

<!-- SB Admin JS -->
<script src="/cashbook/vendor/jquery/jquery.min.js"></script>
<script src="/cashbook/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="/cashbook/vendor/jquery-easing/jquery.easing.min.js"></script>
<script src="/cashbook/js/sb-admin-2.min.js"></script>

</body>
</html>
