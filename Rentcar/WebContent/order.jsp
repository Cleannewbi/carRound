<%@page import="dto.RentDto"%>
<%@page import="dao.MemManager"%>
<%@page import="dao.iMemManager"%>
<%@page import="dao.InfoDao"%>
<%@page import="dao.iInfoDao"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="dto.MemberDto"%>
<%@page import="dto.InfoDto"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<% request.setCharacterEncoding("KSC5601");%>
<%
	//1.정보넘겨받기 
/*
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String _seq = request.getParameter("seq");
	int seq = Integer.parseInt(_seq);
	String carName =  request.getParameter("carName");
	String comName = request.getParameter("comName");


	System.out.println("index에서 가져온 id : "+id+" pw : "+pw+"carName : "+carName+" startDate : "+startDate+" endDate : "+endDate); */
    System.out.println("-----------------order.jsp-----------------");
	String _seq = request.getParameter("seq");
	int seq = Integer.parseInt(_seq);
	System.out.println("seq : " + seq);
	String carName =  request.getParameter("carName");
	System.out.println("carName : " + carName);
	String comName = request.getParameter("comName");
	System.out.println("comName : " + comName);
	String startDate = request.getParameter("startDate").replace("-","");
	
	System.out.println("StartDate : " + startDate);
	String endDate = request.getParameter("endDate").replace("-", "");
	System.out.println("endDate : " + endDate);
	//login 값 받기
	Object ologin = session.getAttribute("login");
	//start day , end day, 차 이름 = rentInfo 라는 이름의 session으로 받아오기
	Object rent = session.getAttribute("rentInfo");
	MemberDto mem = null;
	RentDto rentdto = null;


	mem = (MemberDto)ologin;	//로그인시 받은 사용자의 dto
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
<style type="text/css">
.title{
	color:#76bcba;
}
.content{
	font-size: 17px;
	color:#595959;
}
#userTable{
	font-size: 17px;
	color:#595959;
	height: 200px;
    border-collapse: collapse;
}
#topData{
	vertical-align: top;
}
.userTd{
 	border-bottom: 1px solid #444444;
    padding: 10px;
}
.btn{
	display:inline-block;
	border-radius:0.35em;
	text-decoration:none;
	font-weight:400;
	width:200px;
	height:60px;
	font-size:15px;
	color:#FFF;
	background-color:#8ebdbc;
	border: 0;
	outline: 0;
	cursor: pointer;
}
</style>
</head>
<body>

