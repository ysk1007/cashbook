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

    // 월 통계
    ArrayList<HashMap<String,Object>> monthStats = csDao.selectMonthAmount(year);
    ArrayList<HashMap<String,Object>> monthStatsIncome = new ArrayList<>();
    ArrayList<HashMap<String,Object>> monthStatsExpense = new ArrayList<>();
    for (HashMap<String,Object> map : monthStats) {
        if ("수입".equals(map.get("kind"))) {
            monthStatsIncome.add(map);
        } else {
            monthStatsExpense.add(map);
        }
    }

    // 카테고리 통계
    ArrayList<HashMap<String,Object>> ctStats = csDao.selectCategoryAmount(year);
    ArrayList<HashMap<String,Object>> ctStatsIncome = new ArrayList<>();
    ArrayList<HashMap<String,Object>> ctStatsExpense = new ArrayList<>();
    for (HashMap<String,Object> map : ctStats) {
        if ("수입".equals(map.get("kind"))) {
            ctStatsIncome.add(map);
        } else {
            ctStatsExpense.add(map);
        }
    }

    // 숫자 포맷
    NumberFormat nf = NumberFormat.getInstance();

    // 월별 수입 데이터 처리
    int[] incomeData = new int[12];
    for (int i = 0; i < monthStatsIncome.size(); i++) {
        HashMap<String, Object> map = monthStatsIncome.get(i);
        int month = (Integer) map.get("month");
        int amount = (Integer) map.get("amount");
        incomeData[month - 1] = amount;
    }
    
    int[] expenseData = new int[12];  // 12개월
	for (int i = 0; i < monthStatsExpense.size(); i++) {
	    HashMap<String, Object> map = monthStatsExpense.get(i);
	    int month = (Integer) map.get("month");
	    int amount = (Integer) map.get("amount");
	    expenseData[month - 1] = amount;
	}
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>통계</title>
    <link href="/cashbook/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    <link href="/cashbook/css/sb-admin-2.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script> <!-- 차트.js 로드 -->
</head>
<body id="page-top">
<%@ include file="/inc/nav.jsp" %>

