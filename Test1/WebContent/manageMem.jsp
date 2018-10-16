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
	<h1>회원관리 페이지</h1>
</div>

<div id="nav">
<br>
	<button type="button" class="btn" onclick="manager(1)">회원관리</button><br><br>
	<button type="button" class="btn"onclick="manager(2)">매출관리</button><br><br>
	<button type="button" class="btn"onclick="manager(3)">고객과의 소통</button><br><br>
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

<!-- for문 사용하여 member table로 호출, 버튼넣어서 삭제, 업데이트 할수있도록 만들기 -->

<div id="section">
<table>
<tr>
	<td>회원구분</td>
	<td>이름</td>
	<td>아이디</td>
	<td>주문/판매건수</td>
	<td>주문/판매총액</td>
	<td><button id="deleteBtn" type="button" onclick="deleteFunc()">삭제</button> </td>
</tr>
<%for (int i =0; i<dtoList.size();i++){ %>
<tr>
	<td><%if(dtoList.get(i).getMember_auth()==1){ 
				out.println("일반");
			} else if (dtoList.get(i).getMember_auth()==2){ 
				out.println("기업");
			} %>
	</td>
	<td><%=dtoList.get(i).getMember_name()%></td>
	<td><%=dtoList.get(i).getMember_id()%></td>
	<td>주문/판매건수</td>
	<td>주문/판매총액</td>
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