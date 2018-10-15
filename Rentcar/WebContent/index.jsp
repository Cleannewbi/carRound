<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>main page</title>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<style type="text/css">
div { position:relative; }
#searchDiv {
	text-align: center;
	width: 100%;
	background-color: #cceeee;
	position: absolute;
	background-repeat: no-repeat;
}
#searchInput {
	position:absoulte;
	text-align: center;
	
}
.hc{
	width:200px; left: 0; right: 0; margin-left: auto; margin-right: auto;
}
.vc {
	height: 100px; top: 0; bottom: 0; margin-top: auto; margin-bottom: auto;
}
input {
	width: 200px;
	height: 30px;
	text-align: center;
}

</style>
</head>
<body>

<div id="searchDiv" class="hc vc">
<input type="text" id="rentPlace" name="rentPlace" value="랜트 대여 장소">
<input type="text" id="datepicker1" name="rentStartDate">
<input type="time" id="rentStartTime" name="rentStartTime" min="07:00" max="21:00">
<input type="text" id="datepicker2" name="rentEndDate">
<input type="time" id="rentEndTime" name="rentEndTime" min="07:00" max="21:00">
<br><br>
<form action="post">
	<input type="button" onclick="searchRentCar()" value="검색하기">
</form>
</div>

<script type="text/javascript">

$('#datepicker1').datepicker({
	dateFormat: "yy-mm-dd",
	dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'],
	monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	numberOfMonths: [1,2],
	minDate: 0
});
$('#datepicker2').datepicker({
	dateFormat: "yy-mm-dd",
	dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'],
	monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	numberOfMonths: [1,2],
	minDate: 0
});

function searchRentCar() {
	var rentPlace = document.getElementById("rentPlace").value;
	var startDate = document.getElementById("datepicker1").value;
	var startTime = document.getElementById("rentStartTime").value;
	var endDate = document.getElementById("datepicker2").value;
	var endTime = document.getElementById("rentEndTime").value;
	alert(rentPlace + "" + startDate + "" + startTime + "" + endDate + "" + endTime);
	location.href="rentList.jsp?rentPlace=" + rentPlace + "&startDate=" + startDate + "&startTime=" + startTime + "&endDate=" + endDate + "&endTime=" + endTime;
}

</script>

</body>
</html>