<%@page import="dao.MemManager"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
String id = request.getParameter("id");
System.out.println("id = " + id);

MemManager dao = MemManager.getInstance();

boolean b = dao.idcheck(id);
System.out.println(b);
if(b){		// 중복일 경우
	out.print("NO");
}else{		// 중복이 아닐 경우
	out.print("OK");
}
%>
