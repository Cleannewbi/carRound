<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="model.MemberDto"%>
<%@page import="service.memberDaoService"%>
<%@page import="service.memberDaoServiceImpl"%>
<%@page import="service.InfoDaoService"%>
<%@page import="model.InfoDto"%>
<%@page import="service.InfoDaoServiceImpl"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<% request.setCharacterEncoding("KSC5601");%>
<%
	//1.정보넘겨받기 
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String carName =  request.getParameter("carName");

	String startDate = request.getParameter("startDate");
	String endDate = request.getParameter("endDate");

	System.out.println("index에서 가져온 id : "+id+" pw : "+pw+"carName : "+carName+" startDate : "+startDate+" endDate : "+endDate);
	/*
	//login 값 받기
	Object ologin = session.getAttribute("login");
	Object rent = session.getAttribute("rentInfo");
	MemberDto mem = null;
	RentDto rentdto = null;
	if (ologin ==null){//값이 제대로 안넘어왔거나 로그인한지 한참되었거나
	
		<script type="text/javascript">
			alert("session이 비어있습니다.");
			location.href="inex.jsp";
		</script>

			return; 
		}
		mem=(MemberDto)ologin;	//로그인시 받은 사용자의 dto
		rentdto = (RentDto)rentInfo;		
		String startDate = rentdto.getStr;
		String endDate = getRent_start;
		String carName =getRent_end
		*/
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=TyohXIeFvfwc1UdkRR_2&submodules=geocoder"></script>
<style type="text/css">
.title{
	color:#76bcba 
}
.content{
	font-size: 17px;
	color:#595959;
}
#userTable{
	font-size: 17px;
	color:#595959;
	border-bottom: 1px solid #595959;
}
#topData{
	vertical-align: top;
}
</style>
</head>
<body>

<%
	//선언
	InfoDaoServiceImpl infoService = new InfoDaoService();
	memberDaoServiceImpl memberService = new memberDaoService();
	
	//2.car Info
	InfoDto carInfoDto = infoService.getCarInfo(carName);
	System.out.println("carInfo : "+carInfoDto);
	
	//3.member Info
	MemberDto userDto = memberService.getMember(id, 1);
	System.out.println("userDto : "+userDto);
		//member 결제정보
		String cards = userDto.getMember_card().trim();		//0000-0000-0000-0000
		String card[] = new String[4];
		card[0]=cards.substring(0,4);
		card[1]=cards.substring(4,8);
		card[2]=cards.substring(8,12);
		card[3]=cards.substring(12,16);
		
		//member 대여일 
		int startDateYear =Integer.parseInt(startDate.substring(0,4));
		int startDateMonth = Integer.parseInt(startDate.substring(4,6));
		int startDateDay = Integer.parseInt(startDate.substring(6,8));
		
		int endDateYear = Integer.parseInt(endDate.substring(0,4));
		int endDateMonth = Integer.parseInt(endDate.substring(4,6));
		int endDateDay = Integer.parseInt(endDate.substring(6,8));
		
		//객체생성
		Calendar StDay = Calendar.getInstance();
		Calendar Dday = Calendar.getInstance();
		
		//날짜적용
		Dday.set(endDateYear, endDateMonth-1, endDateDay);
		StDay.set(startDateYear, startDateMonth-1,startDateDay);
		
		// time추출
		long EndDay = Dday.getTimeInMillis();
		long StartDay = StDay.getTimeInMillis();
		
		//렌트일수 
		long RentDays = (EndDay-StartDay)/(60*60*24*1000);
		System.out.println("●rent 날짜 : " +RentDays);
		
 		//최종결제금액
 		int carFee = Integer.parseInt(carInfoDto.getCar_fee().replace(",", ""))*(int)(long)RentDays;
 		int deli = 0;	//딜리버리 추가금액
 		
		DecimalFormat formatter = new DecimalFormat("###,###,###");

	//4.company Info
	MemberDto companyDto= memberService.getMember(carInfoDto.getCom_name(),2);
	System.out.println("company dto : "+companyDto);
	
%>

<div style="margin-left: 60px">
<table>
<col width="600"><col width="100">
<tr>
	<td colspan="2" height="70" > <font size="7px"><%=carInfoDto.getCar_name() %></font> </td>
</tr>
<tr>
	<td height="400" > <%=carInfoDto.getCar_pic() %></td>
	<td id="topData"><%=carInfoDto.getCar_type() %><br><%=carInfoDto.getCar_size() %><br><%=carInfoDto.getCar_fuel()%> </td>
</tr>

</table>
</div>

<hr style="color: grey">
<div style="margin-left: 60px">
<h2 class="title">운전자정보</h2>
<table id="userTable">
<col width="150"><col width="200">
<tr>
	<td class="userTable"> <font color="grey">이름</font> </td>
	<td class="userTable"><%=userDto.getMember_name()%></td>
