<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	//로그인 되었는지 아닌지?
	String admin = (String)session.getAttribute("admin");

	if(admin == null){ // 로그인 상태가 아니라면
		response.sendRedirect("/cashbook/loginForm.jsp");
		return;
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<a href="/cashbook/updateAdminPwForm.jsp?admin=<%=admin%>">비밀번호 수정</a>
	&nbsp;
	<a href="/cashbook/logout.jsp">로그아웃</a>
</body>
</html>