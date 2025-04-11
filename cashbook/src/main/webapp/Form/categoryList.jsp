<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%
    String admin = (String)session.getAttribute("admin");
    if(admin == null){
        response.sendRedirect("/cashbook/Form/loginForm.jsp");
        return;
    }

    int currentPage = 1;
    int rowPerPage = 8;
    int lastPage = 0;

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

    Paging p = new Paging();
    p.setCurrentPage(currentPage);
    p.setRowPerPage(rowPerPage);

    CategoryDao ctDao = new CategoryDao();
    ArrayList<Category> ctList = ctDao.selectCategoryList(p, kind, title);
    int totalRow = ctDao.selectListRow(kind, title);
    lastPage = p.getLastPage(totalRow);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>카테고리 목록</title>
    <link href="/cashbook/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    <link href="/cashbook/css/sb-admin-2.min.css" rel="stylesheet">
</head>
<body id="page-top">
<jsp:include page="/inc/nav.jsp" />

<div class="container mt-5">
    <h3 class="mb-4 font-weight-bold text-gray-800">📂 카테고리 목록</h3>

    <div class="d-flex justify-content-between mb-3">
        <div>
            <a href="/cashbook/Form/insertCategoryForm.jsp" class="btn btn-primary btn-sm">
                <i class="fas fa-plus"></i> 카테고리 추가
            </a>
            <a href="/cashbook/Form/monthList.jsp" class="btn btn-outline-secondary btn-sm">
                <i class="fas fa-calendar-alt"></i> 달력으로 이동
            </a>
        </div>
    </div>

    <form action="/cashbook/Form/categoryList.jsp" method="post" class="form-inline mb-3">
        <div class="form-group mr-2">
            <select name="kind" class="form-control">
                <option value="">전체</option>
                <option value="수입" <%= kind.equals("수입") ? "selected" : "" %>>수입</option>
                <option value="지출" <%= kind.equals("지출") ? "selected" : "" %>>지출</option>
            </select>
        </div>
        <div class="form-group mr-2">
            <input type="text" name="title" class="form-control" placeholder="제목 검색" value="<%=title%>">
        </div>
        <button type="submit" class="btn btn-outline-primary btn-sm">
            <i class="fas fa-search"></i> 검색
        </button>
    </form>

    <div class="card shadow-sm">
        <div class="card-body p-0">
            <table class="table table-hover mb-0 text-center">
                <thead class="thead-light">
                    <tr>
                        <th>번호</th>
                        <th>분류</th>
                        <th>제목</th>
                        <th>생성일</th>
                        <th>수정</th>
                        <th>삭제</th>
                    </tr>
                </thead>
                <tbody>
                <% for(Category ct : ctList){ %>
                    <tr>
                        <td><%=ct.getCategoryNo()%></td>
                        <td><%=ct.getKind()%></td>
                        <td><%=ct.getTitle()%></td>
                        <td><%=ct.getCreateDate()%></td>
                        <td>
                            <a href="/cashbook/Form/updateCategoryTitleForm.jsp?num=<%=ct.getCategoryNo()%>" class="btn btn-sm btn-warning">
                                <i class="fas fa-edit"></i> 수정
                            </a>
                        </td>
                        <td>
                            <a href="/cashbook/Action/deleteCategory.jsp?num=<%=ct.getCategoryNo()%>" class="btn btn-sm btn-danger">
                                <i class="fas fa-trash-alt"></i> 삭제
                            </a>
                        </td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Pagination -->
    <div class="d-flex justify-content-center mt-4">
        <div class="btn-group" role="group" aria-label="Pagination">
            <a class="btn btn-outline-secondary btn-sm" href="/cashbook/Form/categoryList.jsp?currentPage=1&kind=<%=kind%>&title=<%=title%>">처음</a>
            <% if(currentPage > 1){ %>
                <a class="btn btn-outline-secondary btn-sm" href="/cashbook/Form/categoryList.jsp?currentPage=<%=currentPage - 1%>&kind=<%=kind%>&title=<%=title%>">이전</a>
            <% } %>
            <span class="btn btn-light btn-sm disabled"><%=currentPage%> / <%=lastPage%></span>
            <% if(currentPage < lastPage){ %>
                <a class="btn btn-outline-secondary btn-sm" href="/cashbook/Form/categoryList.jsp?currentPage=<%=currentPage + 1%>&kind=<%=kind%>&title=<%=title%>">다음</a>
            <% } %>
            <a class="btn btn-outline-secondary btn-sm" href="/cashbook/Form/categoryList.jsp?currentPage=<%=lastPage%>&kind=<%=kind%>&title=<%=title%>">마지막</a>
        </div>
    </div>
</div>

<!-- SB Admin JS -->
<script src="/cashbook/vendor/jquery/jquery.min.js"></script>
<script src="/cashbook/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="/cashbook/vendor/jquery-easing/jquery.easing.min.js"></script>
<script src="/cashbook/js/sb-admin-2.min.js"></script>
</body>
</html>
