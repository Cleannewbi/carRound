<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="dto.MemberDto"%>
<%@page import="dao.MyPageDao"%>
<%@page import="dao.iMyPageDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%	
    	//session.getAttribute("login");
    
    	String checkAdmin = "";
    	iMyPageDao dao = MyPageDao.getInstance();
    	dao.getMyPageList(checkAdmin);
    	
    	MemberDto dto = new MemberDto();
    	List<MemberDto> checklist = new ArrayList<>();
    	
    	   	
    	
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>