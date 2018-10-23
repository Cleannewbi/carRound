<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="model.ReviewDto"%>
<%@page import="model.RentDto"%>
<%@page import="dao.RentDao"%>
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
	String carName =  request.getParameter("carName");
	String comName = request.getParameter("comName");
	String startDate = request.getParameter("startDate");
	String endDate = request.getParameter("endDate");

	System.out.println("index���� ������ id : "+id+"carName : "+carName+" startDate : "+startDate+" endDate : "+endDate);

	
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
.underBorderTable{
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
#reviewTable{
	border: 2px solid gray;
    border-left: none;
    border-right: none;
}
.reviewTd{
	padding: 10px;
	font-size: 17px;
	color:#595959;
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
		
		//member ��ȭ��ȣ 
		String userPhone[] = new String[3];
		String userPh = userDto.getMember_phone().replace("-", "");
		userPh=userPh.trim();
		if (userPh.length()>10){	//11�̸�
			userPhone[0]=userPh.substring(0, 3);
			userPhone[1]=userPh.substring(3, 7);
			userPhone[2]=userPh.substring(7, 11);
			
		}else if  (userDto.getMember_phone().length()<10){//9�̸�
			userPhone[0]=userDto.getMember_phone().substring(0, 2);
			userPhone[1]=userDto.getMember_phone().substring(2, 5);
			userPhone[2]=userDto.getMember_phone().substring(5, 9);
		}
		
		//member �뿩�� 
		int startDateYear =Integer.parseInt(startDate.substring(0,4));
		int startDateMonth = Integer.parseInt(startDate.substring(4,6));
		int startDateDay = Integer.parseInt(startDate.substring(6,8));
		
		int endDateYear = Integer.parseInt(endDate.substring(0,4));
		int endDateMonth = Integer.parseInt(endDate.substring(4,6));
		int endDateDay = Integer.parseInt(endDate.substring(6,8));
		
		System.out.println("��startYear : " +startDateYear+" / Month : "+startDateMonth+" / Day"+startDateDay);
		System.out.println("��endYear : " +endDateYear+" / Month : "+endDateMonth+" / Day"+endDateDay);
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
 		//���������ݾ�
 		int carFee = Integer.parseInt(carInfoDto.getCar_fee().replace(",", ""))*(int)(long)RentDays;
 		//���������ݾ� �ĸ�����
		DecimalFormat formatter = new DecimalFormat("###,###,###");
		
 		//�������� �߰��ݾ�
 		int deli = 0;	
	//4.company Info
	MemberDto companyDto= memberService.getMember(carInfoDto.getCom_name(),2);
	System.out.println("company dto : "+companyDto);
	
		//ȸ�� ��
		String comPhone[] = new String[3];
		String comPh = companyDto.getMember_phone().replace("-", "");
		comPh=comPh.trim();
		if (comPh.length()>10){	//11�̸�
			comPhone[0]=comPh.substring(0, 3);
			comPhone[1]=comPh.substring(3, 7);
			comPhone[2]=comPh.substring(7, 11);
					
		}else if (comPh.length()<10){	//9��
			comPhone[0]=comPh.substring(0, 2);
			comPhone[1]=comPh.substring(2, 5);
			comPhone[2]=comPh.substring(5, 9);
		}
				
		//�ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡ��ı�� ����
		RentDao rendao = new RentDao();
		List<ReviewDto> reviewList = new ArrayList<>();
		reviewList =rendao.getReview(carInfoDto.getCar_name(), companyDto.getMember_name());
		for(int i=0; i<reviewList.size() ; i++) {
			System.out.println("order ������������ review : "+reviewList.get(i));
			System.out.println("order ������������ id : "+reviewList.get(i).getReview_cus_id() );
		}
		
		int reviewCount = rendao.getreviewCount(carInfoDto.getCar_name(), companyDto.getMember_name());
%>

<form action="orderAf.jsp" method="post">
<input type="hidden" name="infoSeq" value="<%=carInfoDto.getInfo_seq()%>">
<input type="hidden" name="loginId" value="<%=id%>">

<!-- �ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡ�
com_name �������� �߰���
-->

<div style="margin-left: 500px">
<img alt="dd" src="./image/<%=carInfoDto.getCar_pic()%>" height="400">
<input type="hidden" name="carName"  value="<%=carInfoDto.getCar_name()%>">
<input type="hidden" name="comName"  value="<%=companyDto.getMember_name() %>">
<h2 class="title">��������</h2>
<table class="underBorderTable" >
<col width="150"><col width="300">
<tr>
	<td class="userTd"><b>�� �̸�</b></td>
	<td class="userTd" ><%=carInfoDto.getCar_name()%></td>
</tr>
<tr>
	<td class="userTd"><b>�������</b></td>
	<td class="userTd"> <%=carInfoDto.getCar_size() %></td>
</tr>
<tr>
	<td class="userTd"><b>��������</b></td>
	<td class="userTd"> <%=carInfoDto.getCar_type() %></td>
</tr>
<tr>
	<td class="userTd"><b>����</b></td>
	<td  class="userTd"> <%=carInfoDto.getCar_fuel()%> </td>
</tr>
</table>
</div>
<br><br>
<!-- �ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡ� -->

<div style="margin-left: 500px">
<h2 class="title">����������</h2>
<table class="underBorderTable" >
<col width="150"><col width="300">
<tr>
	<td class="userTd"><b>�̸�</b> </td>
	<td class="userTd"><input class="content" name="rcName" type="text" value="<%=userDto.getMember_name()%>" style="background-color:transparent; border: none;"></td>
</tr>
<tr>
	<td class="userTd"><b>����ó</b></td>
	<td class="userTd">
		<input class="content" name="rcPhone1" type="text" value="<%=userPhone[0]%>" size="2" style="background-color:transparent; border: none;">-&nbsp;&nbsp;
		<input class="content" name="rcPhone2" type="text" value="<%=userPhone[1]%>" size="2"  style="background-color:transparent; border: none;">-&nbsp;&nbsp;
		<input class="content" name="rcPhone3" type="text" value="<%=userPhone[2]%>"size="2"  style="background-color:transparent; border: none;">
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
<br>
<div style="margin-left: 500px">
<h2 class="title">��ü��</h2>
<p class="content"><%=companyDto.getMember_name() %></p>
<h2  class="title">�ּ�</h2>
<p  class="content"><%=companyDto.getMember_address() %></p>
<h2 class="title">��ȭ��ȣ</h2>
<p  class="content"><%=comPhone[0]%>-<%=comPhone[1]%>-<%=comPhone[2]%></p>

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
<!-- �ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡ� �ı�-->
<div style="margin-left: 500px">
<h2 class="title">�ı�<font size="4">(<%=reviewCount%>)</font></h2>
<table id="reviewTable">
<col width="100"><col width="400">
<%for(int i=0; i<reviewList.size();i++){
	if(reviewList.size()==0){%>
	<tr>
		<td class="reviewTd" colspan="2">�ۼ��� �Խñ��� �����ϴ�.</td>
	</tr>
<%} else{
%>
<tr>
	<td><b><%=reviewList.get(i).getReview_cus_id() %></b></td>
	<td class="reviewTd"> <%=reviewList.get(i).getReview_content()%></td>
</tr>
<%}
}%>
</table>
</div>
<br><br>

<!-- �ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡ� -->

<div style="margin-left: 500px">
<h2  class="title">�ɼǼ���</h2>
<p  class="content">�������� ���� <input type="checkbox" id="deliveryCheck" onclick="deliFunc(this)"></p>
<p><font size="3" color="blue">�������� ���񽺶�? <br>���� ����� ������ �������� �Ⱦ������� �ý����Դϴ�.</font>
</div>

<div style="margin-left: 500px">
<h2  class="title">��������</h2>
<table>
<col width="250"><col width="250">
<tr height="30">
	<td class="content">������</td>
	<td align="right">
		<input class="content" name="startYear" size="2" type="text" value="<%=startDate.substring(0,4)%>��" style="background-color:transparent; border: none; text-align: right;" readonly="readonly" >
		<input class="content" name="startMonth" size="1" align="right" type="text" value="<%=startDate.substring(4,6)%>��" style="background-color:transparent; border: none; text-align: right;"readonly="readonly">
		<input class="content" name="startDay" size="1"  type="text" align="right" value="<%=startDate.substring(6,8)%>��" style="background-color:transparent; border: none; text-align: right;" readonly="readonly">
	</td>
</tr>
<tr height="30">
	<td class="content">�ݳ���</td>
	<td align="right">
		<input class="content" name="endYear" size="2"  type="text" value="<%=endDate.substring(0,4)%>��" style="background-color:transparent; border: none; text-align: right;" readonly="readonly" >
		<input class="content" name="endMonth" size="1"  type="text" value="<%=endDate.substring(4,6)%>��" style="background-color:transparent; border: none; text-align: right;" readonly="readonly" >
		<input class="content" name="endDay" size="1"  type="text" value="<%=endDate.substring(6,8)%>��" style="background-color:transparent; border: none;text-align: right;" readonly="readonly"  >
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

<br><br>
</div>
<div align="center">
<input class="btn" type="submit"  value="�����ϱ�">
</div>
<script type="text/javascript">
 	function deliFunc( e ) {
 		if ($('input:checkbox[id="deliveryCheck"]').is(":checked")){
 			document.getElementById("deliPrice").innerHTML="10,000��";
 			<% deli = 10000;%>
  			var testdeli = "<%=deli %>";
 	 		var testdeliCar = "<%=formatter.format(carFee+deli) %>";
 	 		document.getElementById("finalFee").value=testdeliCar+"��";
 	 		
 		}else {
 			document.getElementById("deliPrice").innerHTML="0��";
 			<% deli = 0;%>
 			var testdeli = "<%=deli %>";
 	 		var testdeliCar = "<%=formatter.format(carFee+deli)%>"; 	 		
 	 		document.getElementById("finalFee").value=testdeliCar+"��";
 		}
	} 
</script>
</form>
<br><br><br><br>


</body>
</html>