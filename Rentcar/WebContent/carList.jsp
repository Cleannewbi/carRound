<%@page import="dao.iMemManager"%>
<%@page import="dao.MemManager"%>
<%@page import="dao.iInfoDao"%>
<%@page import="dto.MemberDto"%>
<%@page import="dto.InfoDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.InfoDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String actionPath = request.getParameter("actionPath");
 
String rentPlace = request.getParameter("rentPlace");
String startDate = request.getParameter("startDate");
String startTime = request.getParameter("startTime");
String endDate = request.getParameter("endDate");
String endTime = request.getParameter("endTime");
System.out.println("carList : " + rentPlace + startDate + startTime + endDate + endTime);

String[] checkedBoxs = request.getParameterValues("arr");
if(checkedBoxs != null) {
	for(int i=0 ; i<checkedBoxs.length ; i++) {
		System.out.println("getParameterValues : " + checkedBoxs[i]);
	}
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>자동차 리스트</title>
<style type="text/css">
/* #div_top {
	width: 100%;
	height: 10%;
	background-color: #ccccee;
	text-align: center;
} */
#div_main {
	margin: auto;
	height: 600px;
	background-color: #cceeee;
}
.info {
	width: 40%;
	height: 200px;
	min-width: 550px;
	min-height: 200px;
	background-color: #ffffff;
	border: 1px solid black;
	margin: 50px 0px 0px 100px;
	padding: 10px 10px 10px 10px;
}
.relativeBtn {
	position: relative;
	 left: 400px; 
	 bottom: 130px;
}
.infoImg {
	 width: auto; height: auto; max-width: 120px; max-height: 120px;
}
.fontSetCenter {
	text-align: center;
}
.infoText {
	position: relative;
	margin-top: 0px;
	font-size: 20px;
	background-color: #ffffff;
}
.infoDetail {
	position: relative;
	left: 200px;
	bottom: 110px;
}
ul {
	list-style: none;
}
li {
	margin: 0 0 100 100;
	padding: 0 0 50 50;
	border: 1;
	float: left;
}
</style>
</head>
<body>
		<%
		// InfoDao idao = InfoDao.getInstance();
		/* List<InfoDto> list = idao.getInfoList(); */
		/* 
		if(checkedBoxs.length == 0 || checkedBoxs[0].equals("")) {
			String[] chkResult = null;
		} else {
			String[] chkResult = idao.getChecked(checkedBoxs);
		}
		*/
		/* 
		InfoDao idao = InfoDao.getInstance();
		if(checkedBoxs != null) {
			List<InfoDto> chkResult = idao.getChecked(checkedBoxs);
		} else {
			List<InfoDto> chkResult = idao.getInfoList();
		}
 		*/
		%>
