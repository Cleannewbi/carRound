<%@page import="dao.MyPageDao"%>
<%@page import="dao.iMyPageDao"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!doctype html>
<html lang="en">
<head>
<!-- Meta, title, CSS, favicons, etc. -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">
<title>CAROUD</title>

<!-- Styles -->
<link rel='stylesheet' href='assets/css/bootstrap.min.css'>
<link rel='stylesheet' href='assets/css/animate.min.css'>
<link rel='stylesheet' href="assets/css/font-awesome.min.css" />
<link rel='stylesheet' href="assets/css/style.css?ver=6" />
<style type="text/css">
#parallax {
	height: 100%;
	width: 100%;
	top: 0;
	position: fixed;
	background-image: url("assets/img/intro.jpg");
	background-position: center center;
	background-repeat: no-repeat;
	-webkit-background-size: cover;
	-moz-background-size: cover;
	-o-background-size: cover;
	background-size: cover;
	z-index: -100;
}

#contactarea {
	background-image: url("assets/img/main.jpg");
}
</style>
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css"
	type="text/css" />
<link
	href='http://fonts.googleapis.com/css?family=Raleway:200,300,400,500,600,700,800'
	rel='stylesheet' type='text/css'>
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>


<link rel="shortcut icon" href="#">
</head>

<%
Object ologin = session.getAttribute("login");
MemberDto dto = null;
if(ologin == null) {
%>
	<script type="text/javascript">
		alert("다시 로그인 해주세요.");
		location.href="loginPage.jsp";
	</script>
<%
	return;
}

dto = (MemberDto)ologin;


////////////////////////AUTH CHECK////////////////////////////////
String auth_login = (String)session.getAttribute("auth_login");
String forCheckAuth = "";
forCheckAuth = auth_login;

iMyPageDao auth_dao = MyPageDao.getInstance();

int auth=0;
if(forCheckAuth != null){
auth = auth_dao.checkAuth(forCheckAuth);
}
System.out.println("auth:"+auth);
%>
<!-- ////////////////////END AUTH CHECK////////////////////////////////// -->

<!-- End Hero Bg
	================================================== -->
<!-- Start Header
	================================================== -->
<header id="header" class="navbar navbar-inverse navbar-fixed-top"
	role="banner">
	<div class="container">
		<div class="navbar-header">
			<button class="navbar-toggle" type="button" data-toggle="collapse"
				data-target=".bs-navbar-collapse">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<!-- Your Logo -->
			<a href="#test" class="navbar-brand">CAROUD </a>
		</div>
		<!-- Start Navigation -->
		<nav class="collapse navbar-collapse bs-navbar-collapse navbar-right"
			role="navigation">
			<ul class="nav navbar-nav">
				<li class=""><a href="#searchDiv">Home</a></li>
				<li class="active"></li>
				<li class=""></li>
				<li class=""><a href="#faq">ABOUT</a></li>
				<%if(auth == 1){ %>
				<li class=""><a href="oMyPage.jsp">SERVICE</a></li>
				<li class=""><a href="loginPage.jsp">LOGOUT</a></li>
				<%} else if(auth == 2){ 
					MemberDto dto2 = new MemberDto();
					dto2 = auth_dao.getMyPageList(forCheckAuth);
					session.setAttribute("comPage", dto2);
				%>
				<li class=""><a href="comPage.jsp">SERVICE</a></li>
				<li class=""><a href="loginPage.jsp">LOGOUT</a></li>
				<%} else if(auth == 3){
					session.setAttribute("adminPage", forCheckAuth);	
				%>
				<li class=""><a href="adminPage.jsp">SERVICE</a></li>
				<li class=""><a href="loginPage.jsp">LOGOUT</a></li>
				<%} else if(auth == 0){%>
				<li class=""><a href="loginPage.jsp">LOGIN</a></li>
				<li class=""><a href="newAccount.jsp">회원가입</a></li>
				<%} %>
			</ul>
		</nav>
	</div>
</header>

<!-- Intro
	================================================== -->


<section id="hero" class="section active-section" style="opacity: 1;">
	<div class="container">
		<div class="row">
			<div class="col-md-5"></div>
			<div class="col-md-7"></div>
		</div>
	</div>
</section>



<!-- MAIN ================================================== -->

