<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<% 
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	
	boolean flag = dao.updatePw(id, passwd);
%> 
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<style type="text/css"> 
*{ 
  font-family: gulim; 
  font-size: 20px; 
} 
</style> 
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 
<DIV class="title">패스워드 변경처리</DIV>
 <DIV class="content">
 <%
 if(flag){
	 out.print("success<br><br>");
	 out.print("please Login<br>");
 } else{
	 out.print("<h1>fail</h1><br>");
	 out.print("try again<br>");
 }
 
 %>
 
 </DIV>

  
  <DIV class='bottom'>
  <%if(flag){ %>
    <input type='button' value='LogIn' onclick="location.href='./loginForm.jsp'">
    <%} else{ %>
    <input type='button' value='try Again' onclick="history.back()">
    <%} %>
    <input type='button' value='Home' onclick="location.href='../index.jsp'">
  </DIV>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 