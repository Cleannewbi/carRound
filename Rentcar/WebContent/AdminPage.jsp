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
    
    <%!
	// nvl 함수
	public boolean nvl(String msg){
		return msg == null || msg.trim().equals("")?true:false;
	}
   
	public String two(String msg){
		return msg.trim().length() < 2 ? "0"+msg : msg.trim(); 
	}	
    
    public String makeTable(int year, int month, int day, List<RentDto> list)
    {
    	String s = "";
    	String dates = (year + "") + two(month + "") + two(day + ""); // 20181001
    	
    	Calendar cal = Calendar.getInstance();
    	int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
    	int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
    	
 
    	s += "<table width='100%' border='0' cellspacing='0' cellpadding='0'>";
    	s += "<col width='98'>";
    	
    	for(RentDto dto : list){
			
    		String Sday = dto.getRent_start().replace("-", ""); 
    		String Eday = dto.getRent_end().replace("-", "");
    		
    		int startday = Integer.parseInt(Sday.substring(0,8));
   			int endday = Integer.parseInt(Eday.substring(0,8));   	
    		int date = Integer.parseInt(dates);
    		
    		if(Sday.substring(0, 8).equals(dates)){
    			if(dto.getRent_seq()%2 == 0){
    				s += "<tr bgcolor='pink'>";
    			}else{
    				s += "<tr bgcolor='lightgray'>";
    			}
    			s += "<td>";
    			s += "<font style='font-size:8; color:red'>";
    			s += dto.getCus_id() + "시작일";
    			s += "</font>";
    			s += "</td>";
    			s += "</tr>";			
    		}else if(Eday.substring(0, 8).equals(dates)){
     			
    			if(dto.getRent_seq()%2 == 0){
    				s += "<tr bgcolor='pink'>";
    			}else{
    				s += "<tr bgcolor='lightgray'>";
    			}
    			s += "<td>";
    			s += "<font style='font-size:8; color:red'>";
    			s += dto.getRc_name() + "종료일";
    			s += "</font>";
    			s += "</td>";
    			s += "</tr>";	
    			

    			
    		}
/*     		else if( startday < date && endday > date ){
    			if(dto.getRent_seq()%2 == 0){
    				s += "<tr bgcolor='pink'>";
    			}else{
    				s += "<tr bgcolor='lightgray'>";
    			}
    			s += "<td style='padding-left:10px'>";
    			s += "&nbsp";
    			s += "</td>";
    			s += "</tr>";	
    			
    		}  */
 
    	}	
    	s += "</table>";
    	
    	return s;
    }
    
    
    %>
<!DOCTYPE html>
<html>
<title>W3.CSS</title>
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
    
 <%
Calendar cal = Calendar.getInstance();
cal.set(Calendar.DATE, 1);

String syear = request.getParameter("year");
String smonth = request.getParameter("month");

int year = cal.get(Calendar.YEAR);
if(nvl(syear) == false){	// 파라미터로 넘어온 데이터가 있을 시
	year = Integer.parseInt(syear);
}

int month = cal.get(Calendar.MONTH) + 1;
if(nvl(smonth) == false){
	month = Integer.parseInt(smonth);
}

if(month < 1){
	month = 12;
	year--;
}

if(month > 12){
	month = 1;
	year++;
}

cal.set(year, month - 1, 1);	// 연월일 셋팅완료

// 요일
int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);

// <<
String pp = String.format("<a href='%s?year=%d&month=%d'>"
							+ "<img src='image/left.gif'></a>", 
								"comPage.jsp", year-1, month);

// <
String p = String.format("<a href='%s?year=%d&month=%d'>"
							+ "<img src='image/prec.gif'></a>", 
								"comPage.jsp", year, month-1);

// >
String n = String.format("<a href='%s?year=%d&month=%d'>"
							+ "<img src='image/next.gif'></a>", 
								"comPage.jsp", year, month+1);

