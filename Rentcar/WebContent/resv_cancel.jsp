<%@page import="dao.MyPageDao"%>
<%@page import="dao.iMyPageDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
    String sseq = request.getParameter("seq");
    String id = request.getParameter("id");
    int seq = Integer.parseInt(sseq);
    System.out.println("r_can seq:"+seq + "id: "+id);
    iMyPageDao dao = MyPageDao.getInstance();
    boolean isS = dao.cancelRes(seq, id);
    System.out.println("r_can isS:"+isS);	
    
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>resv_cancel.jsp</title>
</head>
<body>

<script type="text/javascript">
<%if(isS){
	%>
	alert("예약취소 성공!!");
	location.href="oMyPage.jsp";
	
	<%
}else{
%>
	alert("예약취소 실패!!");
	location.href = "oMyPage.jsp";
<%}%>
</script>

</body>
</html>