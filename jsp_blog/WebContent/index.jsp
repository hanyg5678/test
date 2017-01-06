<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<% 
	String id = (String)session.getAttribute("id");
	String grade = (String)session.getAttribute("grade");
	String str = null;
	if(id==null){
		str="안녕하세요 발표자 황 현입니다.";
	} else{
		str="안녕하세요 "+id+" 님!!";
	}
	
	
	String title = "1조  이미지 게시판 팀 프로젝트 ";
	if(id!=null && grade.equals("A")){
	   title="관리자 페이지";
	}
%> 

<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<style type="text/css"> 
*{ 
  font-size: 24px; 
} 
</style> 
<link href="css/style.css" rel="stylesheet">
</head> 
<body leftmargin="0" topmargin="0">
<jsp:include page="./menu/top.jsp"/>
<DIV class="title"><%=title %></DIV>

<DIV class="content">
	<h1><%=str %></h1>
	<img src="./images/sanazzang.gif" width="50%">
	<br>
	<br>
	<% if(id==null){ %>
		<input type="button" value="로그인" class="button" onclick="location.href='member/loginForm.jsp'">
	<% } else{ %>
		<input type="button" value="로그아웃" class="button" onclick="location.href='member/logout.jsp'">
	<%   } %>
</DIV>
 
<jsp:include page="/menu/bottom.jsp"/>

</body>
 
</html> 