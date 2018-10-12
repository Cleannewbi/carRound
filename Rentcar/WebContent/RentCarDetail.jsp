<%@page import="dao.MemManager"%>
<%@page import="dao.iMemManager"%>
<%@page import="dao.iBbsDao"%>
<%@page import="dao.BbsDao"%>
<%@page import="dao.InfoDao"%>
<%@page import="dao.iInfoDao"%>
<%@page import="dto.InfoDto"%>
<%@page import="dto.MemberDto"%>
<%@page import="dto.ReviewDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String InfoSeq = request.getParameter("seq");
int seq = Integer.parseInt(InfoSeq);
String comname = request.getParameter("comp");
	//  List<ReviewDto> bbslist = (List<ReviewDto>)request.getAttribute("bbslist");			// 리뷰리스트 받아오기
	//  System.out.println(bbslist.get(3));
    
	/*  InfoDto infodto = (InfoDto)request.getAttribute("infolist");		// 차량정보 */
	iInfoDao iidao = InfoDao.getInstance();
	InfoDto iidto = iidao.getInfoList(seq);
	System.out.println(iidto.toString());		
    
	iMemManager imdao = MemManager.getInstance();
	MemberDto comdto = imdao.getCom(comname);
	/* MemberDto comdto = (MemberDto)request.getAttribute("comdto");		// 회사정보 */
    // System.out.println(comdto.toString()); 
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>



<!-- 
	1. 차량정보
	2. 회사정보
	3. 리뷰게시판
 -->
 



 <!--1. 차량정보  -->	
<br><br>
 <table>
 	<tr>
 		<th>차량 사진</th>
 		<td><%=iidto.getCar_pic() %></td>
 	</tr>
 	
 	<tr>
 		<th>차 이름</th>
 		<td><%=iidto.getCar_name() %></td>
 	</tr>
 	
 	<tr>
 		<th>타입</th>
 		<td><%=iidto.getCar_type() %></td>
 	</tr>
 	
 	<tr>
 		<th>연료</th>
 		<td><%=iidto.getCar_fuel() %></td>
 	</tr>
 
 	 <tr>
 		<th>사이즈</th>
 		<td><%=iidto.getCar_fee() %></td>
 	</tr>
 
 
  	<tr>
 		<th>비용</th>
 		<td><%=iidto.getCar_fuel() %></td>
 	</tr>
 </table>
 

 
 
 <br><br>


<!-- 2. 회사정보  -->

 <table>
 	<tr>
 		<th>회사 배너 사진</th>
 		<td><%=comdto.getMember_Photo() %></td>
 	</tr>
 	
 	<tr>
 		<th>회사 이름</th>
 		<td><%=comdto.getMember_name() %></td>
 	</tr>
 	
 	<tr>
 		<th>전화번호</th>
 		<td><%=comdto.getMember_phone() %></td>
 	</tr>
 	
 	<tr>
 		<th>주소</th>
 		<td><%=comdto.getMember_address() %></td>
 	</tr>
 
 	 <tr>
 		<th>이메일</th>
 		<td><%=comdto.getMember_email() %></td>
 	</tr>
 
 

 </table>
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 <!-- 리뷰 게시판  -->

<%--  
<br><br>
<div align="center" style="border: solid black 1px">
<table style="text-align: center">
<col width="70"><col width="150"><col width="150"><col width="300"><col width="500">

<tr>
	<th>번호</th>
	<th>작성자</th>
	<th>날짜</th>
	<th>제목</th>
	<th>내용</th>
</tr>
	<%if(bbslist.size() == 0){ %>
		<tr>
			<td colspan="5">글이 존재하지 않습니다</td>
		</tr>
	<%}else{
			for(ReviewDto list : bbslist){
		%>
		<tr>
			<td><%=list.getReview_seq()%></td>
			<td><%=list.getReview_cus_id() %></td>
			<td><%=list.getReview_date() %></td>
			<td><%=list.getReview_title() %></td>
			<td><%=list.getReview_content() %></td>
		</tr>

	<%} }%>


</table>
</div>
 --%>













</body>
</html>