<%@page import="dto.MemberDto"%>
<%@page import="dao.MyPageDao"%>
<%@page import="dao.iMyPageDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
    <%
    
    String name = request.getParameter("Name");
    String phone = request.getParameter("Phone");
    String address = request.getParameter("Address");
    String email = request.getParameter("Email");
    String card = request.getParameter("Card");
    String sseq = request.getParameter("U_seq");
    int seq = Integer.parseInt(sseq);
    
    System.out.println("name: "+name+"phone: "+phone+"address: "+address+"eamil: "+email+"card: "+card+"seq: "+seq);
    MemberDto dto = new MemberDto();
    dto.setMember_name(name);
    dto.setMember_phone(phone);
    dto.setMember_address(address);
    dto.setMember_email(email);
    dto.setMember_card(card);
    dto.setMember_seq(seq);
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>AfUpdateMyPage.jsp</title>
</head>
<body>
<h2>AfUpdateMyPage.jsp</h2>
<%
iMyPageDao dao = MyPageDao.getInstance();

boolean isS = dao.updateMyPage(dto);
if(isS==true){
%>
<script type="text/javascript">
alert("성공적으로 변경되었습니다.");
location.href = "MyPage.jsp";
</script>
<%}else if(isS==false){ %>
<script type="text/javascript">
alert("고객님의 회원정보변경이 불가합니다.");
location.href = "MyPage.jsp";
</script>
<%} %>

</body>
</html>