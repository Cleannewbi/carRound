<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>

<%@page import="org.apache.commons.fileupload.FileItem"%>

<%@page import="dto.RentDto"%>
<%@page import="dto.MemberDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.MyPageDao"%>
<%@page import="dao.iMyPageDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%! int seq;    	
    %>
    <%
    request.setCharacterEncoding("utf-8");
    
    iMyPageDao myPageDao = MyPageDao.getInstance();
    
    //request.getParameter("id"); or  session.getAttribute("login");
    
    String id = "dog";
    
   //  List<MemberDto> mypagelist = myPageDao.getMyPageList(id);
                    
    
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MyPage.jsp</title>
</head>
<body>
<form action="UpdateMyPage.jsp">
<% 
/* for(int i=0; i<mypagelist.size();i++){
	MemberDto memdto = new MemberDto();
   memdto = mypagelist.get(i);
   seq = memdto.getMember_seq();
   
   String file = "./images/k5.jpg"; */
   
%>
<%-- 
<div>
<img alt="이미지 없음" src="<%=file%>" style="width: 120px; height: 120px;">
<table border="1">

<tr><td>ID</td><td><%=memdto.getMember_id() %></td></tr>
<tr><td>NAME</td><td><%=memdto.getMember_name() %></td></tr>
<tr><td>PHONE</td><td><%=memdto.getMember_phone() %></td></tr>
<tr><td>ADDRESS</td><td><%=memdto.getMember_address() %></td></tr>
<tr><td>EMAIL</td><td><%=memdto.getMember_email() %></td></tr>
<tr><td>CARD</td><td><%=memdto.getMember_card() %></td></tr>

</table>
</div>
 --%>
<hr>
<%//} %>


<input type="hidden" name="seq" value="<%=seq%>">
<input type="submit" value="정보 수정">
</form>
<form action="DeleteMyPage.jsp">
<input type="hidden" name="seq" value="<%=seq%>">
<input type="submit" value="회원탈퇴">
</form>
<form action="rentMyPage.jsp">
<input type="hidden" name="id" value="<%=id%>">
<input type="submit" value="예약 확인하기">
</form>


</body>
</html>