<!-- 검색결과화면 -->
<form action="<%=actionPath %>" name="frmPaging" method="get">
<div id="div_main">
	<ul>
	<%
	InfoDao idao = InfoDao.getInstance();
	
	// 체크박스를 통해 들어온 경우
	if(checkedBoxs != null) {
		List<InfoDto> chkResult = idao.getChecked(checkedBoxs);
	
		// 리스트 안에 값이 없을경우
		if(chkResult == null || chkResult.size() == 0) {
			%>
			<li>
			<strong style="text-align: center; height: 100px;">등록된 차량이 없습니다.</strong>
			</li>
			<% 		
		// 리스트 안에 값이 있을경우
		} else {
			for(int i=0 ; i < chkResult.size() ; i++) {
				InfoDto idto = chkResult.get(i);
				iMemManager mdto = MemManager.getInstance();
				MemberDto comInfo = mdto.getCom(idto.getCom_name());
				
				
				String comPhotoName = "";
				String carPhotoName = "";
				try{
					comPhotoName = comInfo.getMember_Photo().trim();
					carPhotoName = idto.getCar_pic().trim();
				    System.out.println("comdto.contain:"+comInfo.getMember_Photo().contains("."));
				    System.out.println("carpic.contain:"+idto.getCar_pic().contains("."));
				} catch(Exception e) {
				    	System.err.println(e);
				}
				if(!comPhotoName.isEmpty() && comPhotoName.contains(".")){
			    	//fileName = dto1.getMember_Photo().trim();
			    System.out.println("dto photo 이미지 있음:"+comInfo.getMember_Photo().trim());
			    } else if(!comPhotoName.contains(".") || comPhotoName.isEmpty()){
			    	System.out.println("dto photo 이미지가 아님:"+comInfo.getMember_Photo().trim());
			    	comPhotoName = "noImage.png";
			    }
				
				if(!carPhotoName.isEmpty() && carPhotoName.contains(".")){
			    	//fileName = dto1.getMember_Photo().trim();
			    System.out.println("dto photo 이미지 있음:"+idto.getCar_pic().trim());
			    } else if(!carPhotoName.contains(".") || carPhotoName.isEmpty()){
			    	System.out.println("dto photo 이미지가 아님:"+idto.getCar_pic().trim());
			    	carPhotoName = "noImage.png";
			    }
				
			%>
			<li>
				<div class="info">
					<div><strong class="infoText" id="carName" value="carName"><%=idto.getCar_name() %></strong>&nbsp;</div>
					<a href="'RentCarDetail.jsp?seq='<%=idto.getInfo_seq() %>"><img class="infoImg" src='./images/<%=carPhotoName %>'></a>
						<!-- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
						
						<div class="infoDetail">차량등급&nbsp;&nbsp;<strong><%=idto.getCar_size() %></strong></div> &nbsp; 
						<div class="infoDetail">연료&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong><%=idto.getCar_fuel() %></strong></div> &nbsp; 
						<div class="infoDetail">차량종류&nbsp;&nbsp;<strong><%=idto.getCar_type() %></strong></div>
						<div class="infoDetail" name="comName">회사&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong><%=idto.getCom_name() %></strong></div>
						<div class="relativeBtn">
							<input type="button" id="selectCar1" value="선택" onclick="RentCarDetail(seq)">
							<input type="button" id="selectCar2" value="선택" onclick="RentCarOrder('<%=idto.getInfo_seq() %>', '<%=idto.getCar_name() %>', '<%=idto.getCom_name() %>')">
							<%-- 
							<form action="order.jsp" method="post">
							<input type="hidden" name="carName" value="<%=idto.getCar_name() %>">
							<input type="hidden" name="comName" value="<%=idto.getCom_name() %>">
							<input type="hidden" name="startDate" value="<%=startDate %>">
							<input type="hidden" name="startTime" value="<%=startTime %>">
							<input type="hidden" name="endDate" value="<%=endDate %>">
							<input type="hidden" name="endTime" value="<%=endTime %>">
							<input type="submit" value="이동">
							 --%>
							<%-- <input type="button" id="selectCar" value="선택" onclick="RentCarDetail('<%=idto.getInfo_seq() %>')"> --%>
							</form>
						</div> 
		
				</div>
			</li>
	
		<%
			}
		}
	// 검색을 통해 들어온 경우
	} else {
		String comname = "";
		String carname = "";
		List<InfoDto> chkResult = idao.getInfoSearchableList(carname, comname);
		
		// 리스트 안에 값이 없을경우
		if(chkResult == null || chkResult.size() == 0) {
			%>
			<li>
			<strong style="text-align: center; height: 100px;">등록된 차량이 없습니다.</strong>
			</li>
			<% 		
		// 리스트 안에 값이 있을경우
		} else { 
			for(int i=0 ; i < chkResult.size() ; i++) {
				InfoDto idto = chkResult.get(i);
				
				iMemManager mdto = MemManager.getInstance();
				MemberDto comInfo = mdto.getCom(idto.getCom_name());
				
				
				String comPhotoName = "";
				String carPhotoName = "";
				try{
					comPhotoName = comInfo.getMember_Photo().trim();
					carPhotoName = idto.getCar_pic().trim();
				    System.out.println("comdto.contain:"+comInfo.getMember_Photo().contains("."));
				    System.out.println("carpic.contain:"+idto.getCar_pic().contains("."));
				} catch(Exception e) {
				    	System.err.println(e);
				}
				if(!comPhotoName.isEmpty() && comPhotoName.contains(".")){
			    	//fileName = dto1.getMember_Photo().trim();
			    System.out.println("dto photo 이미지 있음:"+comInfo.getMember_Photo().trim());
			    } else if(!comPhotoName.contains(".") || comPhotoName.isEmpty()){
			    	//System.out.println("dto photo 이미지가 아님:"+comInfo.getMember_Photo().trim());
			    	comPhotoName = "noImage.png";
			    }
				
				if(!carPhotoName.isEmpty() && carPhotoName.contains(".")){
			    	//fileName = dto1.getMember_Photo().trim();
			    System.out.println("dto photo 이미지 있음:"+idto.getCar_pic().trim());
			    } else if(!carPhotoName.contains(".") || carPhotoName.isEmpty()){
			    	//System.out.println("dto photo 이미지가 아님:"+idto.getCar_pic().trim());
			    	carPhotoName = "noImage.png";
			    }
			%>
			<li>
				<div class="info">
					<div><strong class="infoText" id="carName" value="<%=idto.getCar_name() %>"><%=idto.getCar_name() %></strong>&nbsp;</div>
					<a href="RentCarDetail.jsp?seq=<%=idto.getInfo_seq() %>"><img class="infoImg" src='./images/<%=carPhotoName %>'></a>
						<!-- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
						
						<div class="infoDetail" name="size">차량등급&nbsp;&nbsp;<strong><%=idto.getCar_size() %></strong></div> &nbsp; 
						<div class="infoDetail" name="fuel">연료&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong><%=idto.getCar_fuel() %></strong></div> &nbsp; 
						<div class="infoDetail" name="type">차량종류&nbsp;&nbsp;<strong><%=idto.getCar_type() %></strong></div> &nbsp;
						<div class="infoDetail" name="comp" id="comName" value="<%=idto.getCom_name() %>">회사&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong><%=idto.getCom_name() %></strong></div>
						<div class="relativeBtn">
							<input type="button" id="selectCar1" value="상세정보" onclick="RentCarDetail('<%=idto.getInfo_seq() %>')">
							<input type="button" id="selectCar2" value="예약하기" onclick="RentCarOrder('<%=idto.getInfo_seq() %>', '<%=idto.getCar_name() %>', '<%=idto.getCom_name() %>')">
<%-- 							
							<form action="order.jsp" method="post">
							<input type="hidden" name="carName" value="<%=idto.getCar_name() %>">
							<input type="hidden" name="comName" value="<%=idto.getCom_name() %>">
							<input type="hidden" name="startDate" value="<%=startDate %>">
							<input type="hidden" name="startTime" value="<%=startTime %>">
							<input type="hidden" name="endDate" value="<%=endDate %>">
							<input type="hidden" name="endTime" value="<%=endTime %>">
							<input type="submit" value="이동">
							 --%>
						</div> 
				</div>
			</li>

		<%
			}
		}
	}
	%>
	</ul>
</div>
</form>

<script type="text/javascript">
function RentCarOrder(seq, carName, comName) {
/* 	var carName = document.getElementById("carName").value;
	var comName = document.getElementById("comName").value; */
	var startDate = "<%=request.getParameter("startDate") %>";
	var startTime = "<%=request.getParameter("startTime") %>";
	var endDate = "<%=request.getParameter("endDate") %>";
	var endTime = "<%=request.getParameter("endTime") %>";
	
	alert("seq=" + seq + "&carName=" + carName + "&comName=" + comName + "&startDate=" + startDate + "&startTime=" + startTime + 
			"&endDate=" + endDate + "&endTime=" + endTime);
	location.href = "order.jsp?seq=" + seq + "&carName=" + carName + "&comName=" + comName + "&startDate=" + startDate + "&startTime=" + startTime +
			"&endDate=" + endDate + "&endTime=" + endTime;
	
	
}
function RentCarDetail(seq) {
	location.href = "RentCarDetail.jsp?seq=" + seq;
}
</script>

</body>
</html>