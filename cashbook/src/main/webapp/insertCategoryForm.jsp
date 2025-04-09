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
	<h1>카테고리 추가</h1>
	
	<form action="/cashbook/insertCategoryAction.jsp" method="post">
	<table border="1">
		<tr>
			<th>분류</th>
			<td><input type="radio" name="kind" value="수입"> 수입 <input type="radio" name="kind" value="지출"> 지출</td>
		</tr>
		<tr>
			<th>제목</th>
			<td><input type="text" name="title"></td>
		</tr>
	</table>
	<button type="submit">추가</button>
	</form>
</body>
</html>