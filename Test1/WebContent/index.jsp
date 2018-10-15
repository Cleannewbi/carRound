<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<% request.setCharacterEncoding("KSC5601");%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>인덱스</title>
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=TyohXIeFvfwc1UdkRR_2&submodules=geocoder"></script>
</head>
<body>

<h1>index입니다</h1>

<form action="order.jsp" method="post">
<p>ID : <input type="text" name="id"></p>
<p>PW : <input type="text" name="pw"></p>
<p>차 이름 : <input type="text" name="carName" value="2019 아반떼"></p>
<p>회사 이름 : <input type="text" name="comName" value="TEST COMPANY"></p>
<p>임대시작 : <input type="text" name="startDate" ></p>
<p>임대 끝 : <input type="text" name="endDate"></p>
<input type="submit" value="들어가기">
</form>


</body>
</html>