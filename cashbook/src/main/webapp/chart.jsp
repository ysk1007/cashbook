<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>

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
	
	// 예시: 월별 수입 데이터 처리
	int[] incomeData = new int[12];  // 12개월
	for (int i = 0; i < monthStatsIncome.size(); i++) {
	    HashMap<String, Object> map = monthStatsIncome.get(i);
	    int month = (Integer) map.get("month");
	    int amount = (Integer) map.get("amount");
	    incomeData[month - 1] = amount;  // 월별 수입 데이터를 배열에 저장
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

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SB Admin 2 - Charts</title>

    <!-- Custom fonts for this template-->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="css/sb-admin-2.min.css" rel="stylesheet">

</head>
<script>
    var monthlyIncomeData = <%= Arrays.toString(incomeData) %>;
    var monthlyExpenseData = <%= Arrays.toString(expenseData) %>;
    
    var ctx = document.getElementById("myAreaChart").getContext('2d');
    var myLineChart = new Chart(ctx, {
      type: 'line',
      data: {
        labels: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
        datasets: [
        	{
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
        	},
        	
        	],
      },
      options: {
        maintainAspectRatio: false,
        layout: {
          padding: {
            left: 10,
            right: 25,
            top: 25,
            bottom: 0
          }
        },
        scales: {
          xAxes: [{
            time: {
              unit: 'date'
            },
            gridLines: {
              display: false,
              drawBorder: false
            },
            ticks: {
              maxTicksLimit: 7
            }
          }],
          yAxes: [{
            ticks: {
              maxTicksLimit: 5,
              padding: 10,
              // Include a dollar sign in the ticks
              callback: function(value, index, values) {
                return '$' + number_format(value);
              }
            },
            gridLines: {
              color: "rgb(234, 236, 244)",
              zeroLineColor: "rgb(234, 236, 244)",
              drawBorder: false,
              borderDash: [2],
              zeroLineBorderDash: [2]
            }
          }],
        },
        legend: {
          display: false
        },
        tooltips: {
          backgroundColor: "rgb(255,255,255)",
          bodyFontColor: "#858796",
          titleMarginBottom: 10,
          titleFontColor: '#6e707e',
          titleFontSize: 14,
          borderColor: '#dddfeb',
          borderWidth: 1,
          xPadding: 15,
          yPadding: 15,
          displayColors: false,
          intersect: false,
          mode: 'index',
          caretPadding: 10,
          callbacks: {
            label: function(tooltipItem, chart) {
              var datasetLabel = chart.datasets[tooltipItem.datasetIndex].label || '';
              return datasetLabel + ': $' + number_format(tooltipItem.yLabel);
            }
          }
        }
      }
    });
</script>
<body id="page-top">

    <!-- Content Row -->
    <div class="row">

        <div class="col-xl-8 col-lg-7">
            <!-- Area Chart -->
            <div class="card shadow mb-4">
                <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold text-primary">범위 차트</h6>
                </div>
                <div class="card-body">
                    <div class="chart-area">
                        <canvas id="myLineChart"></canvas>
                    </div>
                    <hr>
                    Styling for the area chart can be found in the
                    <code>/js/demo/chart-area-demo.js</code> file.
                </div>
            </div>

            <!-- Bar Chart -->
            <div class="card shadow mb-4">
                <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold text-primary">바 차트</h6>
                </div>
                <div class="card-body">
                    <div class="chart-bar">
                        <canvas id="myBarChart"></canvas>
                    </div>
                    <hr>
                    Styling for the bar chart can be found in the
                    <code>/js/demo/chart-bar-demo.js</code> file.
                </div>
            </div>

        </div>

        <!-- Donut Chart -->
        <div class="col-xl-4 col-lg-5">
            <div class="card shadow mb-4">
                <!-- Card Header - Dropdown -->
                <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold text-primary">도넛 차트</h6>
                </div>
                <!-- Card Body -->
                <div class="card-body">
                    <div class="chart-pie pt-4">
                        <canvas id="myPieChart"></canvas>
                    </div>
                    <hr>
                    Styling for the donut chart can be found in the
                    <code>/js/demo/chart-pie-demo.js</code> file.
                </div>
            </div>
        </div>
    </div>

</div>
<!-- /.container-fluid -->

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
    <script src="js/demo/chart-pie-demo.js"></script>
    <script src="js/demo/chart-bar-demo.js"></script>

</body>

</html>