<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ include file="/inc/nav.jsp" %>
<%
    String targetDate = request.getParameter("date");

    int year = Integer.parseInt(targetDate.substring(0,4));
    int month = Integer.parseInt(targetDate.substring(5,7)) - 1;
    int day = Integer.parseInt(targetDate.substring(8,10));

    CashDao cashDao = new CashDao();
    ArrayList<Cash> cashList = cashDao.selectCashList(targetDate);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%=targetDate%> 내역</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .date-title {
            font-size: 2rem;
            font-weight: 700;
            color: #0d6efd;
        }
        .btn-action {
            min-width: 140px;
        }
        .summary-box {
            background-color: #f8f9fa;
            padding: 1.2rem;
            border-radius: 10px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.05);
        }
    </style>
</head>
<body class="bg-light">
    <div class="container py-5">
        <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 gap-3">
            <div class="date-title"><%=targetDate%> 내역</div>
            <div class="d-flex gap-2">
                <a href="/cashbook/insertCashForm.jsp?date=<%=targetDate%>" class="btn btn-outline-primary btn-action">내역 추가</a>
                <a href="/cashbook/monthList.jsp?year=<%=year%>&month=<%=month%>" class="btn btn-outline-secondary btn-action">달력으로 돌아가기</a>
            </div>
        </div>

        <div class="table-responsive">
            <table class="table table-bordered table-hover bg-white shadow-sm text-center align-middle">
                <thead class="table-primary">
                    <tr>
                        <th>구분</th>
                        <th>카테고리</th>
                        <th>금액</th>
                        <th>작성일</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int totalIncome = 0;
                        int totalExpense = 0;
                        for(Cash c : cashList){
                            if(c.getKind().equals("수입")) totalIncome += c.getAmount();
                            else totalExpense += c.getAmount();
                    %>
                    <tr>
                        <td><%=c.getKind()%></td>
                        <td><%=c.getTitle()%></td>
                        <td><%=String.format("%,d원", c.getAmount())%></td>
                        <td><%=c.getCreateDate()%></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>

        <div class="summary-box mt-4">
            <div class="row text-center">
                <div class="col-md-4 mb-2">
                    <h5 class="text-success">총 수입</h5>
                    <p class="fs-5 fw-bold"><%=String.format("%,d원", totalIncome)%></p>
                </div>
                <div class="col-md-4 mb-2">
                    <h5 class="text-danger">총 지출</h5>
                    <p class="fs-5 fw-bold"><%=String.format("%,d원", totalExpense)%></p>
                </div>
                <div class="col-md-4 mb-2">
                    <h5 class="text-dark">잔액</h5>
                    <p class="fs-5 fw-bold"><%=String.format("%,d원", totalIncome - totalExpense)%></p>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
