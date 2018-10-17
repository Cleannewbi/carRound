<%@page import="dao.MyPageDao"%>
<%@page import="dao.iMyPageDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
    <%
    
    String start = request.getParameter("start");
    String end = request.getParameter("end");
    String carName = request.getParameter("carName");
    String sseq = request.getParameter("seq");
    int seq = Integer.parseInt(sseq);
    
    iMyPageDao dao = MyPageDao.getInstance();
    
    boolean isS = dao.changeDates(seq, start, end);
    
    System.out.println("resch isS:"+isS);
   
       
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Afresch</title>
</head>
<body>

<script type="text/javascript">
<%if(isS){
	%>
	alert("날짜변경 성공!!");
	location.href="index.jsp";
	
	<%
}else{
%>
	alert("날짜변경 실패!!");
	location.href = "index.jsp";
<%}%>
</script>

</body>
</html>
