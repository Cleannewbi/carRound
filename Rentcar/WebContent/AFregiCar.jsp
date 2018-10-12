<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
    	String car_type = request.getParameter("car_type");
    	String fuel_type = request.getParameter("fuel_type");
    	String car_size = request.getParameter("car_size");
    	String rental_fee = request.getParameter("rental_fee");
    	String car_name = request.getParameter("car_name");
    	System.out.println("car_type:"+car_type+" car_size:"+car_size+" car_name:"+car_name
    					+" rental_fee:"+rental_fee+" fuel_type:"+fuel_type);
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>AFregiCar.jsp</title>
</head>
<body>
<h2>AFregiCar.jsp</h2>


</body>
</html>