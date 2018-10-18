<%@page import="dto.MemberDto"%>
<%@ page contentType="images/jpg" %>
 
<%@ page import="java.util.*,java.io.*" %>
<%
//parameter을 받는 부분
Object ologin = session.getAttribute("login");
String id = request.getParameter("id");

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
 
BufferedInputStream bis = null;
BufferedOutputStream bos = null;
 
String imagePath = "";
String fileName = dto.getMember_Photo();

imagePath = "\\\\192.168.30.31\\Users\\user2\\images\\" + fileName ;

 
File file = new File(imagePath);
int size = (int)file.length();
 
out.clear();
bos = new BufferedOutputStream(response.getOutputStream());
byte b[] = new byte[2048];
int read = 0;
if( size>0 && file.isFile() ) {
    bis = new BufferedInputStream(new FileInputStream(file));
    while((read=bis.read(b))!=-1 ) {
        bos.write(b,0,read);
    }
} 
bos.close();
%>