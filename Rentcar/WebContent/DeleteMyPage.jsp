<%@page import="dao.iMyPageDao"%>
<%@page import="dao.MyPageDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    String sseq = request.getParameter("seq");
    int seq = Integer.parseInt(sseq);
    System.out.println("seq:"+seq);
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>DeleteMyPage</title>
</head>
<body>
<h2>DeleteMyPage</h2>
<% iMyPageDao dao = MyPageDao.getInstance();
	
	boolean isS = dao.deleteMyPage(seq);
	if(isS==true){
%>
<script type="text/javascript">
alert("회원탈퇴 성공!!");
alert("메엔화면으로 이동");
</script>
<%}else if(isS==false){ %>
<script type="text/javascript">
alert("회원탈퇴 실패!!");
alert("MyPage로 이동");
location.href="MyPage.jsp";
<%}%>
</script>
</body>
</html>