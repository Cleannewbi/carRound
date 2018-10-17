<%@page import="java.util.HashMap"%>
<%@page import="dao.RentDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.MemberDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.memberDao"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%

//생성
memberDao memdao = new memberDao();
List<MemberDto> memdtoList = new ArrayList<>();
RentDao rentdao = new RentDao();

//회원출력
List<MemberDto> comdtoList = new ArrayList<>();
comdtoList = memdao.getComList();

//가격, 건수출력
HashMap<String,Integer> countMap = 
HashMap<String,Integer> priceMap = 

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="magager.css">
<style type="text/css">
table {
    width: 100%;
    border: 1px solid #444444;
    border-collapse: collapse;
  }
  th, td {
    border: 1px solid #444444;
  }
</style>
</head>
<body>
<div id="header">
	<h1>고객소통 페이지</h1>
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

<!-- 고객의 quest를 db에 저장, 불러와서 게시판에 넣고 게시판 누르고 답글쓰기 -> 답글써놓으면 사라지도록 
q&a는 마이페이지에서도 확인가능해야할것 혹은 그냥 이메일보내는걸로 -->

<div id="section">
<table>
<tr>
	<td>이름</td>
	<td>아이디</td>
	<td>주문/판매건수</td>
	<td>주문/판매총액</td>
	<td><button id="deleteBtn" type="button" onclick="deleteFunc()">삭제</button> </td>
</tr>
<%for (int i =0; i<memdtoList.size();i++){ %>
<tr>
	<td><%=memdtoList.get(i).getMember_name()%></td>
	<td><%=memdtoList.get(i).getMember_id()%></td>
	<td><%=countMap.get(memdtoList.get(i).getMember_id()) %></td>
	<td><%=priceMap.get(memdtoList.get(i).getMember_id()) %></td>
	<td><input type="checkbox" name="checkbox"></td>
</tr>
<%} %>
</table>
</div>

<script type="text/javascript">




</script>



<div id="footer">
<p>carround.company </p>
</div>
</body>
</html>