<%
	//선언
	iInfoDao infoService = InfoDao.getInstance();
	iMemManager memberService = MemManager.getInstance();
	
	//2.car Info
	InfoDto carInfoDto = infoService.getInfoList(seq);
	
	System.out.println("carInfo : "+carInfoDto);
	
	//3.member Info
	MemberDto userDto = memberService.getMember(mem.getMember_id(), 1);
	System.out.println("userDto : "+userDto);
	
		//member 결제정보
		String cards = userDto.getMember_card().trim();		//0000-0000-0000-0000
		System.out.println("userDto.getMember_card() info: "+cards);
		String card[] = new String[4];
		if(userDto.getMember_card().length()==16){
		//String card[] = new String[4];
		card[0]=cards.substring(0,4);
		card[1]=cards.substring(4,8);
		card[2]=cards.substring(8,12);
		card[3]=cards.substring(12,16);}
		else {
			card[0]="1111";
			card[1]="2222";
			card[2]="3333";
			card[3]="4444";
		}
		
		//member photo
		String photoName = "";
		try{
			photoName = userDto.getMember_Photo().trim();
		    System.out.println("dto1.contain:"+userDto.getMember_Photo().contains("."));
		} catch(Exception e) {
		    	System.err.println(e);
		}
		if(!photoName.isEmpty() && photoName.contains(".")){
	    	//fileName = dto1.getMember_Photo().trim();
	    	System.out.println("dto1 photo 이미지 있음:"+userDto.getMember_Photo().trim());
	    } else if(!photoName.contains(".") || photoName.isEmpty()){
	    	System.out.println("dto1 photo 이미지가 아님:"+userDto.getMember_Photo().trim());
	    	photoName = "noImage.png";
	    } 
		
		//member 전화번호 
		String userPhone[] = new String[3];
		String userPh = userDto.getMember_phone().replace("-", "");
		userPh=userPh.trim();
		if (userPh.length()>10){	//11이면
			userPhone[0]=userPh.substring(0, 3);
			userPhone[1]=userPh.substring(3, 7);
			userPhone[2]=userPh.substring(7, 11);
			
		}else if  (userDto.getMember_phone().length()<10){//9이면
			userPhone[0]=userDto.getMember_phone().substring(0, 2);
			userPhone[1]=userDto.getMember_phone().substring(2, 5);
			userPhone[2]=userDto.getMember_phone().substring(5, 9);
		}
		
		//member 대여일 
		System.out.println("------------member 대여일------------");
		System.out.println("startDate:"+startDate+" endDate: "+endDate);
		int startDateYear=2018;
		int startDateMonth =10;
		int startDateDay = 1;
		int endDateYear = 2018;
		int endDateMonth = 10;
		int endDateDay = 30;
		if(startDate != null && !startDate.equals("") && !startDate.equals(" ") && endDate != null){
			
		startDateYear =Integer.parseInt(startDate.substring(0,4));
		startDateMonth = Integer.parseInt(startDate.substring(4,6));
		startDateDay = Integer.parseInt(startDate.substring(6,8));
		
		endDateYear = Integer.parseInt(endDate.substring(0,4));
		endDateMonth = Integer.parseInt(endDate.substring(4,6));
		endDateDay = Integer.parseInt(endDate.substring(6,8));
		}
		System.out.println("●startYear : " +startDateYear+" / Month : "+startDateMonth+" / Day"+startDateDay);
		System.out.println("●endYear : " +endDateYear+" / Month : "+endDateMonth+" / Day"+endDateDay);
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
 		//최종결제금액
 		int carFee = Integer.parseInt(carInfoDto.getCar_fee().replace(",", ""))*(int)(long)RentDays;
 		//최종결제금액 컴마생성
		DecimalFormat formatter = new DecimalFormat("###,###,###");
		
 		//딜리버리 추가금액
 		int deli = 0;	
	//4.company Info
	MemberDto companyDto= memberService.getMember(carInfoDto.getCom_name(), 2);
	System.out.println("company dto : "+companyDto);
	
		//회사 폰
		String comPhone[] = new String[3];
		String comPh = companyDto.getMember_phone();
		comPh=comPh.trim();
		System.out.println(comPh);
		
		if(comPh.equals("") || comPh == null) {
			
		}
		
		if(comPh.contains("-")) {
			comPh = companyDto.getMember_phone().replace("-", "");
		}
		
		
		if (comPh.length()>10){	//11이면
			comPhone[0]=comPh.substring(0, 3);
			comPhone[1]=comPh.substring(3, 7);
			comPhone[2]=comPh.substring(7, 11);
						
		}else if (comPh.length()<10){	//9면
			comPhone[0]=comPh.substring(0, 2);
			comPhone[1]=comPh.substring(2, 5);
			comPhone[2]=comPh.substring(5, 9);
		}
		
	
%>

<form action="orderAf.jsp" method="post">
<input type="hidden" name="infoSeq" value="<%=carInfoDto.getInfo_seq()%>">
<input type="hidden" name="loginId" value="<%=mem.getMember_id()%>">
<div style="margin-left: 500px">
<table>
<col width="400"><col width="100">
<tr>
	<td colspan="2" height="70" > <input class="content" name="carName" type="text" value="<%=carInfoDto.getCar_name() %>" style="background-color:transparent; border: none; font-size:28px;"readonly="readonly">
	</td>
</tr>
<tr>
	<td height="300" ><img alt='./images/noImage.png' src='./images/<%=photoName%>' height="400"> </td>
	<td id="topData"><%=carInfoDto.getCar_type() %><br><%=carInfoDto.getCar_size() %><br><%=carInfoDto.getCar_fuel()%> </td>
