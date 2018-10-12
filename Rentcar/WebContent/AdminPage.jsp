<%@page import="dao.iMyPageDao"%>
<%@page import="dao.MyPageDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
    iMyPageDao dao = MyPageDao.getInstance();
    
    
    
    //session.getAttribute("login");
    String adminId = "admin"; 
    
    dao.getMyPageList(adminId);
    
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>AdminPage.jsp</title>
</head>
<body>

<h2>AdminPage.jsp</h2>



</body>
</html>