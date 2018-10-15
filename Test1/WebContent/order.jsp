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
	//1.�����Ѱܹޱ� 
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String carName =  request.getParameter("carName");
	String comName = request.getParameter("comName");

	String startDate = request.getParameter("startDate");
	String endDate = request.getParameter("endDate");

	System.out.println("index���� ������ id : "+id+" pw : "+pw+"carName : "+carName+" startDate : "+startDate+" endDate : "+endDate);
	/*
	//login �� �ޱ�
	Object ologin = session.getAttribute("login");
	//start day , end day, �� �̸� = rentInfo ��� �̸��� session���� �޾ƿ���
	Object rent = session.getAttribute("rentInfo");
	MemberDto mem = null;
	RentDto rentdto = null;
	if (ologin ==null){//���� ����� �ȳѾ�԰ų� �α������� �����Ǿ��ų�
	
		<script type="text/javascript">
			alert("session�� ����ֽ��ϴ�.");
			location.href="inex.jsp";
		</script>

			return; 
		}
		mem=(MemberDto)ologin;	//�α��ν� ���� ������� dto
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
</style>
</head>
<body>

<%
	//����
	InfoDaoServiceImpl infoService = new InfoDaoService();
	memberDaoServiceImpl memberService = new memberDaoService();
	
	//2.car Info
	InfoDto carInfoDto = infoService.getCarInfo(carName, comName);
	System.out.println("carInfo : "+carInfoDto);
	
	//3.member Info
	MemberDto userDto = memberService.getMember(id, 1);
	System.out.println("userDto : "+userDto);
		//member ��������
		String cards = userDto.getMember_card().trim();		//0000-0000-0000-0000
		String card[] = new String[4];
		card[0]=cards.substring(0,4);
		card[1]=cards.substring(4,8);
		card[2]=cards.substring(8,12);
		card[3]=cards.substring(12,16);
		
		//member �뿩�� 
		int startDateYear =Integer.parseInt(startDate.substring(0,4));
		int startDateMonth = Integer.parseInt(startDate.substring(4,6));
		int startDateDay = Integer.parseInt(startDate.substring(6,8));
		
		int endDateYear = Integer.parseInt(endDate.substring(0,4));
		int endDateMonth = Integer.parseInt(endDate.substring(4,6));
		int endDateDay = Integer.parseInt(endDate.substring(6,8));
		
		//��ü����
		Calendar StDay = Calendar.getInstance();
		Calendar Dday = Calendar.getInstance();
		
		//��¥����
		Dday.set(endDateYear, endDateMonth-1, endDateDay);
		StDay.set(startDateYear, startDateMonth-1,startDateDay);
		
		// time����
		long EndDay = Dday.getTimeInMillis();
		long StartDay = StDay.getTimeInMillis();
		
		//��Ʈ�ϼ� 
		long RentDays = (EndDay-StartDay)/(60*60*24*1000);
		System.out.println("��rent ��¥ : " +RentDays);
		
 		//���������ݾ�
 		int carFee = Integer.parseInt(carInfoDto.getCar_fee().replace(",", ""))*(int)(long)RentDays;
 		int deli = 0;	//�������� �߰��ݾ�
 		
		DecimalFormat formatter = new DecimalFormat("###,###,###");

	//4.company Info
	MemberDto companyDto= memberService.getMember(carInfoDto.getCom_name(),2);
	System.out.println("company dto : "+companyDto);
	
%>

<form action="orderAf.jsp" method="post">
<input type="hidden" name="infoSeq" value="<%=carInfoDto.getInfo_seq()%>">
<input type="hidden" name="loginId" value="<%=id%>">
<div style="margin-left: 500px">
<table>
<col width="600"><col width="100">
<tr>
	<td colspan="2" height="70" > <input class="content" name="carName" type="text" value="<%=carInfoDto.getCar_name() %>" style="background-color:transparent; border: none; font-size:28px;"readonly="readonly">
	</td>
</tr>
<tr>
	<td height="400" > <%=carInfoDto.getCar_pic() %></td>
	<td id="topData"><%=carInfoDto.getCar_type() %><br><%=carInfoDto.getCar_size() %><br><%=carInfoDto.getCar_fuel()%> </td>
</tr>

</table>
</div>

<hr style="color: grey">
<div style="margin-left: 500px">
<h2 class="title">����������</h2>
<table id="userTable" >
<col width="150"><col width="300">
<tr>
	<td class="userTd"><b>�̸�</b> </td>
	<td class="userTd"><input class="content" name="rcName" type="text" value="<%=userDto.getMember_name()%>" style="background-color:transparent; border: none;"></td>
</tr>
<tr>
	<td class="userTd"><b>����ó</b></td>
	<td class="userTd">
		<input class="content" name="rcPhone1" type="text" value="<%=userDto.getMember_phone().substring(0, 3)%>" size="2" style="background-color:transparent; border: none;">-&nbsp;&nbsp;
		<input class="content" name="rcPhone2" type="text" value="<%=userDto.getMember_phone().substring(3, 7)%>" size="2"  style="background-color:transparent; border: none;">-&nbsp;&nbsp;
		<input class="content" name="rcPhone3" type="text" value="<%=userDto.getMember_phone().substring(7, 11)%>"size="2"  style="background-color:transparent; border: none;">
	</td>
</tr>
<tr>
	<td class="userTd"><b>�ּ�</b></td>
	<td class="userTd"><input name="rcAddress" class="content" type="text" value="<%=userDto.getMember_address()%>" style="background-color:transparent; border: none;"></td>
</tr>
<tr>
	<td class="userTd"><b>��������</b></td>
	<td  class="userTd">
		<input class="content" name="rcCard1" size="2"  type="text" value="<%=card[0]%>" style="background-color:transparent; border: none;">-&nbsp;
		<input class="content" name="rcCard2" size="2"  type="text" value="<%=card[1]%>" style="background-color:transparent; border: none;">-&nbsp;
		<input class="content" name="rcCard3" size="2"  type="text" value="<%=card[2]%>" style="background-color:transparent; border: none;">-&nbsp;
		<input class="content"name="rcCard4" size="2"  type="text" value="<%=card[3]%>" style="background-color:transparent; border: none;">
	</td>
</tr>
<tr>
	<td class="userTd"><b>�������� ��ȣ</b></td>
	<td  class="userTd"><input class="content" name="rcPhoto" type="text" value="<%=userDto.getMember_Photo()%>" style="background-color:transparent; border: none;"></td>
</tr>
</table>
<br>
<font size="3" color="blue">�ذ����� ������ �´��� Ȯ���Ͽ� �ֽʽÿ�.</font>
</div>
<br>
<hr color="grey">
<br>
<div style="margin-left: 500px">
<h2 class="title">��ü��</h2>
<p class="content"><%=companyDto.getMember_name() %></p>
<h2  class="title">�ּ�</h2>
<p  class="content"><%=companyDto.getMember_address() %></p>
<h2 class="title">��ȭ��ȣ</h2>
<p  class="content"><%=companyDto.getMember_phone().substring(0, 3)%>-<%=companyDto.getMember_phone().substring(3, 7)%>-<%=companyDto.getMember_phone().substring(7, 11)%></p>

<div id="map" style="width:500px;height:400px;"></div>
</div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e53f47e84dfa687f87346382fb232397&libraries=services"></script>
<script>
var mapContainer = document.getElementById('map'), // ������ ǥ���� div
    mapOption = {
        center: new daum.maps.LatLng(33.450701, 126.570667), // ������ �߽���ǥ
        level: 3 // ������ Ȯ�� ����
    };  
	
	// ������ �����մϴ�    
	var map = new daum.maps.Map(mapContainer, mapOption); 
	
	// �ּ�-��ǥ ��ȯ ��ü�� �����մϴ�
	var geocoder = new daum.maps.services.Geocoder();
	var company_address = "<%=companyDto.getMember_address()%>";
	
	// �ּҷ� ��ǥ�� �˻��մϴ�
	geocoder.addressSearch(company_address, function(result, status) {
	
	    // ���������� �˻��� �Ϸ������ 
	     if (status === daum.maps.services.Status.OK) {
	
	        var coords = new daum.maps.LatLng(result[0].y, result[0].x);
	
	        // ��������� ���� ��ġ�� ��Ŀ�� ǥ���մϴ�
	        var marker = new daum.maps.Marker({
	            map: map,
	            position: coords
	        });
	
	        // ����������� ��ҿ� ���� ������ ǥ���մϴ�
	        var company_name = "<%=companyDto.getMember_name() %>";	
	        var infowindow = new daum.maps.InfoWindow({
	            content: '<div style="width:150px;text-align:center;padding:6px 0;">'+company_name+'</div>'
	        });
	        infowindow.open(map, marker);
	
	        // ������ �߽��� ��������� ���� ��ġ�� �̵���ŵ�ϴ�
	        map.setCenter(coords);
	    } 
});    
</script>
<hr style="color: grey">
<div style="margin-left: 500px">
<h2  class="title">�ɼǼ���</h2>
<p  class="content">�������� ���� <input type="checkbox" id="deliveryCheck" onclick="deliFunc(this)"></p>
<p><font size="3" color="blue">�������� ���񽺶�? <br>���� ����� ������ �������� �Ⱦ������� �ý����Դϴ�.</font>
</div>
<hr>
<div style="margin-left: 500px">
<h2  class="title">��������</h2>
<table>
<col width="250"><col width="250">
<tr height="30">
	<td class="content">������</td>
	<td align="right">
		<input class="content" name="startYear" size="2" type="text" value="<%=startDateYear%>��" style="background-color:transparent; border: none; text-align: right;" readonly="readonly" >
		<input class="content" name="startMonth" size="1" align="right" type="text" value="<%=startDateMonth%>��" style="background-color:transparent; border: none; text-align: right;"readonly="readonly">
		<input class="content" name="startDay" size="1"  type="text" align="right" value="<%=startDateDay%>��" style="background-color:transparent; border: none; text-align: right;" readonly="readonly">
	</td>
</tr>
<tr height="30">
	<td class="content">�ݳ���</td>
	<td align="right">
		<input class="content" name="endYear" size="2"  type="text" value="<%=endDateYear%>��" style="background-color:transparent; border: none; text-align: right;" readonly="readonly" >
		<input class="content" name="endMonth" size="1"  type="text" value="<%=endDateMonth%>��" style="background-color:transparent; border: none; text-align: right;" readonly="readonly" >
		<input class="content" name="endDay" size="1"  type="text" value="<%=endDateDay%>��" style="background-color:transparent; border: none;text-align: right;" readonly="readonly"  >
	</td>
</tr>
<tr height="30">
	<td class="content">�뿩��</td>
	<td align="right"  class="content"><%=carInfoDto.getCar_fee() %> ��</td>
</tr>
<tr height="30">
	<td class="content">�뿩�ϼ�</td>
	<td align="right"  class="content"><%=RentDays %>��</td>
</tr>
<tr height="30">
	<td class="content">��������</td>
	<td align="right" class="content" id="deliPrice">0��</td>
</tr>
<tr height="30">
	<td><font size="4" color="red"><b>���� �����ݾ�</b></font></td>
	<td align="right">
		<input class="content" id="finalFee" name="price" type="text" value="<%=formatter.format(carFee+deli)%>��" style="color:red; background-color:transparent; border: none; text-align: right; font-weight: bold;" readonly="readonly"  >
	</td>
</tr>
</table>
</div>

<br><br>
<input type="submit"  value="�����ϱ�">


<script type="text/javascript">
 	function deliFunc( e ) {
 		if ($('input:checkbox[id="deliveryCheck"]').is(":checked")){
 			alert("����");
 			document.getElementById("deliPrice").innerHTML="10,000��";
 			<% deli = 10000;%>
  			var testdeli = "<%=deli %>";
 	 		alert("testdeli = " + testdeli);
 	 		var testdeliCar = "<%=formatter.format(carFee+deli) %>";
 	 		//testdeliCar = "<font size='4' color='red'><b>"+testdeliCar+"��</b></font>";
 	 		alert("testdeliCar = " + testdeliCar); 

 	 		document.getElementById("finalFee").value=testdeliCar+"��";
 	 		
 		}else {
 			alert("��������");
 			document.getElementById("deliPrice").innerHTML="0��";
 			<% deli = 0;%>
 			var testdeli = "<%=deli %>";
 	 		alert("testdeli = " + testdeli);
 	 		var testdeliCar = "<%=formatter.format(carFee+deli)%>";
 	 		//testdeliCar = "<font size='4' color='red'><b>"+testdeliCar+"��</b></font>";
 	 		alert("testdeliCar = " + testdeliCar);
 	 		
 	 		document.getElementById("finalFee").value=testdeliCar+"��";
 
 		}
	} 


</script>
</form>
</body>
</html>