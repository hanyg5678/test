<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<jsp:useBean id="dto" class="address.AddressDTO"/>
<jsp:setProperty property="*" name="dto"/>
<%
	boolean flag = adao.create(dto);
%>


<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<style type="text/css"> 
*{ 
  font-family: gulim; 
  font-size: 24px; 
} 
</style>
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css"> 
</head> 
<body> 
<jsp:include page="/menu/top.jsp"/>
<div class="title">등록 처리</div>
<div class="content">
<%
if(flag){
out.println("등록 성공");
} else{
out.println("등록 실패");
}
%>
<br>
</div>
<div class="bottom">
<input type="button" value="계속 등록" onclick="location.href='./createForm.jsp'">
<input type="button" value="목록" onclick="location.href='./list.jsp'">
</div>
<jsp:include page="/menu/bottom.jsp"/>
</body> 
</html> 
