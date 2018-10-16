<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="magager.css">
</head>
<body>
<div id="header">
	<h1>고객소통 페이지</h1>
</div>

<div id="nav">
<br>
	<button type="button" class="btn" onclick="manager(1)">회원관리</button><br><br>
	<button type="button" class="btn"onclick="manager(2)">매출관리</button><br><br>
	<button type="button" class="btn"onclick="manager(3)">고객과의 소통</button><br><br>
</div>
<script type="text/javascript">
function manager(number) {
	if(number==1){
		alert("1번입니다.");
		location.href="manageMem.jsp";
	}else if(number==2){
		alert("2번입니다.");
		location.href="manageSale.jsp";
	}else if(number==3){
		alert("3번입니다.");
		location.href="manageQnA.jsp";
	}
}

</script>

<!-- 고객의 quest를 db에 저장, 불러와서 게시판에 넣고 게시판 누르고 답글쓰기 -> 답글써놓으면 사라지도록 
q&a는 마이페이지에서도 확인가능해야할것 혹은 그냥 이메일보내는걸로 -->

<div id="section">

</div>

</body>
</html>