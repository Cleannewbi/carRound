<%@page import="model.RentDto"%>
<%@page import="dao.RentDao"%>
<%@page import="dao.RentDaoImpl"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<% request.setCharacterEncoding("KSC5601");%>
<%

	// loginId �� session���� �����;��� Object ologin = session.getAttribute("login");
	String loginId = request.getParameter("loginId").trim();
	//session���� �������� hidden loginId order.jsp���� �����ؾߵ�
	
	String carName = request.getParameter("carName").trim();
	String startDate = request.getParameter("startDate").trim();
	String endDate = request.getParameter("endDate").trim();
	int price = Integer.parseInt(request.getParameter("price"));

	String rName =  request.getParameter("rc_name").trim();
	
	String pho1 =  request.getParameter("rcPhone1");
	String pho2 =  request.getParameter("rcPhone2");
	String pho3 =  request.getParameter("rcPhone3");
	String rPhone = pho1.trim()+pho2.trim()+ pho3.trim();
	
	String rAddress =  request.getParameter("rcAddress").trim();
	
	String card1 =  request.getParameter("rcCard1");
	String card2 =  request.getParameter("rcCard2");
	String card3 =  request.getParameter("rcCard3");
	String card4 =  request.getParameter("rcCard4");
	String rCard = card1.trim()+card2.trim()+card3.trim()+card4.trim();
	
	String rPhoto = request.getParameter("rcPhoto").trim();

	
	int infoSeq =Integer.parseInt(request.getParameter("infoSeq"));

%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>


<%

	RentDaoImpl rentdao = RentDao.getInstance();
	RentDto dto = new RentDto(carName, startDate, endDate, loginId, infoSeq, price,rName, rPhone, rAddress, rCard, rPhoto);

	boolean isS = rentdao.setReservation(dto, infoSeq);
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