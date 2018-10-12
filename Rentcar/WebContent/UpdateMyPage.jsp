<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    int seq = Integer.parseInt(request.getParameter("seq"));
    System.out.println("seq: "+seq);
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>UpdateMyPage</title>
</head>
<body>
<form action="AFUpdateMyPage.jsp">
<input type="hidden" name="U_seq" value="<%=seq%>">
<div>
<table>

<tr><td>NAME</td><td><input type="text" name="Name"></td></tr>
<tr><td>PHONE</td><td><input type="text" name="Phone"></td></tr>
<tr><td>ADDRESS</td><td><input type="text" name="Address"></td></tr>
<tr><td>EMAIL</td><td><input type="text" name="Email"></td></tr>
<tr><td>CARD</td><td><input type="text" name="Card"></td></tr>
</table>
</div>
<input type="submit" value="수정하기">
</form>


</body>
</html>