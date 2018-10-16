<%@page import="dto.MemberDto"%>
<%@page import="dao.MemManager"%>
<%@page import="dao.iMemManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
%>
<%
String id = request.getParameter("id");
String password = request.getParameter("password");
String name = request.getParameter("name");
String phone1 = request.getParameter("phone1");
String phone2 = request.getParameter("phone2");
String phone3 = request.getParameter("phone3");
String phone = phone1 + phone2 + phone3;

String add1 = request.getParameter("add1");
String add2 = request.getParameter("add2");
String add3 = request.getParameter("add3");
String add = add1 + add2 + add3;

String email = request.getParameter("email");
String imgname = request.getParameter("imgname"); // 일반회원은 운전면허, 회사는 배너사진
String cardnum1 = request.getParameter("cardnum1");
String cardnum2 = request.getParameter("cardnum2");
String cardnum3 = request.getParameter("cardnum3");
String cardnum4 = request.getParameter("cardnum4");
String cardnum = cardnum1 + cardnum2 + cardnum3 + cardnum4;		// 일반회원 : 결제용 카드번호
String auth = request.getParameter("auth");

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원가입중...</title>
</head>
<body>
<%
iMemManager dao = MemManager.getInstance();
boolean isS = false;
if(auth.equals("mem")) {
	  isS = dao.addMem(new MemberDto(0, id, password, imgname, name, phone, add, email, cardnum, 1));
}else if(auth.equals("com")) {
	  isS = dao.addMem(new MemberDto(0, id, password, imgname, name, phone, add, email, " ", 2));	
}

if(isS) {
%>
	<script type="text/javascript">
	alert("성공적으로 가입했습니다.");
	location.href = "index.jsp";
	</script>
<%	
} else {
%>
	<script type="text/javascript">
	alert("다시 가입해주세요.");
	location.href = "regi.jsp";
	</script>
<% 
} 
%>

</body>
</html>