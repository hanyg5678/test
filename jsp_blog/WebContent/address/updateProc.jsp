<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<jsp:useBean id="dto" class="address.AddressDTO"/>
<jsp:setProperty property="*" name="dto"/>
<%
	String col = request.getParameter("col");
	String word = request.getParameter("word");
	String nowPage = request.getParameter("nowPage");
	boolean flag = adao.update(dto);
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
<script type="text/javascript">
function alist(){
	var url = "list.jsp";
	url += "?col=<%=col %>";
    url += "&word=<%=word %>";
    url += "&nowPage=<%=nowPage%>";
	location.href=url;
}
</script> 
</head> 
<body> 
<jsp:include page="/menu/top.jsp"/>
<div class="title">수정 처리</div>
<div class="content">
<%
if(flag){
  out.println("수정 완료");
}else{
  out.println("수정 실패");  
}
%>
<br>
</div>
<div class="bottom">
<input type='button' value='목록' onclick="alist()">
</div>
<jsp:include page="/menu/bottom.jsp"/>
</body> 
</html> 


