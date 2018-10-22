<%@page import="dao.RentDao"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
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
    
   
<!DOCTYPE html>
<html>
<title>comPage.jsp</title>
<style type="text/css">
  
  table{border-spacing:0px;border-style:none;padding:0px;}
  td{border-spacing:0px;border-style:none;padding:0px;}

 </style>
 <script src="./jq/jquery.min.js"></script>
<%
    iMyPageDao dao = MyPageDao.getInstance();
    request.setCharacterEncoding("utf-8");
   
    
    // session
    MemberDto comp_dto =(MemberDto)session.getAttribute("comPage");
    System.out.println("comp_id:"+comp_dto.getMember_id());
    
   ////////////////////////////다시 로그인해주세요//////////////////////////////

   
   
   MemberDto dto = dao.getMyPageList(comp_dto.getMember_id());
   int seq = comp_dto.getMember_seq();
   String id = comp_dto.getMember_id();
  
    List<RentDto> rentpagelist =  dao.getRentPageList(id.trim());
    MemberDto dto1 = dao.getMyPageList(id);
    System.out.println("id:"+id + "seq:" + seq);
    String fileName = "";
    try{
    fileName = dto1.getMember_Photo().trim();
    System.out.println("dto1.contain:"+dto1.getMember_Photo().contains("."));
    }catch(Exception e){
    	System.err.println(e);
    }
    int RC_Rent_Seq = dao.getSeq(id);
    System.out.println("dto1.toString(): "+dto1.toString());
    System.out.println("RC_Rent_Seq:"+RC_Rent_Seq);
    
    if(!fileName.isEmpty() && fileName.contains(".")){
    	//fileName = dto1.getMember_Photo().trim();
    System.out.println("dto1 photo 이미지 있음:"+dto1.getMember_Photo().trim());
    } else if(!fileName.contains(".") || fileName.isEmpty()){
    	System.out.println("dto1 photo 이미지가 아님:"+dto1.getMember_Photo().trim());
    	fileName = "noImage.png";
    } 
    %>
    
 
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<body>

<div class="w3-sidebar w3-bar-block w3-black w3-card" style="width:130px">
  <h5 class="w3-bar-item">Company Page</h5>
  <button class="w3-bar-item w3-button tablink" onclick="openLink(event, 'Fade1')">정보수정</button>
  <button class="w3-bar-item w3-button tablink" onclick="location.href='calendar.jsp?id=<%=id%>'">스케쥴러</button>
  <!-- <button class="w3-bar-item w3-button tablink" onclick="openLink(event, 'Fade3')">회원탈퇴</button> -->
  <button class="w3-bar-item w3-button tablink" onclick="location.href='index.jsp'">메인화면</button>  
</div>

<div style="margin-left:130px">
  <div class="w3-padding">
  <img alt='./images/noImage.png' src='./images/<%=fileName%>' style="width: 120px; height: 120px;">

<%System.out.println("oMyPage.jsp img:"+dto1.getMember_Photo().trim()); %>
 
<h1><%=id %>'s ComPage</h1>
<hr>

<br>
<table border="1">
<tr><td>ID</td><td><%=dto1.getMember_id() %></td></tr>
<tr><td>NAME</td><td><%=dto1.getMember_name() %></td></tr>
<tr><td>PHONE</td><td><%=dto1.getMember_phone() %></td></tr>
<tr><td>ADDRESS</td><td><%=dto1.getMember_address() %></td></tr>
<tr><td>EMAIL</td><td><%=dto1.getMember_email() %></td></tr>
<tr><td>CARD</td><td><%=dto1.getMember_card() %></td></tr> 
</table>

<hr>
  
</div>

  <div id="Fade1" class="w3-container city w3-animate-opacity" style="display:none">
  <h2>정보수정 화면</h2>
    <form action="pdsupload.jsp" method="post" enctype="multipart/form-data">
    <table>
    		<%if(fileName != null){ %>
		<tr>
			<td>
				<img alt="" src="d:\\\\tmp\\"+<%=fileName.trim() %> height="100" width="100">
			</td>
		</tr>
		
		<%}else{ %>
		<tr>
			<td>
				사진을 등록해주세요
			</td>
		</tr>
		<%} %>
    <tr><td>Photo</td><td><input type="file" name="fileName"></td></tr>
	<tr><td>Your Name</td><td><input type="text" name="name" value="<%=dto.getMember_name() %>" readonly="readonly"></td></tr>
	<tr><td>Your Phone</td><td><input type="text" name="phone"></td></tr>
	<tr><td>Your Address</td><td><input type="text" name="address"></td></tr>
	<tr><td>Your Email</td><td><input type="text" name="email"></td></tr>
	<tr><td>Your Card Number</td><td><input type="text" name="card"></td></tr>
	<input type="hidden" name="seq" value="<%=dto.getMember_seq() %>">
    </table>       
    <input type="submit" value="정보수정">
    </form>
    
	<h2>회원 탈퇴</h2>
    <button onclick="location.href='DeleteMyPage.jsp?seq=<%=seq%>'">탈퇴하기</button>
  </div> 
  <div id="Fade2" class="w3-container city w3-animate-opacity" style="display:none">
    <h2>스케쥴러</h2>
   
  </div>
  
 <%--  <div id="Fade3" class="w3-container city w3-animate-opacity" style="display:none">
    <h2>회원탈퇴 화면</h2>
<form action="DeleteMyPage.jsp">
<input type="hidden" name="M_Command" value="DelMember">
<input type="hidden" name="seq" value="<%=seq%>">
<input type="submit" value="탈퇴하기">
</form> --%>

 <!-- <div id="Fade4" class="w3-container city w3-animate-opacity" style="display:none">
    <h2>메인 화면</h2>
   
  </div>   -->

</div>

<script>
function openLink(evt, animName) {
  var i, x, tablinks;
  x = document.getElementsByClassName("city");
  for (i = 0; i < x.length; i++) {
     x[i].style.display = "none";
  }
  tablinks = document.getElementsByClassName("tablink");
  for (i = 0; i < x.length; i++) {
     tablinks[i].className = tablinks[i].className.replace(" w3-red", "");
  }
  document.getElementById(animName).style.display = "block";
  evt.currentTarget.className += " w3-red";
}
</script>

</body>
</html>