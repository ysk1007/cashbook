<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>

<%
	// 달력 출력용 변수
	int lastDate, dayOfWeek, startBlank, endBlank, totalCell;

	// 캘린더 api
	Calendar cal = Calendar.getInstance();

	cal.set(Calendar.DATE, 1);	// 캘린더 오늘 날짜 1일로 설정
	
	if(request.getParameter("year") != null){
		cal.set(Calendar.YEAR, Integer.parseInt(request.getParameter("year")));	// 타겟 year가 있으면 받은 값으로 설정
	}
	if(request.getParameter("month") != null){
		cal.set(Calendar.MONTH, Integer.parseInt(request.getParameter("month"))); // 타겟 month가 있으면 받은 값으로 설정
	}
	
	lastDate = cal.getActualMaximum(Calendar.DATE);	// 그 달의 마지막 날짜를 가져옵니다.
	dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);		// 이번달의 1일의 요일을 가져옵니다. 
	startBlank = dayOfWeek - 1;						// 달력 초반부 공백 칸 수를 계산 합니다.
	endBlank = 0;
	totalCell = startBlank + lastDate;				// 전체 칸은 시작 공백 + 마지막 날짜
	
	if(totalCell % 7 != 0){							// 만약 전체 칸이 7로 나누어 떨어지지 않으면
		endBlank = 7 - (totalCell % 7);				// 마지막 공백칸이 있음
		totalCell += endBlank;						// 최종 전체칸 = 시작 공백 + 마지막 날짜 + 끝 공백
	}
	
	int year = cal.get(Calendar.YEAR);				// year 값만 따로 저장
	int month = cal.get(Calendar.MONTH);			// month 값만 따로 저장

	CashDao cashDao = new CashDao();
	Map<String, ArrayList<Cash>> cashMap = cashDao.selectMonthList(year, month + 1);
	ArrayList<HashMap<String,Object>> totalMap = cashDao.selectMonthAmount(year, month + 1);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>가계부 달력</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
	<link href="/sb-admin-2/css/sb-admin-2.min.css" rel="stylesheet">
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body id="page-top">

<!-- Page Wrapper -->
<div id="wrapper">
	<!-- Content Wrapper -->
	<div id="content-wrapper" class="d-flex flex-column">

		<!-- Main Content -->
		<div id="content">

			<%@ include file="/inc/nav.jsp" %> <!-- 상단 네비게이션 -->

			<!-- Begin Page Content -->
			<div class="container-fluid">

				<h1 class="h3 mb-4 text-gray-800 text-center"><%= year %>년 <%= month + 1 %>월</h1>

				<div class="row mb-4 justify-content-center">
					<%
						for (HashMap<String, Object> map : totalMap) {
							String kind = (String) map.get("kind");
							long totalAmount = Long.parseLong(map.get("totalAmount").toString());
							String cardColor = kind.equals("수입") ? "success" : "danger";
					%>
					<div class="col-xl-3 col-md-6 mb-4">
						<div class="card border-left-<%=cardColor%> shadow h-100 py-2">
							<div class="card-body">
								<div class="text-xs font-weight-bold text-<%=cardColor%> text-uppercase mb-1">
									총 <%= kind %>
								</div>
								<div class="h5 mb-0 font-weight-bold text-gray-800">
									<%= String.format("%,d원", totalAmount) %>
								</div>
							</div>
						</div>
					</div>
					<% } %>
				</div>

				<div class="card shadow mb-4">
					<div class="card-header py-3">
						<h6 class="m-0 font-weight-bold text-primary">달력</h6>
					</div>
					<div class="card-body">
						<div class="table-responsive">
							<table class="table table-bordered text-center" width="100%" cellspacing="0">
								<thead class="bg-light">
									<tr>
										<th class="text-danger">일</th>
										<th>월</th>
										<th>화</th>
										<th>수</th>
										<th>목</th>
										<th>금</th>
										<th class="text-primary">토</th>
									</tr>
								</thead>
								<tbody>
									<%
										for(int i = 1; i <= totalCell; i++) {
											if(i % 7 == 1) { %><tr><% }
											int day = i - startBlank;
											String formattedMonth = String.format("%02d", month + 1);
											String formattedDay = String.format("%02d", day);
											String formattedDate = year + "-" + formattedMonth + "-" + formattedDay;
									%>
									<td style="height: 120px;">
										<% if(day > 0 && day <= lastDate) { %>
											<div class="fw-bold mb-2">
												<a href="/cashbook/Form/dateList.jsp?date=<%=formattedDate%>"><%= day %></a>
											</div>
											<% if (cashMap.containsKey(formattedDate)) {
												int maxCash = 0;
												for (Cash c : cashMap.get(formattedDate)) {
													if (maxCash < 3) {
														String kindLabel = c.getKind().equals("수입") 
															? "<span class='badge bg-success me-1'>수입</span>" 
															: "<span class='badge bg-danger me-1'>지출</span>";
											%>
											<a href="/cashbook/Form/dateList.jsp?date=<%=formattedDate%>" class="d-block text-truncate">
												<%= kindLabel %>
												<span class="badge" style="background-color:<%=c.getColor()%>">
												    <%=c.getMemo()%>
												</span>
											</a>
											<%
													} else {
											%>
											<a href="/cashbook/Form/dateList.jsp?date=<%=formattedDate%>" class="badge bg-primary">[더보기]</a>
											<%
														break;
													}
													maxCash++;
												}
											} %>
										<% } %>
									</td>
									<% if(i % 7 == 0) { %></tr><% } } %>
								</tbody>
							</table>
						</div>
						<div class="d-flex justify-content-between mt-3">
							<a class="btn btn-outline-secondary" href="/cashbook/Form/monthList.jsp?year=<%=year%>&month=<%=month - 1%>">← 이전 달</a>
							<a class="btn btn-outline-secondary" href="/cashbook/Form/monthList.jsp?year=<%=year%>&month=<%=month + 1%>">다음 달 →</a>
						</div>
					</div>
				</div>

			</div>
			<!-- /.container-fluid -->
		</div>
		<!-- End of Main Content -->

	</div>
	<!-- End of Content Wrapper -->
</div>
<!-- End of Page Wrapper -->

<!-- SB Admin JS -->
<script src="/cashbook/vendor/jquery/jquery.min.js"></script>
<script src="/cashbook/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="/cashbook/vendor/jquery-easing/jquery.easing.min.js"></script>
<script src="/cashbook/js/sb-admin-2.min.js"></script>
</body>
</html>