<body>


	<div id="searchDiv">
		<section id="contactarea" class="parallax section");">
			<div class="wrapsection">
				<div class="parallax-overlay"
					style="background-color: #1cbb9b; opacity: 0.25;"></div>
				<div class="container">
					<div class="row">
						<div class="col-md-12">
							<div class="maintitle">
								<h3 class="section-title">CAROUD Rental Service</h3>
								<p class="lead">지금 바로 실시간 차량검색을 경험하세요</p>
							</div>
							<form id="contact" name="contact" method="post" class="text-left">
								<fieldset>
									<div class="row">
										<div class="col-md-2 wow fadeIn animated animated"
											data-wow-delay="0.1s" data-wow-duration="2s">
											<label for="name">랜트대여장소<span class="required"></span></label>
											<select name=area" id="rentPlace">
												<option value="">장소선택</option>
												<option value="강남구">강남구</option>
												<option value="강동구">강동구</option>
												<option value="강북구">강북구</option>
												<option value="강서구">강서구</option>
												<option value="관악구">관악구</option>
												<option value="광진구">광진구</option>
												<option value="구로구">구로구</option>
												<option value="금천구">금천구</option>
												<option value="노원구">노원구</option>
												<option value="도봉구">도봉구</option>
												<option value="동대문구">동대문구</option>
												<option value="동작구">동작구</option>
												<option value="마포구">마포구</option>
												<option value="서대문구">서대문구</option>
												<option value="서초구">서초구</option>
												<option value="성동구">성동구</option>
												<option value="성북구">성북구</option>
												<option value="송파구">송파구</option>
												<option value="양천구">양천구</option>
												<option value="영등포구">영등포구</option>
												<option value="용산구">용산구</option>
												<option value="은평구">은평구</option>
												<option value="종로구">종로구</option>
												<option value="중구">중구</option>
												<option value="중랑구">중랑구</option>
												
											</select>
										</div>
										<div class="col-md-2 wow fadeIn animated"
											data-wow-delay="0.3s" data-wow-duration="2s">
											<label for="email">대여날짜<span class="required">*</span></label>
											<input type="text" id="datepicker1" name="rentStartDate"
												required />
										</div>
										<div class="col-md-2 wow fadeIn animated"
											data-wow-delay="0.3s" data-wow-duration="2s">
											<label for="phone">대여시간</label> <select name="job" id="rentStartTime">
												<option value="">시간선택</option>
												<option value="00:00">오전 00:00</option>
												<option value="01:00">오전 01:00</option>
												<option value="02:00">오전 02:00</option>
												<option value="03:00">오전 03:00</option>
												<option value="04:00">오전 04:00</option>
												<option value="05:00">오전 05:00</option>
												<option value="06:00">오전 06:00</option>
												<option value="07:00">오전 07:00</option>
												<option value="08:00">오전 08:00</option>
												<option value="09:00">오전 09:00</option>
												<option value="10:00">오전 10:00</option>
												<option value="11:00">오전 11:00</option>
												<option value="12:00">오후 12:00</option>
												<option value="01:00">오후 01:00</option>
												<option value="02:00">오후 02:00</option>
												<option value="03:00">오후 03:00</option>
												<option value="04:00">오후 04:00</option>
												<option value="05:00">오후 05:00</option>
												<option value="06:00">오후 06:00</option>
												<option value="07:00">오후 07:00</option>
												<option value="08:00">오후 08:00</option>
												<option value="09:00">오후 09:00</option>
												<option value="10:00">오후 10:00</option>
												<option value="11:00">오후 11:00</option>
											</select>
										</div>
										<div class="col-md-2 wow fadeIn animated"
											data-wow-delay="0.3s" data-wow-duration="2s">
											<label for="phone">반납날짜</label> <input type="text"
												id="datepicker2" name="rentEndDate" required />
										</div>
										<div class="col-md-2 wow fadeIn animated"
											data-wow-delay="0.3s" data-wow-duration="2s">
											<label for="phone">반납시간</label>
											 <select name="job" id="rentEndTime">
												<option value="">시간선택</option>
												<option value="00:00">오전 00:00</option>
												<option value="01:00">오전 01:00</option>
												<option value="02:00">오전 02:00</option>
												<option value="03:00">오전 03:00</option>
												<option value="04:00">오전 04:00</option>
												<option value="05:00">오전 05:00</option>
												<option value="06:00">오전 06:00</option>
												<option value="07:00">오전 07:00</option>
												<option value="08:00">오전 08:00</option>
												<option value="09:00">오전 09:00</option>
												<option value="10:00">오전 10:00</option>
												<option value="11:00">오전 11:00</option>
												<option value="12:00">오후 12:00</option>
												<option value="01:00">오후 01:00</option>
												<option value="02:00">오후 02:00</option>
												<option value="03:00">오후 03:00</option>
												<option value="04:00">오후 04:00</option>
												<option value="05:00">오후 05:00</option>
												<option value="06:00">오후 06:00</option>
												<option value="07:00">오후 07:00</option>
												<option value="08:00">오후 08:00</option>
												<option value="09:00">오후 09:00</option>
												<option value="10:00">오후 10:00</option>
												<option value="11:00">오후 11:00</option>
											</select>
											
										</div>
									<div class="col-md-2 wow fadeIn animated" data-wow-delay="0.3s"
										data-wow-duration="2s">
										<label for="phone"> </label> <input type="button" class="search"
											onclick="searchRentCar()" value="검색하기">
									</div>

									</div>


								</fieldset>
							</form>
							<div id="success">
								<p class="contactalert">Your message was sent succssfully! I
									will be in touch as soon as I can.</p>
							</div>
							<div id="error">
								<p class="contactalert">Something went wrong, try refreshing
									and submitting the form again.</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>



	<script type="text/javascript">
		$('#datepicker1').datepicker(
				{
					dateFormat : "yy-mm-dd",
					dayNamesMin : [ '월', '화', '수', '목', '금', '토', '일' ],
					monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월',
							'8월', '9월', '10월', '11월', '12월' ],
					minDate : 0
				});
		$('#datepicker2').datepicker(
				{
					dateFormat : "yy-mm-dd",
					dayNamesMin : [ '월', '화', '수', '목', '금', '토', '일' ],
					monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월',
							'8월', '9월', '10월', '11월', '12월' ],
					minDate : 0
				});

		function searchRentCar() {
			var rentPlace = document.getElementById("rentPlace").value;
			var startDate = document.getElementById("datepicker1").value;
			var startTime = document.getElementById("rentStartTime").value;
			var endDate = document.getElementById("datepicker2").value;
			var endTime = document.getElementById("rentEndTime").value;
			alert(rentPlace + "" + startDate + "" + startTime + "" + endDate
					+ "" + endTime);
			location.href = "rentList.jsp?rentPlace=" + rentPlace
					+ "&startDate=" + startDate + "&startTime=" + startTime
					+ "&endDate=" + endDate + "&endTime=" + endTime;
		}
	</script>



	<!-- FAQ
	================================================== -->
	<section id="faq" class="section active-section">
		<div class="wrapsection">
			<div class="container">
				<div class="row">
					<div class="col-md-12 sol-sm-12">
						<div class="maintitle">
							<h3 class="section-title">
								CAROUD <span class="wow bounceInRight"
									style="visibility: visible; animation-name: bounceInRight;">Rental Service</span>
							</h3>
							<br>
							<p class="lead">CAROUD는 car + cloud 의 합성어로 서울지역 렌터카 회사들을 모아놓은 공간이라는 뜻에서 시작 되었습니다.
											<br>
											<br>
 											CAROUD Rental Service는 020 서비스로서 렌터카 이용자와 업체간의 불편한점을 해소해 사용자들의 기회비용과 불편함을 해소한 서비스 입니다.  </p>
						</div>
					</div>
				</div>
			</div>
	</section>






	<!-- Text Carousel
	================================================== -->
	<section id="slider" class="parallax section active-section"
		style="background-image: url(&quot;http://themepush.com/demo/runcharity/assets/img/4.jpg&quot;); background-position: 50% 291px;">
		<div class="wrapsection">
			<div class="container">
				<div class="row">
					<div class="col-md-12">
						<div id="Carousel" class="carousel slide">
							<ol class="carousel-indicators">
								<li data-target="#Carousel" data-slide-to="0" class=""></li>
								<li data-target="#Carousel" data-slide-to="1" class="active"></li>
								<li data-target="#Carousel" data-slide-to="2" class=""></li>
							</ol>
							<div class="carousel-inner">
								<div class="item">
									<blockquote>
										<p class="lead">Caroud는 원하는 시간에 렌트카 예약 및
										운행이 가능한 웹사이트 입니다. <br><br></p>
										
									</blockquote>
								</div>
								<div class="item active">
									<blockquote>
										<p class="lead">쉬운 예약 서비스로 원하는 일정과 지역만 선택해주세요
										경차부터 수입차까지 다양한 차량의 예약대수를 확인할 수 있습니다.</p>
										
									</blockquote>
								</div>
								<div class="item">
									<blockquote>
										<p class="lead">기간과 목적에 상관없이 예약과 결제를 한번에 진행하여 
										즉시예약과 이용가능 차량을 보다 특별한 가격에 이용하실 수 있습니다.</p>
										
									</blockquote>
								</div>
							</div>
							<a class="left carousel-control" href="#Carousel"
								data-slide="prev"> <span
								class="glyphicon glyphicon-chevron-left"></span>
							</a> <a class="right carousel-control" href="#Carousel"
								data-slide="next"> <span
								class="glyphicon glyphicon-chevron-right"></span>
							</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>








	<!-- Credits 
=============================================== -->
	<section id="credits" class="text-center">
		<span class="social wow zoomIn"
			style="visibility: visible; animation-name: zoomIn;"> <a
			href="#"><i class="fa fa-facebook"></i></a> <a href="#"><i
				class="fa fa-twitter"></i></a> <a href="#"><i class="fa fa-skype"></i></a>
			<a href="#"><i class="fa fa-linkedin"></i></a> <a href="#"><i
				class="fa fa-pinterest"></i></a> <a href="#"><i
				class="fa fa-google-plus"></i></a>
		</span><br> Shared by <i class="fa fa-love"></i><a
			href="https://bootstrapthemes.co">BootstrapThemes</a>


	</section>
	<!-- Bootstrap core JavaScript
	================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script src="assets/js/jquery.min.js"></script>
	<script src="assets/js/bootstrap.min.js"></script>
	<script src="assets/js/waypoints.min.js"></script>
	<script src="assets/js/jquery.scrollTo.min.js"></script>
	<script src="assets/js/jquery.localScroll.min.js"></script>
	<script src="assets/js/jquery.magnific-popup.min.js"></script>
	<script src="assets/js/validate.js"></script>
	<script src="assets/js/common.js"></script>

</body>
</html>