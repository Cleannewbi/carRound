<%@page import="java.util.HashMap"%>
<%@page import="dao.RentDao"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
RentDao rentdao = new RentDao();
//car, com month ���� ����
int carMonthSet = 0;
int comMonthSet = 0;

///////////////////////////////////////���� & count 
HashMap<String,Integer> car_CountMap = new HashMap<>();
HashMap<String,Float> name_PercentMap = new HashMap<>();

//Month Set
carMonthSet=10;//10�� �ٸ� ���� �������� onclick �ؼ� ���� ���ָ� ���� 
car_CountMap = rentdao.getCarSaleMonthly(carMonthSet);

//car_name list
List<String> car_nameList = new ArrayList<>();
car_nameList=rentdao.getCarnameList();

//map�� key�� �տ� �ְ� 
for(int i=0; i<nameCountMap.size();i++){
	name_PercentMap.put(car_nameList.get(i), "%.2f%%%n", car_CountMap.get("key") / rentCount * 100.0);
}

//////////////////ȸ�� & COUNT

HashMap<String,Integer> com_CountMap = new HashMap<>();
com_CountMap=rentdao.getCarnameList();

//orderby com_name �ؼ� ���� com_name list  
List<String> com_nameList = new ArrayList<>();
com_nameList=rentdao.getComnameList();

//map�� key�� �տ� �ְ� 
for(int i=0; i<nameCountMap.size();i++){
	name_PercentMap.put(com_nameList.get(i), "%.2f%%%n", com_CountMap.get("key") / rentCount * 100.0);
}


%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="magager.css">
<link rel="stylesheet" type="text/css" href="chart.css">

</head>
<body>
<div id="header">
	<h1>������� ������</h1>
</div>

<div id="nav">
<br>
	<button type="button" class="btn" onclick="manager(1)">ȸ������</button><br><br>
	<button type="button" class="btn"onclick="manager(2)">�������</button><br><br>
	<button type="button" class="btn"onclick="manager(3)">�������</button><br><br>
</div>
<script type="text/javascript">
function manager(number) {
	if(number==1){
		location.href="manageMem.jsp";
	}else if(number==2){
		location.href="manageCom.jsp";
	}else if(number==3){
		location.href="manageSale.jsp";
	}
}
</script>

<div id="section">
	

	
	
</div>
<div id="footer">
<p> <a href="index.jsp" style="text-decoration: none; color: white;">carround.company</a> </p>
</div>
</body>
</html>