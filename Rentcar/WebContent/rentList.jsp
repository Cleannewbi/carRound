<%@page import="dto.MemberDto"%>
<%@page import="dto.InfoDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.InfoDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ include file="/infoSaving.jsp" %> --%>
<%
String rentPlace = request.getParameter("rentPlace");
String startDate = request.getParameter("startDate");
String startTime = request.getParameter("startTime");
String endDate = request.getParameter("endDate");
String endTime = request.getParameter("endTime");
System.out.println(rentPlace + startDate + startTime + endDate + endTime);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- <link rel="stylesheet" href="./css/main.css"> -->
<style type="text/css">
#div_left {
	float: left;
	width: 20%;
	height: 800px;
	background-color: #ccccee;
	text-align: center;
}
#main_area {
	float: left;
	margin: auto;
	width: 80%;
	height: 100%;
	background-color: #cceeee;
	max-width: 1600px;
	min-width: 550px;
	max-height: 900px;
	min-height: 800px;
}
#tdleft1 {
	float: left;
	position: relative;
	margin: auto;
	height: 5px;
}
#tdleft2 {
	float: left;
	position: relative;
	margin: auto;
	top: 25px;
	height: 5px;
}
#researchDateBtn {
	position: relative;
	margin: auto;
	height: 30px;
	top: 45px;
}
.info {
	width: 40%;
	height: 200px;
	min-width: 550px;
	min-height: 200px;
	background-color: #ffffff;
	border: 1px solid black;
	margin: 50px 0px 0px 100px;
	padding: 10px 10px 10px 10px;
}
.infoImg {
	 width: auto; height: auto; max-width: 200px; max-height: 200px;
}
.fontSetCenter {
	text-align: center;
}
.infoText {
	margin-top: 0px;
	font-size: 20px;
	background-color: #ffffff;
}
ul {
	list-style: none;
}
li {
	margin: 0 0 100 100;
	padding: 0 0 50 50;
	border: 1;
	float: left;
}
</style>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />
<link href='http://fonts.googleapis.com/css?family=Raleway:200,300,400,500,600,700,800' rel='stylesheet' type='text/css'>
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
</head>
<body>

<!-- 위쪽 체크박스 -->
<div id="div_left">
<form name="frm" method="post" action="carList.jsp">
	<table align="center" border="0" name="chkTable">
		<col width="200"><col width="200"><col width="200">
		<tr align="center">
			<td>차량등급</td>
		</tr>
		<tr></tr><tr></tr><tr></tr><tr></tr>
		<tr align="left"><td><input type="checkbox" class="cb1" name="chkBox" value="SizeA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;소형</td></tr>
		<tr align="left"><td><input type="checkbox" class="cb1" name="chkBox" value="SizeB">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;중형</td></tr>
		<tr align="left"><td><input type="checkbox" class="cb1" name="chkBox" value="SizeC">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;대형</td></tr>
		<tr></tr><tr></tr><tr></tr><tr></tr>
		<tr align="center">
		<td>차량종류</td>
		</tr>
		<tr align="left"><td><input type="checkbox" class="cb1" name="chkBox" value="TypeSUV">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;SUV</td></tr>
		<tr align="left"><td><input type="checkbox" class="cb1" name="chkBox" value="TypeCar">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;승용차</td></tr>
		<tr align="left"><td><input type="checkbox" class="cb1" name="chkBox" value="TypeVans">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;승합차</td></tr>
		<tr></tr><tr></tr><tr></tr><tr></tr>
		<tr align="center">
		<td>연료</td>
		</tr>
		<tr align="left"><td><input type="checkbox" class="cb1" name="chkBox" value="fuelLpg">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;LPG</td></tr>
		<tr align="left"><td><input type="checkbox" class="cb1" name="chkBox" value="fuelOil">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;가솔린</td></tr>
		<tr align="left"><td><input type="checkbox" class="cb1" name="chkBox" value="fuelElec">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;전기</td></tr>
		<tr align="left"><td><input type="checkbox" class="cb1" name="chkBox" value="fuelDizel">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;디젤</td></tr>
	</table>
	<table align="center" border="0" name="dateTable" id="dateTable">
		<col width="200"><col width="200"><col width="200">
		<tr align="center">
			<td>대여날짜</td>
		</tr>
		<tr align="left" id="tdleft1"><td><input type="text" id="datepicker1" name="rentStartDate" size="8" value="<%=startDate %>"></td>&nbsp;<td><input type="time" id="rentStartTime" name="rentStartTime" size="8" value="<%=startTime %>"></td></tr>
		<tr align="left" id="tdleft2"><td><input type="text" id="datepicker2" name="rentEndDate" size="8" value="<%=endDate %>"></td>&nbsp;<td><input type="time" id="rentEndTime" name="rentEndTime" value="<%=endTime %>"></td></tr>		
		<tr><td><input type="button" id="researchDateBtn" value="날짜 재검색" onclick="researchDate()"></td></tr>	 
	</table>
	</form>
	<br>
