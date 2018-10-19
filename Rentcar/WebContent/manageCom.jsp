<%@page import="dto.MemberDto"%>
<%@page import="dao.MemManager"%>
<%@page import="dao.iMemManager"%>
<%@page import="java.util.Formatter"%>
<%@page import="java.util.HashMap"%>
<%@page import="dao.RentDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dto.MemberDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.MemManager"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%

//����
iMemManager memdao = MemManager.getInstance();

List<MemberDto> memdtoList = new ArrayList<>();
RentDao rentdao = new RentDao();

//ȸ�����
List<MemberDto> comdtoList = new ArrayList<>();
comdtoList = memdao.getComList();

//����, �Ǽ����
HashMap<String,Integer> countMap = rentdao.getComOrderCount();
HashMap<String,Integer> priceMap = rentdao.getComOrderPrice();

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="./css/magager.css">
<style type="text/css">
#userTable{
	font-size: 17px;
	color:#595959;
	height: 200px;
    border-collapse: collapse;
    
}
td{
 	border-bottom: 1px solid #444444;
    padding: 10px;
}

</style>
</head>
<body>
<div id="header">
	<h1>�������</h1>
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

<div id="section" align="center">

<table id="userTable">
<col width="450"><col width="300"><col width="250"><col width="250">
<tr>
	<td align="center">�̸�</td>
	<td align="center">���̵�</td>
	<td align="center">�ֹ�/�ǸŰǼ�</td>
	<td align="center">�ֹ�/�Ǹ��Ѿ�</td>
</tr>
<%for (int i =0; i<comdtoList.size();i++){ %>
<tr>
	<td><%=comdtoList.get(i).getMember_name()%></td>
	<td><%=comdtoList.get(i).getMember_id()%></td>
	<td align="right"><%=countMap.get(comdtoList.get(i).getMember_name()) %>��</td>
	<td align="right"><%= priceMap.get(comdtoList.get(i).getMember_name()) %>��</td>
</tr>
<%} %>
</table>
</div>


<div id="footer">
<p> <a href="index.jsp" style="text-decoration: none; color: white;">carround.company</a> </p>
</div>
</body>
</html>