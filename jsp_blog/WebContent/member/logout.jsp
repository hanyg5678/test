<%@ page contentType="text/html; charset=UTF-8" %> 
<% request.setCharacterEncoding("utf-8"); 
	String root = request.getContextPath();
	session.invalidate();//모든 세션 변수 제거 (id, grade)
	
	response.sendRedirect("../index.jsp");
%> 