// >>
String nn = String.format("<a href='%s?year=%d&month=%d'>"
							+ "<img src='image/last.gif'></a>", 
							"comPage.jsp", year+1, month);


 // List<RentDto> list = (List<RentDto>)request.getAttribute("rentlist");

	
	//String id = "tirepia";		// 임시 회사 아이디 :giaotoq
	RentDao rentdao = RentDao.getInstance();
//	List<RentDto> list = dao.getRentList();
	List<RentDto> list = rentdao.getRentList(id); 
	
			

%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<body>

<div class="w3-sidebar w3-bar-block w3-black w3-card" style="width:130px">
  <h5 class="w3-bar-item">Company Page</h5>
  <button class="w3-bar-item w3-button tablink" onclick="openLink(event, 'Fade1')">정보수정</button>
  <button class="w3-bar-item w3-button tablink" onclick="openLink(event, 'Fade2')">스케쥴러</button>
  <button class="w3-bar-item w3-button tablink" onclick="openLink(event, 'Fade3')">회원탈퇴</button>
  <button class="w3-bar-item w3-button tablink" onclick="openLink(event, 'Fade4')">메인화면</button>  
</div>

<div style="margin-left:130px">
  <div class="w3-padding">
  <img alt='./images/noImage.png' src='./images/<%=fileName%>' style="width: 120px; height: 120px;">

<%System.out.println("oMyPage.jsp img:"+dto1.getMember_Photo().trim()); %>
 
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

<hr>
  
</div>

  <div id="Fade1" class="w3-container city w3-animate-opacity" style="display:none">
    <h2>정보 수정</h2>
    <p>London is the capital city of .</p>
    <p>It is the most populous city in the United Kingdom, with a metropolitan area of over 13 million inhabitants.</p>
  </div>
  <div id="Fade2" class="w3-container city w3-animate-opacity" style="display:none">
    <h2>스케쥴러</h2>
    
<div align="center">

<table class="table" >
<col width="100"><col width="100"><col width="100"><col width="100">
<col width="100"><col width="100"><col width="100">

<tr height="100" >
	<td colspan="7" align="center">
		<%=pp %>&nbsp;<%=p %>
		<font color="black" style="font-size: 50px; color: #76bcba  " >
			<%=String.format("%d년&nbsp;&nbsp;%d월", year, month) %>
		</font>
		<%=n %>&nbsp;<%=nn %>
	</td>
</tr>

<tr height="100" style="color: #76bcba;">
	<td align="center">일</td>
	<td align="center">월</td>
	<td align="center">화</td>
	<td align="center">수</td>
	<td align="center">목</td>
	<td align="center">금</td>
	<td align="center">토</td>
</tr>

<tr height="100" align="left" valign="top">
<%
//위쪽 빈칸
for(int i = 1;i < dayOfWeek; i++){
	%>
	<td>&nbsp;</td>	
	<%
}

// 날짜
int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
for(int i = 1;i <= lastDay; i++){
	%>
	<td style="color: #595959; "><%=i %>&nbsp;<%-- <%=showPen(year, month, i) %> --%>	
		<%=makeTable(year, month, i, list) %>
	</td>
	<%
	if((i + dayOfWeek - 1) % 7 == 0 && i != lastDay){
		%>
		</tr><tr height="100" align="left" valign="top">
		<%
	}
}

// 밑칸
for(int i = 0;i < (7 - (dayOfWeek + lastDay - 1) % 7 ) % 7; i++){
	%>
	<td>&nbsp;</td>	
	<%
}


%>
</tr>



</table>

</div>
   
  </div>
  <div id="Fade3" class="w3-container city w3-animate-opacity" style="display:none">
    <h2>회원 탈퇴</h2>
    <p>London is the capital city of England.</p>
    <p>It is the most populous cit
  <div id="Fade4" class="w3-container city w3-animate-opacity" style="display:none">
    <h2>메인 화면</h2>
    <p>London is the capital England.</p>
    <p>It is the most populous city th a metropolitan area of over 13 million inhabitants.</p>
  </div>

  

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