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
    <%
    iMyPageDao dao = MyPageDao.getInstance();
    request.setCharacterEncoding("utf-8");
    String file ="";
    String fileName = "";
    
    // session
    Object ologin = session.getAttribute("login");
    MemberDto dto = null;
    if(ologin == null) {
    %>
    	<script type="text/javascript">
    		alert("다시 로그인 해주세요.");
    		location.href="loginPage.jsp";
    	</script>
    <%
    	return;
    }

    dto = (MemberDto)ologin;
    System.out.println("dto:"+dto.toString());
   int seq = dto.getMember_seq();
   String id = dto.getMember_id();
   fileName = dto.getMember_Photo();
   List<RentDto> rentpagelist =  dao.getRentPageList(id.trim());
      MemberDto dto1 = dao.getMyPageList(id);
   System.out.println("id:"+id + "seq:" + seq);
   int RC_Rent_Seq = dao.getSeq(id);
   System.out.println("RC_Rent_Seq:"+RC_Rent_Seq);
   System.out.println("fileName: "+fileName); 
    %>
    

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<title>MyPage.jsp</title>

</head>
<script src="./jq/jquery.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<body>

<div class="w3-sidebar w3-bar-block w3-card w3-animate-left" style="display:none" id="mySidebar">
  <button class="w3-bar-item w3-button w3-large"
  onclick="w3_close()">Close &times;</button>
  
  <button class="w3-bar-item w3-button tablink" onclick="openLink(event, 'info_Change')">정보수정</button>
  <button class="w3-bar-item w3-button tablink" onclick="openLink(event, 'check_Res')">예약확인</button>
  <button class="w3-bar-item w3-button tablink" onclick="openLink(event, 'del_Member')">회원탈퇴</button>
  <%-- <form action="myPage"><input type="hidden" name="M_Command" value="DelMember">
  <input type="hidden" name="seq" value="<%=seq%>"><input type="submit" value="회원탈퇴"></form> --%>
		<form action="index.jsp"><button type="submit">메인화면</button></form>

	</div>

<div id="main">

<div class="w3-teal">
  <button id="openNav" class="w3-button w3-teal w3-xlarge" onclick="w3_open()">&#9776;</button>
  <div class="w3-container">
    <h1>My Page</h1>
  </div>
</div>
<img alt='/images/noImage.png' src="<%= "\\\\192.168.30.31\\Users\\user2\\images\\"+dto.getMember_Photo() %>" style="width: 120px; height: 120px;">
<div>
<h1>Dear, <%=id %>'s Page</h1>
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
</div>
<hr>

