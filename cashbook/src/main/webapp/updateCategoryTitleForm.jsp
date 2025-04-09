<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="dto.*" %>
<%@ page import="model.*" %>

<%
	//로그인 되었는지 아닌지?
	String admin = (String)session.getAttribute("admin");

	if(admin == null){ // 로그인 상태가 아니라면
		response.sendRedirect("/cashbook/loginForm.jsp");
		return;
	}

	// request 값 받기
	int num = Integer.parseInt(request.getParameter("num"));
	
	Category ct = new Category();
	CategoryDao ctDao = new CategoryDao();
	
	// Category 상세 가져옴
	ct = ctDao.selectCategoryOne(num);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<h1>카테고리 수정</h1>
	
	<form action="/cashbook/updateCategoryTitleAction.jsp" method="post">
		<input type="hidden" name="num" value="<%=num%>">
		<table border="1">
			<tr>
				<th>분류</th>
				<td>
				<input type="radio" name="kind" value="수입" <%=ct.getKind().equals("수입") ? "checked" : "" %>> 수입 
				<input type="radio" name="kind" value="지출" <%=ct.getKind().equals("지출") ? "checked" : "" %>> 지출
				</td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" name="title" value="<%=ct.getTitle()%>"></td>
			</tr>
		</table>
		<button type="submit">수정</button>
	</form>
</body>
</html>