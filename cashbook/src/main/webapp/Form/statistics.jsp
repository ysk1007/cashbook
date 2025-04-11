<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*" %>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%
    int year = Calendar.getInstance().get(Calendar.YEAR);
    if(request.getParameter("year") != null){
        year = Integer.parseInt(request.getParameter("year"));
    }

    CashDao csDao = new CashDao();

    // 전체 통계
    ArrayList<HashMap<String,Object>> allStats = csDao.selectAllAmount();

    // 연도 통계
    ArrayList<HashMap<String,Object>> yearStats = csDao.selectYearAmount(year);

    // 숫자 포맷 (천 단위 콤마 + "원")
    NumberFormat nf = NumberFormat.getInstance();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>통계</title>
    <link href="/cashbook/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    <link href="/cashbook/css/sb-admin-2.min.css" rel="stylesheet">
</head>
<body id="page-top">
<%@ include file="/inc/nav.jsp" %> <!-- 상단 네비게이션 -->

<div class="container mt-5">
    <h3 class="text-gray-800 font-weight-bold mb-4">📊 수입/지출 통계</h3>

	    <!-- 연도 선택 폼 -->
	<form method="get" action="/cashbook/Form/statistics.jsp" class="form-inline justify-content-center mb-5">
	    <div class="input-group">
	        <div class="input-group-prepend">
	            <span class="input-group-text font-weight-bold bg-light">📅 연도</span>
	        </div>
	        <input type="number" name="year" value="<%=year%>" class="form-control text-center" style="width: 120px;" min="2000" max="2100">
	        <div class="input-group-append">
	            <button type="submit" class="btn btn-outline-primary">
	                <i class="fas fa-search mr-1"></i> 조회
	            </button>
	        </div>
	    </div>
	</form>
	
	<!-- 전체 통계 카드 -->
	<div class="card mb-5 shadow-sm">
	    <div class="card-header bg-primary text-white d-flex align-items-center">
	        <i class="fas fa-chart-pie mr-2"></i> 전체 수입/지출 통계
	    </div>
	    <div class="card-body p-0">
	        <table class="table table-bordered text-center table-hover mb-0">
	            <thead class="thead-light">
	                <tr>
	                    <th>분류</th>
	                    <th>건수</th>
	                    <th>총액</th>
	                </tr>
	            </thead>
	            <tbody>
	                <% for(HashMap<String,Object> map : allStats) {
	                    Number amount = (Number)map.get("amount");
	                    String formattedAmount = nf.format(amount.longValue()) + " 원";
	                %>
	                    <tr>
	                        <td><%= map.get("kind") %></td>
	                        <td><%= map.get("count") %></td>
	                        <td><%= formattedAmount %></td>
	                    </tr>
	                <% } %>
	            </tbody>
	        </table>
	    </div>
	</div>
	
	<!-- 연도별 통계 카드 -->
	<div class="card mb-5 shadow-sm">
	    <div class="card-header bg-success text-white d-flex align-items-center">
	        <i class="fas fa-calendar-alt mr-2"></i> <%= year %>년 수입/지출 통계
	    </div>
	    <div class="card-body p-0">
	        <table class="table table-bordered text-center table-hover mb-0">
	            <thead class="thead-light">
	                <tr>
	                    <th>연도</th>
	                    <th>분류</th>
	                    <th>건수</th>
	                    <th>총액</th>
	                </tr>
	            </thead>
	            <tbody>
	                <% for(HashMap<String,Object> map : yearStats) {
	                    Number amount = (Number)map.get("amount");
	                    String formattedAmount = nf.format(amount.longValue()) + " 원";
	                %>
	                    <tr>
	                        <td><%= map.get("year") %></td>
	                        <td><%= map.get("kind") %></td>
	                        <td><%= map.get("count") %></td>
	                        <td><%= formattedAmount %></td>
	                    </tr>
	                <% } %>
	            </tbody>
	        </table>
	    </div>
	</div>


<!-- JS -->
<script src="/cashbook/vendor/jquery/jquery.min.js"></script>
<script src="/cashbook/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="/cashbook/vendor/jquery-easing/jquery.easing.min.js"></script>
<script src="/cashbook/js/sb-admin-2.min.js"></script>
</body>
</html>
