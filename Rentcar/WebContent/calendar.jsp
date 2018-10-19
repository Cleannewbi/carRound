<%@page import="dto.RentDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.RentDao"%>
<%@page import="java.util.Calendar"%>
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
    
    
    
    
    
    
    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
  
  table{border-spacing:0px;border-style:none;padding:0px;}
  td{border-spacing:0px;border-style:none;padding:0px;}

 </style>


</head>
<body>




<%
String id = request.getParameter("id");
System.out.println("calendar id:"+id);
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
String pp = String.format("<a href='%s?id=%s&year=%d&month=%d'>"
							+ "<img src='image/left.gif'></a>", 
								"calendar.jsp",id, year-1, month);

// <
String p = String.format("<a href='%s?id=%s&year=%d&month=%d'>"
							+ "<img src='image/prec.gif'></a>", 
								"calendar.jsp",id, year, month-1);

// >
String n = String.format("<a href='%s?id=%s&year=%d&month=%d'>"
							+ "<img src='image/next.gif'></a>", 
								"calendar.jsp",id, year, month+1);

// >>
String nn = String.format("<a href='%s?id=%s&year=%d&month=%d'>"
							+ "<img src='image/last.gif'></a>", 
							"calendar.jsp",id, year+1, month);


 // List<RentDto> list = (List<RentDto>)request.getAttribute("rentlist");

	
	//String id = "tirepia";		// 임시 회사 아이디 :giaotoq
	RentDao dao = RentDao.getInstance();
//	List<RentDto> list = dao.getRentList();
	List<RentDto> list = dao.getRentList(id);
	
			

%>
<a href="comPage.jsp">뒤로가기</a>

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

</body>
</html>