</div>

<%-- 
<!-- 검색결과화면 -->
<div id="div_main">
	<ul>
	<%
	if(list == null || list.size() == 0) {
		%>
		<li>
		<strong style="text-align: center; height: 100px;">등록된 차량이 없습니다.</strong>
		</li>
		<% 		
	} else {
		for(int i=0 ; i < list.size() ; i++) {
			InfoDto idto = list.get(i);
		%>
		<li>
			<div class="info">
				<div><strong class="infoText"><%=idto.getCar_name() %></strong>&nbsp;</div>
				<a href="#"><img class="infoImg" src="./images/k5.jpg"></a>
					<!-- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
					
					<div class="infoDetail">차량등급&nbsp;&nbsp;<strong><%=idto.getCar_size() %></strong></div> &nbsp; 
					<div class="infoDetail">연료&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong><%=idto.getCar_fuel() %></strong></div> &nbsp; 
					<div class="infoDetail">차량종류&nbsp;&nbsp;<strong><%=idto.getCar_type() %></strong></div>
					<div class="relativeBtn">
						<input type="button" id="selectCar" value="선택" onclick="RentCarDetail('<%=idto.getInfo_seq() %>')">
					</div> 
	<% %>
			</div>
		</li>

	<%
		}
	}
	%>
	</ul>
</div>
 --%>

<div id="main_area">
<%
if(rentPlace.equals("") && startDate.equals("") && startTime.equals("") && endDate.equals("") && endTime.equals("")) {
%>
<jsp:include page="carList.jsp" flush="false">
	<jsp:param value="rentList.jsp" name="actionPath"/>
</jsp:include>
</div>
<%
} else {
	request.setAttribute("rentPlace", rentPlace);
	request.setAttribute("startDate", startDate);
	request.setAttribute("startTime", startTime);
	request.setAttribute("endDate", endDate);
	request.setAttribute("endTime", endTime);
%>
<jsp:include page="carList.jsp" flush="false">
	<jsp:param value="rentList.jsp" name="actionPath"/>
</jsp:include>
</div>
<%
}
%>

<script type="text/javascript">

/* 
function RentCarDetail(seq) {
	location.href = "RentCarDetail.jsp?seq=" + seq;
}
 */

/*
var loc = [];
var ln = $(".cb1").length;
var array;
//alert(ln)
$(".cb1").click(function(){
for(i = 0; i<ln; i++){
	
	if(document.getElementsByName('chkBox')[i].checked==true){
		
		//alert($("_cb1")[i].checked);
		loc += document.getElementsByName('chkBox')[i].value;
		alert("loc = " +loc);
		array[i] = i;
		}
	}
});
 */
/* 
// CHECKBOX FINAL
 $(".cb1").click(function () {
	var items = [];
	if($('.cb1').is(':checked')) {
		$("input:checkbox[name=chkBox]:checked").each(function () {
			items.push($(this).val());
			alert(items);
		});
	} else {
		items.pop($(this).val());
		alert(items);
	}
	var loc = "";
	var tmp = "";
	// if(items[i].indexOf("SizeA") || items[i].indexOf("SizeB") || items[i].indexOf("SizeC")) {
			// tmp = "Size=";
	var arr = [];
for (var i = 0; i < items.length; i++) {
	for (var j = 1; j < arr.length; j++) {
		
		if(items[i] == arr[j]) {
			i++;
			break;
		}	
	}
	tmp += items[i] + "&";
	arr[i] = tmp;
}
	// }
	// alert(arr);
	// location.href = "index.jsp?" + loc;
	
	
	
	$.ajax({
		// 통신 시작
		url: "carList.jsp",
		type: "POST",
		data: { "arr":arr },
		traditional: true,
		success:function(data) {
			$("#main_area").html(data);
		},
		error: function(xhr, option, error){
			alert(xhr.status); //오류코드
			alert(error); //오류내용
		}
	});
	 
}); 
*/
 
$('#datepicker1').datepicker({
		dateFormat: "yy-mm-dd",
		dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'],
		monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		numberOfMonths: [1,1],
		minDate: 0
});
$('#datepicker2').datepicker({
		dateFormat: "yy-mm-dd",
		dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'],
		monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		numberOfMonths: [1,1],
		minDate: 0
});

