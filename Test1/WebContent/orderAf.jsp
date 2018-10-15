<%@page import="model.RentDto"%>
<%@page import="dao.RentDao"%>
<%@page import="dao.RentDaoImpl"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<% request.setCharacterEncoding("KSC5601");%>
<%

	// loginId 는 session에서 가져와야함 Object ologin = session.getAttribute("login");


	String loginId = request.getParameter("loginId");
	String carName = request.getParameter("carName");
	String startDate = request.getParameter("startDate");
	String endDate = request.getParameter("endDate");
	int price = Integer.parseInt(request.getParameter("price"));
	
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
	RentDto dto = new RentDto(carName,startDate,endDate,loginId,price);

	boolean isS = rentdao.setReservation(dto, infoSeq);
	if(isS){
%>
		<script type="text/javascript">
			alert("예약이 완료되었습니다.");
			location.href="index.jsp";
		</script>

<%	
	}else{
%>
		<script type="text/javascript">
			alert("다시 예약하여 주십시오.");
			location.href="index.jsp";
		</script>
<%		
	}
%>

</body>
</html>