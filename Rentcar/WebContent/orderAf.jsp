<%@page import="javax.annotation.security.DenyAll"%>
<%@page import="dto.RentDto"%>
<%@page import="dao.RentDao"%>
<%@page import="dao.iRentDao"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<% request.setCharacterEncoding("KSC5601");%>
<%

	// loginId �� session���� �����;��� Object ologin = session.getAttribute("login");
	String loginId = request.getParameter("loginId").trim();
	//session���� �������� hidden loginId order.jsp���� �����ؾߵ�
	
	String carName = request.getParameter("carName").trim();
	String startDate = request.getParameter("startYear").trim()+request.getParameter("startMonth").trim()+request.getParameter("startDay").trim();	
	String endDate = request.getParameter("endYear").trim()+request.getParameter("endMonth").trim()+request.getParameter("endDay").trim();
	startDate=startDate.replace("��", "-");
	startDate=startDate.replace("��", "-");
	startDate=startDate.replace("��", "");
	endDate=endDate.replace("��", "-");
	endDate=endDate.replace("��", "-");
	endDate=endDate.replace("��", "");
	System.out.println("startDate : "+startDate+" / enddate : "+endDate);
	
	String pri = request.getParameter("price");
	pri=pri.replace(",", "");
	pri=pri.replace("��", "");
	int price = (Integer.parseInt(pri));
	
	String rName =  request.getParameter("rcName").trim();
	String rPhone = request.getParameter("rcPhone1").trim()+request.getParameter("rcPhone2").trim()+request.getParameter("rcPhone3").trim();
	String rAddress =  request.getParameter("rcAddress").trim();
	String rCard = request.getParameter("rcCard1").trim()+ request.getParameter("rcCard2").trim()+ request.getParameter("rcCard3").trim()+ request.getParameter("rcCard4").trim();
	String rPhoto = request.getParameter("rcPhoto").trim();
	int comNum =Integer.parseInt(request.getParameter("infoSeq"));
	String comName = request.getParameter("comName").trim();
	System.out.println("login id : "+loginId+" carName : "+carName+" startDate : "+startDate+" enddate : "+endDate+ " price: "+price+" rName: "+rName+" rAddress: "+rAddress
			+"rCard : "+rCard+"rphoto : "+rPhoto+" comNum : "+comNum);
%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>

<%
	iRentDao rentdao = RentDao.getInstance();
	RentDto dto = new RentDto(carName, startDate, endDate, loginId, comNum, price,rName, rPhone, rAddress, rCard, rPhoto, comName);

	boolean isS = rentdao.setReservation(dto);
	if(isS){
%>
		<script type="text/javascript">
			alert("������ �Ϸ�Ǿ����ϴ�.");
			location.href="index.jsp";
		</script>

<%	
	}else{
%>
		<script type="text/javascript">
			alert("�ٽ� �����Ͽ� �ֽʽÿ�.");
			location.href="index.jsp";
		</script>
<%		
	}
%>

</body>
</html>