<%--
researchDate FINAL 
function researchDate() {
	var rentPlace = "<%=request.getParameter("rentPlace") %>";
	var startDate = "";
	var startTime = "";
	var endDate = "";
	var endTime = "";
	
	endTime = $("#rentEndTime").val();
	endDate = $("#datepicker2").datepicker("getDate");
	startTime = $("#rentStartTime").val();
	startDate = $("#datepicker1").datepicker("getDate");
	
	if(startDate == null || startTime == null || endDate == null || endTime == null) {
		alert(this + "를 설정해주세요.");
		focus(this);
	}
	
	var day = ("0" + startDate.getDate()).slice(-2);
	var month = ("0" + (startDate.getMonth() + 1)).slice(-2);
	var year = startDate.getFullYear();
	var eday = ("0" + endDate.getDate()).slice(-2);
	var emonth = ("0" + (endDate.getMonth() + 1)).slice(-2);
	var eyear = endDate.getFullYear();

	startDate = year + '-' + month + '-' + day;
	endDate = eyear + '-' + emonth + '-' + eday;
	alert(startDate);
	$.ajax({
		// 통신 시작
		url: "carList.jsp",
		type: "get",
		data: {  "rentPlace":rentPlace,
				"startDate":startDate,
				"startTime":startTime,
				"endDate":endDate,
				"endTime":endTime
		},
		traditional: true,
		success:function(data) {
			$("#main_area").html(data);
		}
	});
}
 --%>
 
	$(".cb1").click(function () {
		var rentPlace = "<%=request.getParameter("rentPlace") %>";
		var startDate = "";
		var startTime = "";
		var endDate = "";
		var endTime = "";
		var items = [];
			
		var tmp = "";
		if($('.cb1').is(':checked')) {
			$("input:checkbox[name=chkBox]:checked").each(function () {
				items.push($(this).val());
				alert(items);
			});
		} else {
			items.pop($(this).val());
			alert(items);
		}
		var loc = "";
		var tmp = "";
		var arr = [];
		
	for (var i = 0; i < items.length; i++) {
		for (var j = 1; j < arr.length; j++) {
			
			if(items[i] == arr[j]) {
				i++;
				break;
			}	
		}
		tmp += items[i] + "&";
		arr[i] = tmp;
	}
	
	endTime = $("#rentEndTime").val();
	endDate = $("#datepicker2").datepicker("getDate");
	startTime = $("#rentStartTime").val();
	startDate = $("#datepicker1").datepicker("getDate");
	
	if(startDate == null || startTime == null || endDate == null || endTime == null) {
		alert(this + "를 설정해주세요.");
		focus(this);
	}
	
	var day = ("0" + startDate.getDate()).slice(-2);
	var month = ("0" + (startDate.getMonth() + 1)).slice(-2);
	var year = startDate.getFullYear();
	var eday = ("0" + endDate.getDate()).slice(-2);
	var emonth = ("0" + (endDate.getMonth() + 1)).slice(-2);
	var eyear = endDate.getFullYear();

	startDate = year + '-' + month + '-' + day;
	endDate = eyear + '-' + emonth + '-' + eday;
	alert(startDate);
	$.ajax({
		// 통신 시작
		url: "carList.jsp",
		type: "get",
		data: { "arr":arr,
				"rentPlace":rentPlace,
				"startDate":startDate,
				"startTime":startTime,
				"endDate":endDate,
				"endTime":endTime
		},
		traditional: true,
		success:function(data) {
			$("#main_area").html(data);
		}
	});
	 
}); 
 
	function researchDate() {
		var rentPlace = "<%=request.getParameter("rentPlace") %>";
		var startDate = "";
		var startTime = "";
		var endDate = "";
		var endTime = "";
		var items = [];
		
		if($('.cb1').is(':checked')) {
			$("input:checkbox[name=chkBox]:checked").each(function () {
				items.push($(this).val());
				alert(items);
			});
		} else {
			items.pop($(this).val());
			alert(items);
		}
			
		var loc = "";
		var tmp = "";		
		var arr = [];
		
		for (var i = 0; i < items.length; i++) {
			for (var j = 1; j < arr.length; j++) {
				
				if(items[i] == arr[j]) {
					i++;
					break;
				}	
			}
			tmp += items[i] + "&";
			arr[i] = tmp;
		}

		endTime = $("#rentEndTime").val();
		endDate = $("#datepicker2").datepicker("getDate");
		startTime = $("#rentStartTime").val();
		startDate = $("#datepicker1").datepicker("getDate");
		
		if(startDate == null || startTime == null || endDate == null || endTime == null) {
			alert(this + "를 설정해주세요.");
			focus(this);
		}
		
		var day = ("0" + startDate.getDate()).slice(-2);
		var month = ("0" + (startDate.getMonth() + 1)).slice(-2);
		var year = startDate.getFullYear();
		var eday = ("0" + endDate.getDate()).slice(-2);
		var emonth = ("0" + (endDate.getMonth() + 1)).slice(-2);
		var eyear = endDate.getFullYear();

		startDate = year + '-' + month + '-' + day;
		endDate = eyear + '-' + emonth + '-' + eday;
		alert(startDate);
		$.ajax({
			// 통신 시작
			url: "carList.jsp",
			type: "get",
			data: { "arr":arr,
					"rentPlace":rentPlace,
					"startDate":startDate,
					"startTime":startTime,
					"endDate":endDate,
					"endTime":endTime
			},
			traditional: true,
			success:function(data) {
				$("#main_area").html(data);
			}
		});
		
	}
	
	
 

