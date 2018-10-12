<%@page import="dto.MemberDto"%>
<%@page import="dao.MyPageDao"%>
<%@page import="dao.iMyPageDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%

    String id = request.getParameter("id");
    String pwd = request.getParameter("pwd"); 
    String photo = request.getParameter("photo"); 
    String com_name = request.getParameter("com_name"); 
    String phone = request.getParameter("phone"); 
    String address = request.getParameter("address"); 
    String email = request.getParameter("email");
    
    iMyPageDao dao = MyPageDao.getInstance();
    MemberDto dto = new MemberDto();
    dto.setMember_auth(2);
    dto.setMember_id(id);
    dto.setMember_pw(pwd);
    dto.setMember_address(address);
    dto.setMember_phone(phone);
    dto.setMember_Photo(photo);
    dto.setMember_email(email);
    dto.setMember_name(com_name);
    
    System.out.println("com_name(AFregiCompany):"+com_name);
   
    
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>AFregiCompany.jsp</title>
</head>
<body>
<form action="regiCar.jsp">
<input type="hidden" name="com_name1" value="<%=com_name%>">
<input type="hidden" name="id" value="<%=id%>">


<input type="submit" value="자동차 등록 하기" style="width: 200px; height: 200px;">
</form>


<%
boolean isS =  dao.regiCompany(dto);
if(isS){
%>
<script type="text/javascript">
alert("귀하의 렌트카 법인이 등록되었습니다.");

</script>
<%}else{ %>
<script type="text/javascript">
alert("법인 등록 실패!! 다시 기입하여 주십시요.");
location.href = "regiCompany.jsp";
</script>
<%} %>


</body>
</html>