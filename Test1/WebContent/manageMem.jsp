<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="model.MemberDto"%>
<%@page import="dao.memberDao"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	memberDao memdao = new memberDao();
	List<MemberDto> dtoList = new ArrayList<>();
	dtoList = memdao.getManageMemList(3);
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
	<h1>ȸ������ ������</h1>
</div>

<div id="nav">
<br>
	<button type="button" class="btn" onclick="manager(1)">ȸ������</button><br><br>
	<button type="button" class="btn"onclick="manager(2)">�������</button><br><br>
	<button type="button" class="btn"onclick="manager(3)">������ ����</button><br><br>
</div>
<script type="text/javascript">
function manager(number) {
	if(number==1){
		alert("1���Դϴ�.");
		location.href="manageMem.jsp";
	}else if(number==2){
		alert("2���Դϴ�.");
		location.href="manageSale.jsp";
	}else if(number==3){
		alert("3���Դϴ�.");
		location.href="manageQnA.jsp";
	}
}
</script>

<!-- for�� ����Ͽ� member table�� ȣ��, ��ư�־ ����, ������Ʈ �Ҽ��ֵ��� ����� -->

<div id="section">
<table>
<tr>
	<td>ȸ������</td>
	<td>�̸�</td>
	<td>���̵�</td>
	<td>�ֹ�/�ǸŰǼ�</td>
	<td>�ֹ�/�Ǹ��Ѿ�</td>
	<td><button id="deleteBtn" type="button" onclick="deleteFunc()">����</button> </td>
</tr>
<%for (int i =0; i<dtoList.size();i++){ %>
<tr>
	<td><%if(dtoList.get(i).getMember_auth()==1){ 
				out.println("�Ϲ�");
			} else if (dtoList.get(i).getMember_auth()==2){ 
				out.println("���");
			} %>
	</td>
	<td><%=dtoList.get(i).getMember_name()%></td>
	<td><%=dtoList.get(i).getMember_id()%></td>
	<td>�ֹ�/�ǸŰǼ�</td>
	<td>�ֹ�/�Ǹ��Ѿ�</td>
	<td><input type="checkbox" name="checkbox"></td>
</tr>
<%} %>
</table>

</div>

<script type="text/javascript">

function deleteFunc() {
	location.href="manageMemAf.jsp?name=checkbox";
}
</script>

</body>
</html>