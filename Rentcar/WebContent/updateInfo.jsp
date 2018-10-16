<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="dto.MemberDto"%>
<%@page import="dao.MyPageDao"%>
<%@page import="dao.iMyPageDao"%>
<%@page import="dao.MemManager"%>
<%@page import="dao.iMemManager"%>
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

MultipartRequest multi = null;

String uploadUri = "\\\\192.168.30.31\\Users\\user2\\images";	// webcontent 안에 image폴더 만듦
String realPath = getServletContext().getRealPath(uploadUri);
int sizeLimit = 10 * 1024 * 1024;

multi = new MultipartRequest(request, uploadUri, sizeLimit, "utf-8", new DefaultFileRenamePolicy());
String phonenum = multi.getParameter("phone");
String address = multi.getParameter("address");
String email = multi.getParameter("email");
String cardnum = multi.getParameter("card");

// session
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

%>
    <%
    String photo = request.getParameter("fileName");
    boolean isMultipart = ServletFileUpload.isMultipartContent(request);
    
    if(isMultipart){
    	DiskFileItemFactory factory = new DiskFileItemFactory();
    	
    	ServletFileUpload upload = new ServletFileUpload(factory);
    	List<FileItem> items = upload.parseRequest(request);
    	Iterator<FileItem> it = items.iterator();
    	
    	while(it.hasNext()){
    		
	    	FileItem item = it.next();
	   		photo = item.getName();
	   		
	   		String dir = request.getSession().getServletContext().getRealPath(uploadUri);
	   		if(dir.equals("") || photo == null) {
	   			break;
	   		} else {
	//	   		String dir = "e:\\image";
		   		System.out.println(dir);	// 물리적경로 확인
		   		System.out.println(photo);
		   		
			   	item.write(new File(dir, photo));
	   		}
    	}
    }   
    
    
    // response.sendRedirect("comRegi.jsp?imgname="+filename);
    // String filenameK = URLEncoder.encode(photo);		// 한글 넘어갈때 깨져서 추가해줌
    // response.sendRedirect("oMyPage.jsp?fileName="+filenameK);
    

    int seq = dto.getMember_seq();
    System.out.println("updateInfo : " + phonenum + address + email + cardnum + seq);
    
    iMyPageDao dao = MyPageDao.getInstance();
    boolean s = dao.updateMyPage(photo, phonenum, address, email, cardnum, seq);
    
    if(s) {
    	%>
    		<script type="text/javascript">
    			alert("파일업로드 성공");
    			location.href="oMyPage.jsp";
    		</script>
    	<%
    	} else {
    	%>
    		<script type="text/javascript">
    			alert("파일업로드 실패");
    			location.href="oMyPage.jsp";
    		</script>
    	<%} %>
    
    %>