</tr>

</table>
</div>

<div style="margin-left: 500px">
<h2 class="title">운전자정보</h2>
<table id="userTable" >
<col width="150"><col width="300">
<tr>
	<td class="userTd"><b>이름</b> </td>
	<td class="userTd"><input class="content" name="rcName" type="text" value="<%=userDto.getMember_name()%>" style="background-color:transparent; border: none;"></td>
</tr>
<tr>
	<td class="userTd"><b>연락처</b></td>
	<td class="userTd">
		<input class="content" name="rcPhone1" type="text" value="<%=userPhone[0]%>" size="2" style="background-color:transparent; border: none;">-&nbsp;&nbsp;
		<input class="content" name="rcPhone2" type="text" value="<%=userPhone[1]%>" size="2"  style="background-color:transparent; border: none;">-&nbsp;&nbsp;
		<input class="content" name="rcPhone3" type="text" value="<%=userPhone[2]%>"size="2"  style="background-color:transparent; border: none;">
	</td>
</tr>
<tr>
	<td class="userTd"><b>주소</b></td>
	<td class="userTd"><input name="rcAddress" class="content" type="text" value="<%=userDto.getMember_address()%>" style="background-color:transparent; border: none;"></td>
</tr>
<tr>
	<td class="userTd"><b>결제정보</b></td>
	<td  class="userTd">
		<input class="content" name="rcCard1" size="2"  type="text" value="<%=card[0]%>" style="background-color:transparent; border: none;">-&nbsp;
		<input class="content" name="rcCard2" size="2"  type="text" value="<%=card[1]%>" style="background-color:transparent; border: none;">-&nbsp;
		<input class="content" name="rcCard3" size="2"  type="text" value="<%=card[2]%>" style="background-color:transparent; border: none;">-&nbsp;
		<input class="content"name="rcCard4" size="2"  type="text" value="<%=card[3]%>" style="background-color:transparent; border: none;">
	</td>
</tr>
<tr>
	<td class="userTd"><b>운전면허 번호</b></td>
	<td  class="userTd"><input class="content" name="rcPhoto" type="text" value="<%=userDto.getMember_Photo()%>" style="background-color:transparent; border: none;"></td>
</tr>
</table>
<br>
<font size="3" color="blue">※고객님의 정보가 맞는지 확인하여 주십시오.</font>
</div>
<br>
<br>
<div style="margin-left: 500px">
<h2 class="title">업체명</h2>
<p class="content"><%=companyDto.getMember_name() %></p>
<h2  class="title">주소</h2>
<p  class="content"><%=companyDto.getMember_address() %></p>
<h2 class="title">전화번호</h2>
<p  class="content"><%=comPhone[0]%>-<%=comPhone[1]%>-<%=comPhone[2]%></p>

