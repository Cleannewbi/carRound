<%@page import="java.util.HashMap"%>
<%@page import="dao.RentDao"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="magager.css">
</head>
<body>
<div id="header">
	<h1>매출관리 페이지</h1>
</div>

<div id="nav">
<br>
	<button type="button" class="btn" onclick="manager(1)">회원관리</button><br><br>
	<button type="button" class="btn"onclick="manager(2)">기업관리</button><br><br>
	<button type="button" class="btn"onclick="manager(3)">매출관리</button><br><br>
</div>
<script type="text/javascript">
function manager(number) {
	if(number==1){
		location.href="manageMem.jsp";
	}else if(number==2){
		location.href="manageCom.jsp";
	}else if(number==3){
		location.href="manageSale.jsp";
	}
}
</script>

<!-- 회사별(차트), 날짜별(그래프), 차종별(차트) 제작 -->
<div id="section">
	
	<%
		RentDao dao = new RentDao();
		HashMap <String, Integer> map = new HashMap<>();
		map = dao.getCarSaleMonthly();
		HashMap <String, Integer> map2 = new HashMap<>();
		map2=dao.getComSaleMonthly("월별");
		//map2=dao.getComSaleMonthly("이번달");
	%>
	
	
	
</div>
<div id="footer">
<p> <a href="index.jsp" style="text-decoration: none; color: white;">carround.company</a> </p>
</div>
</body>
</html>