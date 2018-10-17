<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
    String sseq = request.getParameter("chkbox");
    String carName = request.getParameter("carName");
    int seq = Integer.parseInt(sseq);
    System.out.println("resch seq:"+seq +"carName:"+carName);
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>reschedule.jsp</title>
</head>
<body>
<h1>reschedule.jsp</h1>

<form action="Afreschedule.jsp">
<input type="hidden" name="seq" value="<%=seq%>">
<input type="hidden" name="carName" value="<%=carName%>">
계약시작일:<input type="date" name="start">
계약종료일:<input type="date" name="end">
<input type="submit" value="변경하기">
</form>

</body>
</html>