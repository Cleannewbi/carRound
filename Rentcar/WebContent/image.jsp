<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
        
<%
request.setCharacterEncoding("utf-8");
%>
    
    <%
    String filename = "";
 	
    boolean isMultipart = ServletFileUpload.isMultipartContent(request);
    if(isMultipart){
    	DiskFileItemFactory factory = new DiskFileItemFactory();
    	
    	ServletFileUpload upload = new ServletFileUpload(factory);
    	List<FileItem> items = upload.parseRequest(request);
    	Iterator<FileItem> it = items.iterator();
    	
    	while(it.hasNext()){
	    	FileItem item = it.next();
	   		 filename = item.getName();

	   	//	String dir = "e:\\image";
	   		String uploadUri = "/image";			// webcontent 안에 image폴더 만듦
	   		String dir = request.getSession().getServletContext().getRealPath(uploadUri);		
	   		System.out.println(dir);	// 물리적경로 확인
	   		item.write(new File(dir, filename));
    	}
    }   
    
    
    // response.sendRedirect("comRegi.jsp?imgname="+filename);
    String filenameK = URLEncoder.encode(filename);		// 한글 넘어갈때 깨져서 추가해줌
    response.sendRedirect("comRegi.jsp?imgname="+filenameK);
    %>
<!--     
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html> -->