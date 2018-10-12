<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%--     <%
request.setCharacterEncoding("utf-8");
%>
    
     --%>
    <%
    String imgname = request.getParameter("imgname");		// 이미지 출력 위해 받아옴

    %>

    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<body>
<br><br><br><br>



<form action="image.jsp" method="post" enctype="multipart/form-data">
<div align="center">
<h2>기업 가입</h2>
<br><br>
<table>
		<%if(imgname != null){ %>
		<tr>
			<td>
				<img alt="" src="image/<%=imgname %>" height="100" width="100">
			</td>
		</tr>
		
		<%}else{ %>
		<tr>
			<td>
				사진을 등록해주세요
			</td>
		</tr>
		<%} %>
<tr>
	<td>
		<input type="file" name="image" style="width: 200px">
	</td>
	<td>
		<input type="submit" value="올리기">
	</td>
</tr>
</table>
</div>
</form>


<br>
<form onsubmit="return check()" name="fr" action="regi.jsp" >		
<div align="center">
	<table>
		<tr>
			<td>아이디</td>
			<td>
				<input type="text" name="id" id="id" size="20">
				<!-- id확인 -->
				<p id="idcheck" style="font-size: 8px"></p>		
				<input type="button" id="btn" value="id확인">
			</td>
		</tr>

		<tr>
			<td><br>패스워드</td>
			<td><br>
				<input type="password" name="password">
			</td>
		</tr>
	
	
		<tr>
			<td><br>이름</td>
			<td><br>
				<input type="text" name="name">
			</td>
		</tr>
	
	
		<tr>
			<td><br>전화번호</td>
			<td><br>
				<input type="text" name="phone1" size="3"> - <input type="text" name="phone2" size="3"> - <input type="text" name="phone3" size="3">
			</td>
		</tr>
	
		<tr>
			<td colspan="2"><br>주소 찾기</td>
		</tr>

		<tr>
			<td>
				<input type="text" id="sample4_postcode" placeholder="우편번호" name="add1">
				<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기">
			</td>
			<td>	
				<input type="text" id="sample4_roadAddress" placeholder="도로명주소" name="add2">
				<input type="text" id="sample4_jibunAddress" placeholder="지번주소" name="add3">
				<span id="guide" style="color:#999"></span>
			</td>
		</tr>
		
		<tr>
			<td><br>이메일</td>
			<td><br>
				<input type="email" name="email" placeholder="aaa@aaa.com">
			</td>
		</tr>
	
		<tr>
			<td colspan="2"><br>
				<input type="submit" value="회원가입">
				<!-- <input type="hidden" name="command" value="addmem"> -->
				<input type="hidden" name="auth" value="com">
				<input type="hidden" name="imgname" value="<%=imgname %>">
			</td>
		</tr>
	
	</table>
</div>
</form>

<br>


<script type="text/javascript">

function check() {
 	<%-- if(<%=imgname %> == null){
		alert("사진을 등록해주세요");
		return false;
	} --%>
	
	
	if(<%=imgname != null%>){
	
		 	if(fr.id.value == ""){
				alert("아이디를 입력해주세요");
				fr.id.focus();
				return false;
			}
			else if(document.getElementById("idcheck").innerHTML ==""){
				alert("아이디 중복 검사를 해주세요");
				return false;
			}
			else if(fr.password.value == ""){
				alert("패스워드를 입력해주세요");
				fr.password.focus();
				return false;
			}else if(fr.name.value == ""){
				alert("이름을 입력해주세요");
				fr.name.focus();
				return false;
			}else if(fr.phone1.value == "" || fr.phone2.value == "" || fr.phone3.value == ""){
				alert("전화번호를 입력해주세요");
				fr.phone1.focus();
				return false;
			}
			else if(fr.add1.value == "" || fr.add2.value == "" || fr.add3.value == ""){
				alert("주소를 입력해주세요");
				fr.add1.focus();
				return false;
			}else if(fr.email.value == ""){
				alert("이메일을 입력해주세요");
				fr.email.focus();
				return false;
			}
		 	
 	
	} else{	
		alert("사진을 등록해주세요");
		return false;
	}
 	
}
</script>



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


<script type="text/javascript">
function sample4_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
            var extraRoadAddr = ''; // 도로명 조합형 주소 변수

            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if(data.buildingName !== '' && data.apartment === 'Y'){
               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }
            // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
            if(fullRoadAddr !== ''){
                fullRoadAddr += extraRoadAddr;
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample4_postcode').value = data.zonecode; //5자리 새우편번호 사용
            document.getElementById('sample4_roadAddress').value = fullRoadAddr;
            document.getElementById('sample4_jibunAddress').value = data.jibunAddress;

            // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
            if(data.autoRoadAddress) {
                //예상되는 도로명 주소에 조합형 주소를 추가한다.
                var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';

            } else if(data.autoJibunAddress) {
                var expJibunAddr = data.autoJibunAddress;
                document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';

            } else {
                document.getElementById('guide').innerHTML = '';
            }
        }
    }).open();
}
</script>






</body>
</html>