<div class="container mt-5">
    <h3 class="text-gray-800 font-weight-bold mb-4">📊 수입/지출 통계</h3>

    <!-- 연도 선택 -->
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

    <!-- 차트 -->
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">범위 차트</h6>
        </div>
        <div class="card-body">
            <div class="chart-area">
                <canvas id="myAreaChart"></canvas>
            </div>
        </div>
    </div>

    <!-- 차트 스크립트 -->
    <script>
        var monthlyIncomeData = <%= Arrays.toString(incomeData) %>;
        var monthlyExpenseData = <%= Arrays.toString(expenseData) %>;

        var ctx = document.getElementById("myAreaChart");
        var myLineChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
                datasets: [{
                    label: "수입",
                    lineTension: 0.3,
                    backgroundColor: "rgba(78, 115, 223, 0.05)",
                    borderColor: "rgba(78, 115, 223, 1)",
                    pointRadius: 3,
                    pointBackgroundColor: "rgba(78, 115, 223, 1)",
                    pointBorderColor: "rgba(78, 115, 223, 1)",
                    pointHoverRadius: 3,
                    pointHoverBackgroundColor: "rgba(78, 115, 223, 1)",
                    pointHoverBorderColor: "rgba(78, 115, 223, 1)",
                    pointHitRadius: 10,
                    pointBorderWidth: 2,
                    data: monthlyIncomeData,
                },
           		{
                 	  label: "지출",
                    lineTension: 0.3,
                    backgroundColor: "rgba(255, 99, 132, 0.05)",
                    borderColor: "rgba(255, 99, 132, 1)",
                    pointRadius: 3,
                    pointBackgroundColor: "rgba(78, 115, 223, 1)",
                    pointBorderColor: "rgba(78, 115, 223, 1)",
                    pointHoverRadius: 3,
                    pointHoverBackgroundColor: "rgba(78, 115, 223, 1)",
                    pointHoverBorderColor: "rgba(78, 115, 223, 1)",
                    pointHitRadius: 10,
                    pointBorderWidth: 2,
                    data: monthlyExpenseData,
                  	},],
            },
            options: {
                maintainAspectRatio: false,
                layout: {
                    padding: { left: 10, right: 25, top: 25, bottom: 0 }
                },
                scales: {
                    x: {
                        grid: { display: false },
                        ticks: { maxTicksLimit: 12 }
                    },
                    y: {
                        ticks: {
                            callback: function(value) {
                                return '₩' + value.toLocaleString();
                            }
                        },
                        grid: {
                            color: "rgb(234, 236, 244)",
                            zeroLineColor: "rgb(234, 236, 244)"
                        }
                    }
                },
                plugins: {
                    legend: { display: false },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                return '수입: ₩' + context.parsed.y.toLocaleString();
                            }
                        }
                    }
                }
            }
        });
    </script>
	
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
	
	<!-- 월별 수입/지출 통계 (가로 정렬) -->
	<div class="row mb-5">
	    <!-- 수입 통계 카드 -->
	    <div class="col-md-6 mb-4">
	        <div class="card shadow-sm h-100">
	            <div class="card-header bg-primary text-white d-flex align-items-center">
	                <i class="fas fa-coins mr-2"></i> <%= year %>년 월별 <strong>수입</strong> 통계
	            </div>
	            <div class="card-body p-0">
	                <table class="table table-bordered text-center table-hover mb-0">
	                    <thead class="thead-light">
	                        <tr>
	                            <th>월</th>
	                            <th>건수</th>
	                            <th>금액</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                        <% for(HashMap<String,Object> map : monthStatsIncome) {
	                            Number amount = (Number)map.get("amount");
	                            String formattedAmount = nf.format(amount.longValue()) + " 원";
	                        %>
	                            <tr>
	                                <td><%= map.get("month") %> 월</td>
	                                <td><%= map.get("count") %></td>
	                                <td><%= formattedAmount %></td>
	                            </tr>
	                        <% } %>
	                    </tbody>
	                </table>
	            </div>
	        </div>
	    </div>
	
	    <!-- 지출 통계 카드 -->
	    <div class="col-md-6 mb-4">
	        <div class="card shadow-sm h-100">
	            <div class="card-header bg-danger text-white d-flex align-items-center">
	                <i class="fas fa-wallet mr-2"></i> <%= year %>년 월별 <strong>지출</strong> 통계
	            </div>
	            <div class="card-body p-0">
	                <table class="table table-bordered text-center table-hover mb-0">
	                    <thead class="thead-light">
	                        <tr>
	                            <th>월</th>
	                            <th>건수</th>
	                            <th>금액</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                        <% for(HashMap<String,Object> map : monthStatsExpense) {
	                            Number amount = (Number)map.get("amount");
	                            String formattedAmount = nf.format(amount.longValue()) + " 원";
	                        %>
	                            <tr>
	                                <td><%= map.get("month") %> 월</td>
	                                <td><%= map.get("count") %></td>
	                                <td><%= formattedAmount %></td>
	                            </tr>
	                        <% } %>
	                    </tbody>
	                </table>
	            </div>
	        </div>
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
	                        <td><%= map.get("kind") %></td>
	                        <td><%= map.get("count") %></td>
	                        <td><%= formattedAmount %></td>
	                    </tr>
	                <% } %>
	            </tbody>
	        </table>
	    </div>
	</div>
	
		<!-- 연도별 카테고리별 통계 가로 정렬 -->
	<div class="row mb-5">
	    <!-- 수입 통계 카드 -->
	    <div class="col-md-6">
	        <div class="card shadow-sm h-100">
	            <div class="card-header bg-info text-white d-flex align-items-center">
	                <i class="fas fa-list-alt mr-2"></i> <%= year %>년 카테고리별 수입 통계
	            </div>
	            <div class="card-body p-0">
	                <table class="table table-bordered text-center table-hover mb-0">
	                    <thead class="thead-light">
	                        <tr>
	                            <th>카테고리</th>
	                            <th>총액</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                        <% for (HashMap<String,Object> map : ctStatsIncome) {
	                            Number amount = (Number)map.get("amount");
	                            String formattedAmount = nf.format(amount.longValue()) + " 원";
	                        %>
	                        <tr>
	                            <td><%= map.get("title") %></td>
	                            <td><%= formattedAmount %></td>
	                        </tr>
	                        <% } %>
	                    </tbody>
	                </table>
	            </div>
	        </div>
	    </div>
	
	    <!-- 지출 통계 카드 -->
	    <div class="col-md-6">
	        <div class="card shadow-sm h-100">
	            <div class="card-header bg-danger text-white d-flex align-items-center">
	                <i class="fas fa-list-alt mr-2"></i> <%= year %>년 카테고리별 지출 통계
	            </div>
	            <div class="card-body p-0">
	                <table class="table table-bordered text-center table-hover mb-0">
	                    <thead class="thead-light">
	                        <tr>
	                            <th>카테고리</th>
	                            <th>총액</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                        <% for (HashMap<String,Object> map : ctStatsExpense) {
	                            Number amount = (Number)map.get("amount");
	                            String formattedAmount = nf.format(amount.longValue()) + " 원";
	                        %>
	                        <tr>
	                            <td><%= map.get("title") %></td>
	                            <td><%= formattedAmount %></td>
	                        </tr>
	                        <% } %>
	                    </tbody>
	                </table>
	            </div>
	        </div>
	    </div>
	</div>


<!-- Bootstrap core JavaScript-->
<script src="vendor/jquery/jquery.min.js"></script>
<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script src="vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="js/sb-admin-2.min.js"></script>
	
<!-- Page level plugins -->
<script src="vendor/chart.js/Chart.min.js"></script>

<!-- Page level custom scripts -->
<script src="js/demo/chart-area-demo.js"></script>

<!-- JS -->
<script src="/cashbook/vendor/jquery/jquery.min.js"></script>
<script src="/cashbook/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="/cashbook/vendor/jquery-easing/jquery.easing.min.js"></script>
<script src="/cashbook/js/sb-admin-2.min.js"></script>
</body>
</html>
