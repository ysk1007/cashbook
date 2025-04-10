<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String login = "";
    if(request.getParameter("login") != null){
        login = request.getParameter("login");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인 | Cashbook</title>
    <link href="/cashbook/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    <link href="/cashbook/css/sb-admin-2.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(to right, #4e73df, #224abe);
        }
        .login-card {
            max-width: 400px;
            margin: auto;
            margin-top: 100px;
        }
        .login-logo {
            font-size: 2rem;
            font-weight: 700;
            color: #4e73df;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="login-card card shadow-lg border-0">
        <div class="card-body p-5">
            <div class="text-center mb-4">
                <div class="login-logo">💰 Cashbook</div>
                <h4 class="text-gray-900 mt-3">로그인</h4>
            </div>

            <% if(!login.equals("")) { %>
                <div class="alert alert-danger text-center" role="alert">
                    ❗ 로그인 실패: 아이디 또는 비밀번호를 확인해주세요.
                </div>
            <% } %>

            <form class="user" action="/cashbook/loginAction.jsp" method="post">
                <div class="form-group">
                    <input type="text" name="id" class="form-control form-control-user" placeholder="아이디 입력" required>
                </div>
                <div class="form-group">
                    <input type="password" name="password" class="form-control form-control-user" placeholder="비밀번호 입력" required>
                </div>
                <button type="submit" class="btn btn-primary btn-user btn-block">
                    로그인
                </button>
            </form>
        </div>
    </div>
</div>

<!-- JS -->
<script src="/cashbook/vendor/jquery/jquery.min.js"></script>
<script src="/cashbook/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="/cashbook/vendor/jquery-easing/jquery.easing.min.js"></script>
<script src="/cashbook/js/sb-admin-2.min.js"></script>
</body>
</html>
