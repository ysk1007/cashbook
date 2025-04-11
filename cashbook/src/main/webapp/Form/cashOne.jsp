<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%
	// requset 받기
    int cashNo = Integer.parseInt(request.getParameter("cashNo"));

	// Cash 모델에서 캐시 데이터 하나 가져옴
    CashDao cashDao = new CashDao();
    HashMap<String, Object> map = cashDao.selectCashOne(cashNo);
    
    // Receit 모델에서 캐시에 영수증 데이터 가져옴
    ReceitDao reDao = new ReceitDao();
    Receit re = reDao.selectReceitOne(cashNo);

    // 수입/지출 텍스트 Color
    String kind = map.get("kind").toString();
    String kindColor = kind.equals("수입") ? "text-success" : "text-danger";
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Cash 상세 보기</title>
    <link href="/cashbook/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    <link href="/cashbook/css/sb-admin-2.min.css" rel="stylesheet">
</head>
<body id="page-top">

<jsp:include page="/inc/nav.jsp" />

<div class="container mt-5 mb-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">

            <div class="card shadow border-0">
                <div class="card-header bg-white border-bottom-0">
                    <h3 class="h5 fw-bold text-primary mb-0">💳 Cash 상세 정보</h3>
                </div>
                <div class="card-body">
                    <form action="/cashbook/Form/dateList.jsp?date=<%=map.get("cashDate")%>" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="cashNo" value="<%=map.get("cashNo")%>">

                        <!-- 날짜 -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold">날짜</label>
                            <input type="date" name="cashDate" class="form-control" value="<%=map.get("cashDate")%>" readonly>
                        </div>

                        <!-- 분류 -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold">분류</label>
                            <input type="text" name="kind" class="form-control <%=kindColor%>" value="<%=kind%>" readonly>
                        </div>

                        <!-- 카테고리 -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold">카테고리</label>
                            <input type="text" name="category" class="form-control" value="<%=map.get("title")%>" readonly>
                        </div>

                        <!-- 금액 -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold">금액</label>
                            <input type="number" name="price" class="form-control" value="<%=map.get("amount")%>" readonly>
                        </div>

                        <!-- 메모 -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold">메모</label>
                            <textarea name="memo" class="form-control" rows="3" readonly><%=map.get("memo")%></textarea>
                        </div>

                        <!-- 영수증 -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold">영수증</label><br>
                            <%
                                if(re.getFileName() != null){	// 영수증이 있으면 영수증 이미지와 삭제 버튼 출력
                            %>
                            	<!-- 이미지 -->
                                <img src="/cashbook/upload/<%=re.getFileName()%>" class="img-fluid rounded border mb-2" style="max-height: 300px;">
                                
                                <!--  삭제 버튼 -->
                                <div>
                                    <a href="/cashbook/Action/deleteReceit.jsp?cashNo=<%=cashNo%>&fileName=<%=re.getFileName()%>" class="btn btn-sm btn-outline-danger">
                                        <i class="fas fa-trash-alt"></i> 영수증 삭제
                                    </a>
                                </div>
                            <%
                                } else {	// 영수증이 없으면 첨부 폼으로 가는 버튼 출력
                            %>
                                <p class="text-muted">영수증 이미지를 첨부해주세요.</p>
                                <!--  영수증 첨부 버튼 -->
                                <a href="/cashbook/Form/insertReceitForm.jsp?cashNo=<%=cashNo%>" class="btn btn-sm btn-outline-primary">
                                    <i class="fas fa-upload"></i> 영수증 첨부
                                </a>
                            <%
                                }
                            %>
                        </div>

                        <!-- 뒤로 -->
                        <div class="d-grid mt-4">
                            <button type="submit" class="btn btn-primary">
                                ← 뒤로가기
                            </button>
                        </div>

                    </form>
                </div>
            </div>

        </div>
    </div>
</div>

<!-- JS -->
<script src="/cashbook/vendor/jquery/jquery.min.js"></script>
<script src="/cashbook/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="/cashbook/vendor/jquery-easing/jquery.easing.min.js"></script>
<script src="/cashbook/js/sb-admin-2.min.js"></script>
</body>
</html>
