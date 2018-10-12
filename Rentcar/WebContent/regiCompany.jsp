<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>regiCompany.jsp</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<body>
<h2>Registering RentCar Coporation</h2>
<form action="AFregiCompany.jsp">
<div>
<table border="1">
<tr><td>ID</td><td><input type="text" name="id" id="id">
		<!-- id확인 -->
		<p id="idcheck" style="font-size: 8px"></p>		
		<input type="button" id="btn" value="id확인"></td></tr>
<tr><td>PASSWORD</td><td><input type="text" name="pwd"></td></tr>
<tr><td>COMPANY PHOTO</td><td><input type="text" name="photo"></td></tr>
<tr><td>COMPANY NAME</td><td><input type="text" name="com_name"></td></tr>
<tr><td>COMPANY PHONE</td><td><input type="text" name="phone"></td></tr>
<tr><td>COMPANY ADDRESS</td><td><input type="text" name="address"></td></tr>
<tr><td>COMPANY EMAIL</td><td><input type="text" name="email"></td></tr>
</table>

</div>
<input type="submit" value="등록하기">
</form>
<script type="text/javascript">
$(function () {	
	$("#btn").click(function () {		
		$.ajax({
			type:"get",
			url:"./idcheck.jsp",
			data:"id=" + $('#id').val(),			
			success:function(data){				
				if(data.trim() == "OK"){
					$("#idcheck").css("color", "#0000ff");
					$("#idcheck").html("사용할 수 있는 id입니다");
				}else{
					$("#idcheck").css("color", "#ff0000");
					$("#idcheck").html("사용 중인 id입니다");		
					$("#id").val("");
				}
			}			
		});
		
	});
	
});
</script>

</body>
</html>