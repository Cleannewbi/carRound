<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
.center{
	margin: auto;
	width: 60%;
	border: 3px solid #8ac007;
	padding: 10px;
}
</style>

</head>
<body>

<!-- 
Login 화면
회원가입
ID확인

BBS 답변게시판

일정관리(Calendar)
 -->
 
<h1>Login</h1>
<p>환영합니다</p>
 
<div class="center">
<form action="Login.jsp" method="post">
<table border="1">
<tr>
	<td>아이디</td>
	<td><input type="text" name="id" size="20"></td>
</tr>
<tr>
	<td>비밀번호</td>
	<td><input type="password" name="pwd" size="20"></td>
</tr>

<tr>
	<td colspan="2">
		<input type="submit" value="로그인">
		<button type="button" onclick="location.href='memRegi.jsp'"> 일반 회원가입</button>
		<button type="button" onclick="location.href='comRegi.jsp'"> 기업 회원가입</button>
	</td>
</tr>
</table>
</form>
</div>

</body>
</html>