<div id="map" style="width:500px;height:400px;"></div>
</div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e53f47e84dfa687f87346382fb232397&libraries=services"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div
    mapOption = {
        center: new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  
	
	// 지도를 생성합니다    
	var map = new daum.maps.Map(mapContainer, mapOption); 
	
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new daum.maps.services.Geocoder();
	var company_address = "<%=companyDto.getMember_address()%>";
	
	// 주소로 좌표를 검색합니다
	geocoder.addressSearch(company_address, function(result, status) {
	
	    // 정상적으로 검색이 완료됐으면 
	     if (status === daum.maps.services.Status.OK) {
	
	        var coords = new daum.maps.LatLng(result[0].y, result[0].x);
	
	        // 결과값으로 받은 위치를 마커로 표시합니다
	        var marker = new daum.maps.Marker({
	            map: map,
	            position: coords
	        });
	
	        // 인포윈도우로 장소에 대한 설명을 표시합니다
	        var company_name = "<%=companyDto.getMember_name() %>";	
	        var infowindow = new daum.maps.InfoWindow({
	            content: '<div style="width:150px;text-align:center;padding:6px 0;">'+company_name+'</div>'
	        });
	        infowindow.open(map, marker);
	
	        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	        map.setCenter(coords);
	    } 
});    
</script>
<div style="margin-left: 500px">
<h2  class="title">옵션선택</h2>
<p  class="content">딜리버리 서비스 <input type="checkbox" id="deliveryCheck" onclick="deliFunc(this)"></p>
<p><font size="3" color="blue">딜리버리 서비스란? <br>위에 기재된 운전자 정보에서 픽업가능한 시스템입니다.</font>
</div>
<div style="margin-left: 500px">
<h2  class="title">결제정보</h2>
<table>
<col width="250"><col width="250">
<tr height="30">
	<td class="content">시작일</td>
	<% if(!startDate.equals("") && startDate != null && !startDate.equals(" ")) {%>
	<td align="right">
		<input class="content" name="startYear" size="2" type="text" value="<%=startDate.substring(0,4)%>년" style="background-color:transparent; border: none; text-align: right;" readonly="readonly" >
		<input class="content" name="startMonth" size="1" align="right" type="text" value="<%=startDate.substring(4,6)%>월" style="background-color:transparent; border: none; text-align: right;"readonly="readonly">
		<input class="content" name="startDay" size="1"  type="text" align="right" value="<%=startDate.substring(6,8)%>일" style="background-color:transparent; border: none; text-align: right;" readonly="readonly">
	</td>
	<%} %>
</tr>
<tr height="30">
	<td class="content">반납일</td>
	<%if(!endDate.equals("") && endDate != null && !endDate.equals(" ")) {%>
	<td align="right">
		<input class="content" name="endYear" size="2"  type="text" value="<%=endDate.substring(0,4)%>년" style="background-color:transparent; border: none; text-align: right;" readonly="readonly" >
		<input class="content" name="endMonth" size="1"  type="text" value="<%=endDate.substring(4,6)%>월" style="background-color:transparent; border: none; text-align: right;" readonly="readonly" >
		<input class="content" name="endDay" size="1"  type="text" value="<%=endDate.substring(6,8)%>일" style="background-color:transparent; border: none;text-align: right;" readonly="readonly"  >
	</td>
	<%} %>
</tr>
<tr height="30">
	<td class="content">대여료</td>
	<td align="right"  class="content"><%=carInfoDto.getCar_fee() %> 원</td>
</tr>
<tr height="30">
	<td class="content">대여일수</td>
	<td align="right"  class="content"><%=RentDays %>일</td>
</tr>
<tr height="30">
	<td class="content">딜리버리</td>
	<td align="right" class="content" id="deliPrice">0원</td>
</tr>
<tr height="30">
	<td><font size="4" color="red"><b>최종 결제금액</b></font></td>
	<td align="right">
		<input class="content" id="finalFee" name="price" type="text" value="<%=formatter.format(carFee+deli)%>원" style="color:red; background-color:transparent; border: none; text-align: right; font-weight: bold;" readonly="readonly"  >
	</td>
</tr>
</table>

<br><br>
</div>
<div align="center">
<input class="btn" type="submit"  value="결제하기">
</div>
<script type="text/javascript">
 	function deliFunc( e ) {
 		if ($('input:checkbox[id="deliveryCheck"]').is(":checked")){
 			document.getElementById("deliPrice").innerHTML="10,000원";
 			<% deli = 10000;%>
  			var testdeli = "<%=deli %>";
 	 		var testdeliCar = "<%=formatter.format(carFee+deli) %>";
 	 		document.getElementById("finalFee").value=testdeliCar+"원";
 	 		
 		}else {
 			document.getElementById("deliPrice").innerHTML="0원";
 			<% deli = 0;%>
 			var testdeli = "<%=deli %>";
 	 		var testdeliCar = "<%=formatter.format(carFee+deli)%>"; 	 		
 	 		document.getElementById("finalFee").value=testdeliCar+"원";
 		}
	} 
</script>
</form>
<br><br><br><br>


</body>
</html>