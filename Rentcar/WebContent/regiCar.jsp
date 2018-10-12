<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    String com_name = request.getParameter("com_name1");
    System.out.println("com_name1:"+com_name);
    
    /* CREATE TABLE RC_INFO
    (   SEQ NUMBER(8) PRIMARY KEY, 
        COM_NAME VARCHAR2(100) NOT NULL, 
        CAR_PIC VARCHAR2(2000), 
        CAR_NAME VARCHAR2(100) NOT NULL, 
        CAR_TYPE VARCHAR2(100) NOT NULL, suv , 승합, 승용
        CAR_FUEL VARCHAR2(100) NOT NULL, lpg, disel, gasoline, electric
        CAR_SIZE VARCHAR2(100) NOT NULL, 경차 소형차 중형차 대형차(고급) 
        CAR_FEE VARCHAR2(100) NOT NULL ) */
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

</head>
<body>
<h2>regiCar.jsp</h2>

<button>The Best RentCar List</button>

<form action="AFregiCar.jsp">
<div>
<table>
<tr>
<td>사진 업로드</td>
<td><input type="button"value="업로드"></td>
</tr>
<tr>
<td>자동차 이름</td>
<td><input type="text" name="car_name"></td>
</tr>
<tr>
<td>자동차 타입</td>
<td>
<select name="car_type">
<option name="car_type">승합</option>
<option name="car_type" selected="selected">승용</option>
<option name="car_type">suv</option>
</select>
</td>
</tr>
<tr>
<td>연료 타입</td>
<td>
<select name="fuel_type">
<option name="fuel_type">LPG</option>
<option name="fuel_type">Disel</option>
<option name="fuel_type" selected="selected">Gasoline</option>
<option name="fuel_type">E.V</option>
</select>
</td>
</tr>
<tr>
<td>자동차 크기</td>
<td>
<select name="car_size">
<option name="car_size">경차</option>
<option name="car_size" selected="selected">소형차</option>
<option name="car_size">중형차</option>
<option name="car_size">대형차</option>
</select>
</td>
</tr>
<tr>
<td>대여료</td>
<td><input type="text" name="rental_fee"></td>
</tr>
</table>
</div>
<input type="submit" value="차량 등록하기">
</form>

</body>
</html>