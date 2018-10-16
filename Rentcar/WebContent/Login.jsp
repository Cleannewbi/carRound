<%@page import="dao.MemManager"%>
<%@page import="dao.iMemManager"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
%>

<%
String id = request.getParameter("id");
String pwd = request.getParameter("pwd");
System.out.println("id:" + id + " pwd:" + pwd);


iMemManager dao = MemManager.getInstance();
MemberDto dto = dao.login(id, pwd);

if(dto != null && !dto.getMember_id().equals("")) {
	session.setAttribute("login", dto);
	session.setMaxInactiveInterval(30*60);
%>
	<script type="text/javascript">
	alert("로그인 성공");
	location.href = "index.jsp";
	</script>
<%	
} else {
%>
	<script type="text/javascript">
	alert("로그인 실패");
	location.href = "index.jsp";
	</script>
<%
}
%>