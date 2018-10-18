<%@page import="java.text.DecimalFormat"%>
<%@page import="dao.RentDao"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="model.MemberDto"%>
<%@page import="dao.memberDao"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	//생성
	memberDao memdao = new memberDao();
	List<MemberDto> memdtoList = new ArrayList<>();
	RentDao rentdao = new RentDao();

	//회원출력
	memdtoList = memdao.getUserList();
	List<MemberDto> comdtoList = new ArrayList<>();
	comdtoList = memdao.getComList();
	
	//가격, 건수출력
	HashMap<String,Integer> countMap = rentdao.getOrderCount();
	HashMap<String,Integer> priceMap = rentdao.getOrderPrice();
	
	DecimalFormat formatter = new DecimalFormat("###,###,###");
	
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
	<h1>회원관리</h1>
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

<!-- for문 사용하여 member table로 호출, 버튼넣어서 삭제, 업데이트 할수있도록 만들기 -->

<div id="section">
<table>
<tr>
	<td>이름</td>
	<td>아이디</td>
	<td>주문/판매건수</td>
	<td>주문/판매총액</td>
</tr>
<%for (int i =0; i<memdtoList.size();i++){ %>
<tr>
	<td><%=memdtoList.get(i).getMember_name()%></td>
	<td><%=memdtoList.get(i).getMember_id()%></td>
	<td><%=countMap.get(memdtoList.get(i).getMember_id()) %>건</td>
	<td><%=priceMap.get(memdtoList.get(i).getMember_id())%>원</td>
</tr>
<%} %>
</table>
</div>

<script type="text/javascript">

function deleteFunc() {
	location.href="manageMemAf.jsp?name=checkbox";
	
	"NewFile.jsp?name="+$("#name").val() 

}
</script>

<div id="footer">
<p> <a href="index.jsp" style="text-decoration: none; color: white;">carround.company</a> </p>
</div>
</body>
</html>