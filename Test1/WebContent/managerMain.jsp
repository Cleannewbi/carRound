<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String name = "manager님 환영합니다!";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="magager.css">
</head>
<body>

<div id="header">
	<h1>관리자 페이지</h1>
</div>

<div id="nav">
<br>
	<button type="button" class="btn" onclick="manager(1)">회원관리</button><br><br>
	<button type="button" class="btn"onclick="manager(2)">매출관리</button><br><br>
	<button type="button" class="btn"onclick="manager(3)">고객과의 소통</button><br><br>

</div>

<div id="section">
	<h1><%=name %></h1>
</div>

<script type="text/javascript">
function manager(number) {
	if(number==1){
		alert("1번입니다.");
		location.href="manageMem.jsp";
	}else if(number==2){
		alert("2번입니다.");
		location.href="manageSale.jsp";
	}else if(number==3){
		alert("3번입니다.");
		location.href="manageQnA.jsp";
	}
}
</script>

<div id="footer">
<p>carround.company 본사 : 경기도 김포시 풍무동 </p>
</div>

</body>
</html>