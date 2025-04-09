<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	String login = "";
	if(request.getParameter("login") != null){	// 로그인 실패했을때 받는 값
		login = request.getParameter("login");
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<h1><%=login.equals("") ? "" : "로그인 실패"%></h1>
	<h1>로그인 페이지</h1>
	<form action="/cashbook/loginAction.jsp" method="post">
		아이디 : <input type="text" name="id">
		<br>
		비밀번호 : <input type="text" name="password">
		<button type="submit">로그인</button>
	</form>
</body>
</html>