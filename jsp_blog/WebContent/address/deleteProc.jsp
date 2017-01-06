<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<%
	int no = Integer.parseInt(request.getParameter("no"));
	String col = request.getParameter("col");
	String word = request.getParameter("word");	
	String nowPage = request.getParameter("nowPage");
	boolean flag = adao.delete(no);
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
<div class="content">
<%
if(flag){
out.println("삭제성공");
} else{
out.println("삭제실패");
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
