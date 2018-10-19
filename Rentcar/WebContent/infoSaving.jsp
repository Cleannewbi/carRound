<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String rentPlace = request.getParameter("rentPlace");
String startDate = request.getParameter("startDate");
String startTime = request.getParameter("startTime");
String endDate = request.getParameter("endDate");
String endTime = request.getParameter("endTime");

request.setAttribute("rentPlace", rentPlace);
request.setAttribute("startDate", startDate);
request.setAttribute("startTime", startTime);
request.setAttribute("endDate", endDate);
request.setAttribute("endTime", endTime);

%>