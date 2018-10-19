<%@page import="dto.ReviewDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.iBbsDao"%>
<%@page import="dao.BbsDao"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String actionPath = request.getParameter("actionPath");
String _seq = request.getParameter("seq");
int seq = Integer.parseInt(_seq);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
Object ologin = session.getAttribute("login");
MemberDto dto = null;
if(ologin == null) {
%>
	<script type="text/javascript">
		alert("다시 로그인 해주세요.");
		location.href="index.jsp";
	</script>
<%
	return;
}

dto = (MemberDto)ologin;
%>

<!-- 리뷰 리스트 -->
<form action="<%=actionPath %>" name="reviewPage" method="get">
<%
iBbsDao bdao = BbsDao.getInstance();
List<ReviewDto> bbslist = bdao.getBbsList(seq);
%>
<div align="center">
<table border="2"  style="width: 100%;" id="table">
<col width="70"><col width="500"><col width="150">
<tr>
	<th>번호</th>
	<th>제목</th>
	<th>작성자</th>
</tr>
<%
if(bbslist == null || bbslist.size() == 0) {
	%>
	<tr>
		<td colspan="3" style="text-align: center;">작성된 글이 없습니다.</td>
	</tr>
	<%
} else {
	for(int i=0 ; i<bbslist.size() ; i++) {
		ReviewDto bbs = bbslist.get(i);
		%>
		<tr>
			<td><%=i+1 %></td>
			<td style="text-align: left;"><%=bbs.getReview_title() %></td>
			<td><%=bbs.getReview_cus_id() %></td>	
				<%} %>
			
		</tr>
		<%
	}
	%>

</table>
</div>

</form>

</body>
</html>