<%@page import="dto.RentDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.MyPageDao"%>
<%@page import="dao.iMyPageDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    //String id = session.getAttribute("login");
    iMyPageDao dao = MyPageDao.getInstance();
    String id = request.getParameter("id");
    String carName ="";
    List<RentDto> rentpagelist =  dao.getRentPageList(id.trim());
    
    
    System.out.println("id:"+id);
    int RC_Rent_Seq = dao.getSeq(id);
    System.out.println("RC_Rent_Seq:"+RC_Rent_Seq);
    
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>rentMyPage.jsp</title>
</head>
<body>
<div>
<table border="1">
<col width="20"><col width="100"><col width="120"><col width="120"><col width="50"><col width="50"><col width="50">
<tr>
	<th>번호</th><th>차량 이름</th><th>계약시작일</th><th>계약종료일</th><th>회원아이디</th><th>예약날짜 변경</th><th>예약취소</th>
</tr>
<%
if(rentpagelist == null || rentpagelist.size() ==0){
	%>
	<tr><td colspan="7">예약하신 차량이 없습니다.</tr><%}else{
		for(int i=0 ; i < rentpagelist.size() ; i++){
			RentDto rent = rentpagelist.get(i);
		%>
	<tr>
		<td><%=i+1 %></td>
		<td><%=rent.getRent_carname() %></td>
		<td><%=rent.getRent_start() %></td>
		<td><%=rent.getRent_end() %></td>
		<td><%=rent.getCus_id() %></td>
		<td><button>예약일 변경</button></td>
		<td><button>예약 취소</button></td>		
	</tr>
<%}
} %>

<form action="cancelRes.jsp">
<input type="hidden" name="id" value="<%=id%>">
<input type="hidden" name="carName" value="<%=carName%>">
<input type="hidden" name="RC_Rent_Seq" value="<%=RC_Rent_Seq%>">
<input type="submit" value="예약 취소">
</form>

</table>
</div>


<script type="text/javascript">
function C_Dates() {
	alert("click");	
}
</script>

</body>
</html>