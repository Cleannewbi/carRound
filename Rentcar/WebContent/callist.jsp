<%@page import="java.util.ArrayList"%>
<%@page import="dto.RentDto"%>
<%@page import="dao.iRentDao"%>
<%@page import="dao.RentDao"%>

<%@page import="java.util.List"%>
<%@page import="dto.MemberDto"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%!
public String two(String msg){
	return msg.trim().length() < 2 ? "0"+msg : msg.trim(); 
}

// Date -> String	18/10/02	
// String -> Date   yyyy-mm-dd
public String toDates(String mdate){
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 hh시 mm분");
	
	// 201810021607	-> 2018-10-02 16:07 
	String s = mdate.substring(0, 4) + "-"	// yyyy 
			+ mdate.substring(4, 6) + "-"	// MM
			+ mdate.substring(6, 8) + " "	// dd
			+ mdate.substring(8, 10) + ":"	// hh
			+ mdate.substring(10, 12) + ":00";
	
	Timestamp d = Timestamp.valueOf(s);
	
	return sdf.format(d);
}
%>        

<%
MemberDto user = (MemberDto)session.getAttribute("login");

String year = request.getParameter("year");
String month = request.getParameter("month");
String day = request.getParameter("day");
String id = request.getParameter("id");

String dates = year +"-"+ two(month + "") +"-"+ two(day + "");
System.out.println("dates:"+dates+"id:"+id);

iRentDao dao = RentDao.getInstance();

List<RentDto> getDayList = new ArrayList<>();

getDayList = dao.getDayList(id, dates);

for(int i = 0;i < getDayList.size(); i++){
	RentDto c = getDayList.get(i);
	System.out.println("c.toString(): "+c.toString());	
}

%>

    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>callist.jsp</title>
</head>
<body>
<a href="comPage.jsp">뒤로가기</a>

<h2><%=year %>년 <%=month %>월 <%=day %>일 일정</h2>

<table border="1">
<col width="50"><col width="120"><col width="100"><col width="100"><col width="100"><col width="100">
<col width="100"><col width="100"><col width="100"><col width="100"><col width="100">

<tr bgcolor="#09bbaa">
<td>번호</td><td>자동차이름</td><td>계약 시작일</td><td>계약 종료일</td><td>회원아이디</td><td>대여료</td>
<td>예약자이름</td><td>전화번호</td><td>주소</td><td>카드번호</td><td>회사명</td>
</tr>

<%
for(int i = 0;i < getDayList.size(); i++ ){
	RentDto dto = getDayList.get(i);
	%>
	<tr>	
		<td><%=i + 1 %></td>
		<td><%=dto.getRent_carname() %></td>
		<td><%=dto.getRent_start() %></td>
		<td><%=dto.getRent_end() %></td>
		<td><%=dto.getCus_id() %></td>
		<td><%=dto.getPrice() %>원</td>
		<td><%=dto.getRc_name() %></td>
		<td><%=dto.getRc_phone() %></td>
		<td><%=dto.getRc_address() %></td>
		<td><%=dto.getRc_card() %></td>
		<td><%=dto.getCom_name() %></td>
		
	</tr>
	<%
}
%> 
</table>

<%--<%
String url = String.format("%s?year=%s&month=%s", 
						"calendar.jsp", year, month);


<a href="<%=url %>">일정보기</a> --%>


</body>
</html>








