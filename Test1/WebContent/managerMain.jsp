<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String name = "manager�� ȯ���մϴ�!";
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
	<h1>������ ������</h1>
</div>

<div id="nav">
<br>
	<button type="button" class="btn" onclick="manager(1)">ȸ������</button><br><br>
	<button type="button" class="btn"onclick="manager(2)">�������</button><br><br>
	<button type="button" class="btn"onclick="manager(3)">�������</button><br><br>
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

<div id="footer">
<p>carround.company </p>
</div>

</body>
</html>