/* 
function changePlace() {
	
	$.ajax({
		// 통신 시작
		url: "carList.jsp",
		type: "get",
		data: { "rentPlace":rentPlace },
		traditional: true,
		success:function(data) {
			$("#main_area").html(data);
		}
	});
}
function changesDate() {
	var startDate = "";
	startDate = $("#datepicker1").datepicker("getDate");
	var day = ("0" + startDate.getDate()).slice(-2);

	var month = ("0" + (startDate.getMonth() + 1)).slice(-2);

	var year = startDate.getFullYear();

	startDate = year + '-' + month + '-' + day;
	alert(startDate);
	$.ajax({
		// 통신 시작
		url: "carList.jsp?startDate=" + startDate,
		type: "get",
		data: { "startDate":startDate },
		traditional: true,
		success:function(data) {
			$("#main_area").html(data);
		}
	});
	
}
function changesTime() {
	var startTime = "";
	startTime = $("#rentStartTime").val();
	alert(startTime);
	$.ajax({
		// 통신 시작
		url: "carList.jsp",
		type: "get",
		data: { "startTime":startTime },
		traditional: true,
		success:function(data) {
			$("#main_area").html(data);
		}
	});
}
function changeeDate() {
	var endDate = "";
	endDate = $("#datepicker2").datepicker("getDate");
	var day = ("0" + endDate.getDate()).slice(-2);

	var month = ("0" + (endDate.getMonth() + 1)).slice(-2);

	var year = endDate.getFullYear();

	endDate = year + '-' + month + '-' + day;
	alert(endDate);
	$.ajax({
		// 통신 시작
		url: "carList.jsp",
		type: "get",
		data: { "endDate":endDate },
		traditional: true,
		success:function(data) {
			$("#main_area").html(data);
		}
	});
}
function changeeTime() {
	var endTime = "";
	endTime = $("#rentEndTime").val();
	alert(endTime);
	$.ajax({
		// 통신 시작
		url: "carList.jsp",
		type: "get",
		data: { "endTime":endTime },
		traditional: true,
		success:function(data) {
			$("#main_area").html(data);
		}
	});
}
 */

/* 
$(".cb2").click(function () {
	var items = [];
	if($('.cb2').is(':checked')) {
		$("input:checkbox[name=chkBox]:checked").each(function () {
			items.push($(this).val());
			alert(items);
		});
	} else {
		items.pop($(this).val());
		alert(items);
	}
	
	
	var loc = "";
	var tmp = "";
	// if(items[i].indexOf("TypeSUV") || items[i].indexOf("TypeCar") || items[i].indexOf("TypeVans")) {
			// tmp = "Type=";
	for (var i = 0; i < items.length; i++) {
		tmp += items[i] + "&";
		loc += tmp;	
		break;
	}
	// }
	 alert(loc);
	// location.href = "index.jsp?" + loc;
	
	
	$.ajax({
		// 통신 시작
		url: "carList.jsp",
		type: "get",
		data: loc,
		
		success:function(data) {
			$("main_area").html(data);
		}
	});
	
});

$(".cb3").click(function () {
	var items = [];
	if($('.cb3').is(':checked')) {
		$("input:checkbox[name=chkBox]:checked").each(function () {
			items.push($(this).val());
			alert(items);
		});
	} else {
		items.pop($(this).val());
		alert(items);
	}
	var loc = "";
	var tmp = "";
	// if(items[i].indexOf("fuelOil") || items[i].indexOf("fuelLpg") || items[i].indexOf("fuelElec")) {
			// tmp = "fuel=";
	for (var i = 0; i < items.length; i++) {
		tmp += items[i] + "&";
		loc += tmp;
		break;
	}
	// }
	alert(loc);
	// location.href = "index.jsp?" + loc;
	
	$.ajax({
		// 통신 시작
		url: "carList.jsp",
		type: "get",
		data: loc,
		
		success:function(data) {
			$("main_area").html(data);
		}
	});
	
}); 
*/

/* 
function checkb(val) {
	var array = [];
	var checkedboxes = document.querySelectorAll('input[type=checkbox]:checked');
	
	for(var i=0 ; i<checkedboxes.length ; i++) {
		array.push(checkedboxes[i].value);
	}
}
*/
/* 
$(document).ready(function () {
	var selected_value = [];
	$(".checkbox:checked").each(function () {
		selected_value.push($(this).val());
	});
	console.log(selected_value);
});
*/
</script>
</body>
</html>