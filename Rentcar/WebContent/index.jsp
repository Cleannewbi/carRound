<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Meta, title, CSS, favicons, etc. -->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="description" content="">
	<meta name="author" content="">
<title>main page</title>
<!-- Styles -->
	<link rel='stylesheet' href='assets/css/bootstrap.min.css'>
	<link rel='stylesheet' href='assets/css/animate.min.css'>
	<link rel='stylesheet' href="assets/css/font-awesome.min.css"/>
	<link rel='stylesheet' href="assets/css/style.css"/>
	<style type="text/css">
	#parallax {
	height:100%;
	width:100%;
	top:0;
	position:fixed;
	background-image:url("assets/img/intro.jpg");
	
	background-position:center center;
	background-repeat:no-repeat;
	-webkit-background-size: cover;
	-moz-background-size: cover;
	-o-background-size: cover;
	background-size: cover;
	z-index: -100;
}
	</style>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />
<link href='http://fonts.googleapis.com/css?family=Raleway:200,300,400,500,600,700,800' rel='stylesheet' type='text/css'>
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>

<!-- 
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
-->
<link rel="shortcut icon" href="#">
</head>
<body>
<a href="loginPage.jsp">LOGIN</a>
<div id="searchDiv">
<section id="contactarea" class="parallax section" style="background-image: url(http://themepush.com/demo/runcharity/assets/img/map.png);">
<div class="wrapsection">
	<div class="parallax-overlay" style="background-color: #1cbb9b;opacity:0.95;"></div>
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="maintitle">
					<h3 class="section-title">Get in Touch</h3>
					<p class="lead">
						If you have questions about our events, don't hesitate to send us your message. This is a real working contact form, test it!
					</p>
				</div>
				<form id="contact" name="contact" method="post" class="text-left">
					<fieldset>
						<div class="row">
							<div class="col-md-4 wow fadeIn animated animated" data-wow-delay="0.1s" data-wow-duration="2s">
								<label for="name">Name<span class="required">*</span></label>
								<input type="text" id="rentPlace" name="rentPlace" value="랜트 대여 장소" required/>
							</div>
							<div class="col-md-4 wow fadeIn animated" data-wow-delay="0.3s" data-wow-duration="2s">
								<label for="email">Email<span class="required">*</span></label>
							<input type="text" id="datepicker1" name="rentStartDate" required/>
							</div>
							<div class="col-md-4 wow fadeIn animated" data-wow-delay="0.3s" data-wow-duration="2s">
								<label for="phone">Phone</label>
								<input type="time" id="rentStartTime" name="rentStartTime" required/>
							</div>
							<div class="col-md-4 wow fadeIn animated" data-wow-delay="0.3s" data-wow-duration="2s">
								<label for="phone">Phone</label>
								<input type="text" id="datepicker2" name="rentEndDate" required/>
							</div>
							<div class="col-md-4 wow fadeIn animated" data-wow-delay="0.3s" data-wow-duration="2s">
								<label for="phone">Phone</label>
								<input type="time" id="rentEndTime" name="rentEndTime" min="07:00" max="21:00" required/>
							</div>
							
						</div>
						
						<div class="wow fadeIn animated" data-wow-delay="0.3" data-wow-duration="1.5s">
							<input type="button" onclick="searchRentCar()" value="검색하기">
						</div>
					</fieldset>
				</form>
				<div id="success">		
					<p class="contactalert">
						Your message was sent succssfully! I will be in touch as soon as I can.
					</p>			
				</div>
				<div id="error">			
					<p class="contactalert">
						 Something went wrong, try refreshing and submitting the form again.
					</p>			
				</div>
			</div>
		</div>
	</div>
</div>
</section>
</div>

<!-- 
<input type="text" id="rentPlace" name="rentPlace" value="랜트 대여 장소">
<input type="text" id="datepicker1" name="rentStartDate">
<input type="time" id="rentStartTime" name="rentStartTime" min="07:00" max="21:00">
<input type="text" id="datepicker2" name="rentEndDate">
<input type="time" id="rentEndTime" name="rentEndTime" min="07:00" max="21:00">
<br><br>
<form action="post">
	<input type="button" onclick="searchRentCar()" value="검색하기">
</form>
 -->
 
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