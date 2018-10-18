<%@page import="org.apache.catalina.servlet4preview.ServletContext"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="dto.MemberDto"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="dao.MyPageDao"%>
<%@page import="dao.iMyPageDao"%>
<%@page import="java.io.File"%>
<%@page import="java.io.IOException"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    Object ologin = session.getAttribute("login");
   /*  String file = request.getParameter("fileName");
     System.out.println("file:"+file);
     String phonenum = request.getParameter("phone");
     String address = request.getParameter("address");
     String email = request.getParameter("email");
     String cardnum = request.getParameter("card"); */
     MemberDto dto = (MemberDto)ologin;
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>pdsupload.jsp</title>
</head>
<body>
<%!
public String processUploadFile(FileItem fileItem, String dir, JspWriter out) 
		throws IOException{
String f = fileItem.getName();
long sizeInBytes = fileItem.getSize();

String fileName = ""; 
String fpost="";

// 업로드한 파일이 정상일 경우
/* if(sizeInBytes > 0){ */	// d:\\tmp\\abc.jpg    d:/tmp/abc.jpg
/* int idx = fileName.lastIndexOf("\\");
if(idx == -1){
idx = fileName.lastIndexOf("/");
}
fileName = fileName.substring(idx + 1);
*/		

/* if(f.indexOf('.')>=0){
fpost=f.substring(f.indexOf('.'));			
fileName=new Date().getTime()+fpost;
}else{
fileName=new Date().getTime()+".back";
}  */

try{
File uploadFile = new File(dir, fileName);
fileItem.write(uploadFile);	// 실제 업로드하는 부분
}catch(Exception e){}		
	

return fileName;
}
%>

<%
String fupload = application.getRealPath("/images");

System.out.println("파일업로드:" + fupload);

String yourTempDirectory = fupload;

int yourMaxRequestSize = 500 * 1024 * 1024;	// 1M
int yourMaxMemorySize = 500 * 1024;

// form field 에 데이터(String)
String id = "";


// file data
MultipartRequest multi = new MultipartRequest(request, fupload, yourMaxMemorySize, "utf-8", new DefaultFileRenamePolicy());
String filename = "";
String file = multi.getFilesystemName("fileName");
System.out.println("file:"+file);
String phonenum = multi.getParameter("phone");
String address = multi.getParameter("address");
String email = multi.getParameter("email");
String cardnum = multi.getParameter("card");

boolean isMultipart = ServletFileUpload.isMultipartContent(request);
if(isMultipart){
	
	////////////////////// file
	
	// FileItem 오브젝트를 생성하는 클래스
	DiskFileItemFactory factory = new DiskFileItemFactory();
	
	factory.setSizeThreshold(yourMaxMemorySize);
	factory.setRepository(new File(yourTempDirectory));
	
	ServletFileUpload upload = new ServletFileUpload(factory);
	upload.setSizeMax(yourMaxRequestSize);	// 파일 업로드 최대 크기	
	
	///////////////////////////
	
	List<FileItem> items = upload.parseRequest(request);
	Iterator<FileItem> it = items.iterator();

	while(it.hasNext()){	
		FileItem item = it.next();
		if(item.isFormField()){
			if(item.getFieldName().equals("id")){
				id = item.getString("utf-8");
			/* }else if(item.getFieldName().equals("phone")){
				title = item.getString("utf-8");
			}else if(item.getFieldName().equals("address")){
				content = item.getString("utf-8");
			} */
			
		}		
		else{ // fileload
			if(item.getFieldName().equals("fileName")){
				filename = processUploadFile(item, fupload, out);
			}
			System.out.println("fupload:" + fupload);
		}	
	}	
}
	
}else{
	// multipart type 아님
}

//System.out.println("Servlet Path:");
iMyPageDao dao = MyPageDao.getInstance();
int seq = dto.getMember_seq();
System.out.println("pdsupload seq:"+seq);
System.out.println("pdsupload file:"+file+"phonenum:"+phonenum+"address:"+address+"email:"+email+"cardnum:"+cardnum);
boolean isS = dao.updateMyPage(file, phonenum, address, email, cardnum, seq);
if(isS){
%>
<script type="text/javascript">
alert("파일 업로드 성공");
location.href = "index.jsp";	
</script>
<%
}else{
%>
	<script type="text/javascript">
	alert("파일 업로드 실패");
	location.href = "index.jsp";	
	</script>
<%
}
%>



</body>
</html>