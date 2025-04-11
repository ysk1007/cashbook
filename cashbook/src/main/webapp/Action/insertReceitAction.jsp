<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<!-- 파일 입출력 api -->
<%@ page import="java.nio.file.*" %>
<%@ page import="java.io.*" %>
<%
	int cashNo = 0;
	if(request.getParameter("cashNo") != null){
		cashNo = Integer.parseInt(request.getParameter("cashNo"));
	}

	Part part = request.getPart("receiptFile");	// 파일 받는 API
	String originalName = part.getSubmittedFileName();	// 이미지.png
	
	// 중복되지 않는 새로운 파일이름 생성 - java.util.UUID API 사용
	UUID uuid = UUID.randomUUID();
	String fileName = uuid.toString();
	
	// 하이픈 제거
	fileName = fileName.replace("-","");
	
	int dotLastPos = originalName.lastIndexOf(".");	// 마지막 .(확장자)의 인덱스 값 반환
	
	// 확장자
	String ext = originalName.substring(dotLastPos);
	
	// png 확장자가 아니라면 돌아가기
	if(!ext.equals(".png")){
		response.sendRedirect("/cashbook/Form/insertReceitForm.jsp?cashNo="+cashNo);
		return;
	}
	
	// 확장자 붙여주기
	fileName += ext;
	
	// Receit dto
	Receit re = new Receit();
	re.setCashNo(cashNo);
	re.setFileName(fileName);
	
	// 파일 저장하기
	
	// 톰켓안에 poll 프로젝트안 upload폴더 실제 물리적 주소를 반환
	String path = request.getServletContext().getRealPath("upload");
	
	// 빈파일 생성
	File emptyFile = new File(path,fileName);
	
	// 파일 보낼 inputstream 설정
	
	InputStream is = part.getInputStream();	// 파트안의 스트림(이미지파일의 바이너리 파일)
	// 파일을 받을 outputstream 설정
	OutputStream os = Files.newOutputStream(emptyFile.toPath());
	
	is.transferTo(os);	// inputstream binary -> 반복(1byte씩) -> outputstream
	
	os.close();
	
	// db 저장
	ReceitDao receitDao = new ReceitDao();
	receitDao.insertReceit(re);
	
	response.sendRedirect("/cashbook/Form/cashOne.jsp?cashNo="+cashNo);
%>