<!-- here 정보 수정 화면  -->
<div id="info_Change" class="w3-container city w3-animate-opacity" style="display:none">
    
    <h2>정보수정 화면</h2>
    <form action="updateInfo.jsp" method="post" enctype="multipart/form-data">
    <table>
    		<%if(fileName != null){ %>
		<tr>
			<td>
				<img alt="" src="image/<%=fileName %>" height="100" width="100">
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
       
    <input type="submit" value="Convert it!!">
    </form>
</div>

<!-- here del_Member -->
<div id="del_Member" class="w3-container city w3-animate-opacity" style="display:none">
<h2>회원탈퇴 화면</h2>
<form action="myPage">
<input type="hidden" name="M_Command" value="DelMember">
<input type="hidden" name="seq" value="<%=seq%>">
<input type="submit" value="탈퇴하기">
</form>
</div>

<!-- here 예약 확인 화면 -->
<div id="check_Res" class="w3-container city w3-animate-opacity" style="display:none">

 <h2>예약확인 화면</h2>
 <%
 Date today = new Date();
 SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");
 	System.out.println(date.format(today));
 %>
 오늘의 날짜:<%=date.format(today) %>
 <div>

<table border="1">
<col width="20"><col width="100"><col width="120"><col width="120"><col width="70"><col width="70"><col width="70"><col width="70">
<col width="70"><col width="70"><col width="70"><col width="70"><col width="70"><col width="70">
<tr>
	<th>번호</th><th>차량 이름</th><th>계약시작일</th><th>계약종료일</th><th>회원아이디</th><th>대여료</th><th>운전자</th><th>RC_PHONE</th>
	<th>RC_ADDRESS</th><th>RC_CARD</th><th>RC_PHOTO</th><th>예약날짜변경</th><th>예약취소</th>
</tr>
<%
if(rentpagelist == null || rentpagelist.size() ==0){
	%>
	<tr><td colspan="13">예약하신 차량이 없습니다.</tr><%}else{
				
		
		for(int i=0 ; i < rentpagelist.size() ; i++){
			RentDto rent = rentpagelist.get(i);
			System.out.println("rent end: "+rent.getRent_end());
			
			
			String end_day = rent.getRent_end().trim();
			Date d_end = new SimpleDateFormat("yyyy-MM-dd").parse(end_day);
			System.out.println("d_end: "+d_end+"today:"+today);
			Date sysdate = new SimpleDateFormat("yyyy-MM-dd").parse(date.format(today));
			int compare = d_end.compareTo(sysdate); //sys가 크면 양수 ,같으면 0, 작으면 음수
			
			if(compare>=0){System.out.println("compare"+compare);
			
		%>
	<tr>
		<form action="reschedule.jsp">
		<td><%=i+1 %></td>
		<td><%=rent.getRent_carname() %></td>
		<td><%=rent.getRent_start() %></td>
		<td><%=rent.getRent_end() %></td>
		<td><%=rent.getCus_id() %></td>
		<td><%=rent.getPrice() %>원</td>
		<td><%=rent.getRc_name() %></td>
		<td><%=rent.getRc_phone() %></td>
		<td><%=rent.getRc_address() %></td>
		<td><%=rent.getRc_card() %></td>
		<td><%=rent.getRc_photo() %></td>
		
		<td>
		<input type="hidden" id="start" name="start">
		<input type="hidden" id="end" name="end">
		<input type="hidden" name="seq" value="<%=rent.getRent_seq()%>">
		<input type="hidden" name="id" value="<%=rent.getCus_id()%>">
		<input type="hidden" name="carName" value="<%=rent.getRent_carname()%>">
		<input type="hidden" name="M_Command" value="reschedule">
		<input type="radio" name="chkbox" class="chkbox" value="<%=rent.getRent_seq() %>">
		<input type="submit" value="날짜 변경">
		</td>
		</form>
		
		<td>
		<form action="resv_cancel.jsp">
		<input type="hidden" name="id" value="<%=rent.getCus_id()%>">
		<input type="hidden" name="seq" value="<%=rent.getRent_seq()%>">
		<input type="submit" value="예약 취소">
		</form>
		</td>
		
		
	</tr>
	<%}else if(compare<0){ System.out.println("compare"+compare);%>
	<tr>
	
	<td><%=i+1 %></td>
		<td><%=rent.getRent_carname() %></td>
		<td><%=rent.getRent_start() %></td>
		<td><%=rent.getRent_end() %></td>
		<td><%=rent.getCus_id() %></td>
		<td><%=rent.getPrice() %>원</td>
		<td><%=rent.getRc_name() %></td>
		<td><%=rent.getRc_phone() %></td>
		<td><%=rent.getRc_address() %></td>
		<td><%=rent.getRc_card() %></td>
		<td><%=rent.getRc_photo() %></td>
		<td><button>Disable</button></td>
		<td><button>Disable</button></td>
	
	</tr>
	
	
<%}
}
} %>


</table>

 </div>

</div>

</form>

</div>



<script>
function w3_open() {
  document.getElementById("main").style.marginLeft = "25%";
  document.getElementById("mySidebar").style.width = "25%";
  document.getElementById("mySidebar").style.display = "block";
  document.getElementById("openNav").style.display = 'none';
}
function w3_close() {
  document.getElementById("main").style.marginLeft = "0%";
  document.getElementById("mySidebar").style.display = "none";
  document.getElementById("openNav").style.display = "inline-block";
}
</script>

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

<script type="text/javascript">
function deletei(seq) {
	$("#deletebtn").click(function () {
		alert("click"+seq);
		
	})
}
</script>

</body>
</html>