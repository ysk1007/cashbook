<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%
	// 로그인 되었는지 아닌지?
	String admin = (String)session.getAttribute("admin");

	if(admin == null){ // 로그인 상태가 아니라면
		response.sendRedirect("/cashbook/loginForm.jsp");
		return;
	}
	
	int currentPage = 1;	// 현재 페이지
	int rowPerPage = 8;		// 한 페이지에 보여줄 데이터 수
	int lastPage = 0;
	
	// request 값 받기
	String kind = "";
	String title = "";
	
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	if(request.getParameter("kind") != null){
		kind = request.getParameter("kind");
	}
	
	if(request.getParameter("title") != null){
		title = request.getParameter("title");
	}
	
	// 페이징 클래스
	Paging p = new Paging();
	p.setCurrentPage(currentPage);
	p.setRowPerPage(rowPerPage);
	
	// 카테고리 모델
	CategoryDao ctDao = new CategoryDao();
	
	// 카테고리 리스트
	ArrayList<Category> ctList = new ArrayList<>();
	
	ctList = ctDao.selectCategoryList(p,kind, title);
	int totalRow = ctDao.selectListRow(kind, title);
	lastPage = p.getLastPage(totalRow);
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
	
	<div>
		<a href="/cashbook/insertCategoryForm.jsp">카테고리 추가</a>
	</div>

	<table border="1">
		<tr>
			<th>카테고리 번호</th>
			<th>분류</th>
			<th>제목</th>
			<th>생성일</th>
			<th>카테고리 수정</th>
			<th>카테고리 삭제</th>
		</tr>
		<%
			for(Category ct : ctList){
				%>
				<tr>
					<td><%=ct.getCategoryNo()%></td>
					<td><%=ct.getKind()%></td>
					<td><%=ct.getTitle()%></td>
					<td><%=ct.getCreateDate()%></td>
					<td><a href="/cashbook/updateCategoryTitleForm.jsp?num=<%=ct.getCategoryNo()%>">수정</a></td>
					<td><a href="/cashbook/deleteCategory.jsp?num=<%=ct.getCategoryNo()%>">삭제</a></td>
				</tr>
				<%
			}
		%>
	</table>
	<form action="/cashbook/categoryList.jsp" method="post">
		<div>
        <select name="kind">
        	<option value="" >전체</option>
            <option value="수입" <%= kind.equals("수입") ? "selected" : "" %>>수입</option>
            <option value="지출" <%= kind.equals("지출") ? "selected" : "" %>>지출</option>
        </select>
        <input type="text" name="title" value="<%=title%>">
        <button type="submit">검색</button>
    	</div>
	</form>
	
	<!-- 네비게이션 -->
	<a href="/cashbook/categoryList.jsp?currentPage=1&kind=<%=kind%>&title=<%=title%>">처음</a>
	<%
		if(currentPage > 1){
			%><a href="/cashbook/categoryList.jsp?currentPage=<%=currentPage - 1%>&kind=<%=kind%>&title=<%=title%>">이전</a><%
		}
	%>
	<%=currentPage%>/<%=lastPage%>
	<%
		if(currentPage < lastPage){
			%><a href="/cashbook/categoryList.jsp?currentPage=<%=currentPage + 1%>&kind=<%=kind%>&title=<%=title%>">다음</a><%
		}
	%>
	<a href="/cashbook/categoryList.jsp?currentPage=<%=lastPage%>&kind=<%=kind%>&title=<%=title%>">마지막</a>
</body>
</html>