</tr>
<tr>
	<td class="userTable">연락처</td>
	<td class="userTable"><%=userDto.getMember_phone().substring(0, 3)%>-<%=userDto.getMember_phone().substring(3, 7)%>-<%=userDto.getMember_phone().substring(7, 11)%></td>
</tr>
<tr>
	<td class="userTable">주소</td>
	<td class="userTable"><%=userDto.getMember_address()%></td>
</tr>
<tr>
	<td class="userTable">결제정보</td>
	<td  class="userTable"><%=card[0]%>-<%=card[1]%>-<%=card[2]%>-<%=card[3]%>	</td>
</tr>
<tr>
	<td class="userTable">운전면허 번호</td>
	<td  class="userTable"><%=userDto.getMember_Photo()%>	</td>
</tr>
</table>
<br>
<font size="3" color="puple">※고객님의 정보가 맞는지 확인하여 주십시오.</font>
</div>
<br>
<hr color="grey">
<br>
<div style="margin-left: 60px">
<h2 class="title">업체명</h2>
<p class="content"><%=companyDto.getMember_name() %></p>
<h2  class="title">주소</h2>
<p  class="content"><%=companyDto.getMember_address() %></p>
<h2 class="title">전화번호</h2>
<p  class="content"><%=companyDto.getMember_phone().substring(0, 3)%>-<%=companyDto.getMember_phone().substring(3, 7)%>-<%=companyDto.getMember_phone().substring(7, 11)%></p>

<div id="map" style="width:40%;height:400px;"></div>
</div>
<script>
var mapOptions = {
    center: new naver.maps.LatLng(37.3595704, 127.105399),
    zoom: 10
};

var map = new naver.maps.Map('map', mapOptions);
</script>

<hr style="color: grey">
<div style="margin-left: 60px">
<h2  class="title">옵션선택</h2>
<p  class="content">딜리버리 서비스 <input type="checkbox" id="deliCheck" onclick="deliFunc(this)"></p>
</div>
<hr>
<div style="margin-left: 60px">
<h2  class="title">결제정보</h2>
<table>
<col width="250"><col width="250">
<tr height="30">
	<td class="content">대여료</td>
	<td align="right"  class="content"><%=carInfoDto.getCar_fee() %> 원</td>
</tr>
<tr height="30">
	<td> <font size="3" color="#595959">대여일수</font> </td>
	<td align="right"  class="content"><%=RentDays %>일</td>
</tr>
<tr height="30">
	<td> <font size="3" color="#595959 ">딜리버리</font> </td>
	<td align="right" class="content" id="deliPrice">0원</td>
</tr>
<tr height="30">
	<td><font size="4" color="red"><b>최종 결제금액</b></font></td>
	<td align="right" id="finalFee"><font size="4" color="red"><b><%=formatter.format(carFee+deli)%>원</b></font></td>
</tr>
</table>
</div>

<br><br>
<input type="submit"  value="결제하기">


<script type="text/javascript">
 	function deliFunc( e ) {
 		if ($('input:checkbox[id="deliveryCheck"]').is(":checked")){
 			alert("선택");
 			document.getElementById("deliPrice").innerHTML="10,000원";
 			<% deli = 10000;%>
  			var testdeli = "<%=deli %>";
 	 		alert("testdeli = " + testdeli);
 	 		var testdeliCar = "<%=formatter.format(carFee+deli) %>";
 	 		alert("testdeliCar = " + testdeliCar); 
 	 		var deliv = $('#delivery').val();
 	 		alert("딜리버리  : "+deliv);
 	 		var deliCh = $("#deliCheck").val();
 	 		alert("체크박스 : "+deliCh);

  	 <%-- 	 	$.ajax({
 	 			url : "./controller.jsp",
 	 			type : "post",
 	 			data : deliCheck,
 	 			success:function(data){
 	 				alert("통신성공!");
 	 				alert("testdeliCar = " + testdeliCar);
 	 				data=<%=deli%>;
 	 				$("#finalFee").val(<%=formatter.format(carFee+deli) %>);
 	 			},
 	 			error:function(){
 	 				alert("통신실패!");
 	 			}
 	 		}); 
 	 		  --%>
 		}else {
 			alert("선택해제");
 			document.getElementById("deliPrice").innerHTML="0원";
 			<% deli = 0;%>
 			var testdeli = "<%=deli %>";
 	 		alert("testdeli = " + testdeli);
 	 		var testdeliCar = "<%=formatter.format(carFee+deli)%>";
 	 		alert("testdeliCar = " + testdeliCar);
 	 		alert($("#delivery").val());
  	 		
 <%-- 	 		$.ajax({
 	 			url : "controller.jsp",
 	 			type : "post",
 	 			data :  ,
 	 			success:function(data){
 	 				alert("통신성공!");
 	 				alert("testdeliCar = " + testdeliCar);
 	 				data=<%=deli%>;
 	 				$("#finalFee").val(<%=formatter.format(carFee+deli) %>);
 	 			},
 	 			error:function(){
 	 				alert("통신실패!");
 	 			}
 	 		});  --%>
 		}
	} 
	

</script>
</body>
</html>