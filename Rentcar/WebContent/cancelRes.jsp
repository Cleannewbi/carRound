<%@page import="dao.MyPageDao"%>
<%@page import="dao.iMyPageDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
    	String sseq = request.getParameter("RC_Rent_Seq");
    	String id = request.getParameter("id");
    	int Rent_Seq = Integer.parseInt(sseq);
    	System.out.println("id:"+id+" Rent_Seq:"+Rent_Seq);
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>cancelRes.jsp</title>
</head>
<body>
<h2>cancelRes.jsp</h2>
<%
iMyPageDao dao = MyPageDao.getInstance();
boolean isS = dao.cancelRes(Rent_Seq, id);
if(isS){
%>
<script type="text/javascript">
alert("예약이 취소되었습니다.");
location.href = "MyPage.jsp";
</script>
<%}else{ %>
<script type="text/javascript">
alert("예약취소 불가능!!");
location.href = "rentMyPage.jsp";
</script>
<%} %>
</body>
</html>