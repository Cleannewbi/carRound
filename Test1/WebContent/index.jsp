<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<% request.setCharacterEncoding("KSC5601");%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�ε���</title>
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=TyohXIeFvfwc1UdkRR_2&submodules=geocoder"></script>
</head>
<body>

<h1>index�Դϴ�</h1>

<form action="order.jsp" method="post">
<p>ID : <input type="text" name="id"></p>
<p>PW : <input type="text" name="pw"></p>
<p>�� �̸� : <input type="text" name="carName" value="2019 �ƹݶ�"></p>
<p>ȸ�� �̸� : <input type="text" name="comName" value="TEST COMPANY"></p>
<p>�Ӵ���� : <input type="text" name="startDate" ></p>
<p>�Ӵ� �� : <input type="text" name="endDate"></p>
<input type="submit" value="����">
</form>


</body>
</html>