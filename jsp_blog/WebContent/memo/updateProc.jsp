<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<jsp:useBean id="dto" class="memo.MemoDTO"/>
<jsp:setProperty property="*" name="dto"/>
<%
String col = request.getParameter("col");
String word = request.getParameter("word");
String nowPage = request.getParameter("nowPage");
boolean flag = mdao.update(dto);

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
<script type="text/javascript">
function mlist(){
	var url = "list.jsp";
	url += "?col=<%=col %>";
    url += "&word=<%=word %>";
    url += "&nowPage=<%=nowPage %>";
	location.href=url;
}
</script> 
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<body> 
<jsp:include page="/menu/top.jsp"/>
<div class="content">
<%
if(flag){
	out.println("메모를 수정 했습니다.");
}else{
	out.print("메모를 수정에 실패했습니다");	
}
%>
<br>
</div>
<div class="bottom">

<input type='button' value='목록' onclick="mlist()">
</div>
<jsp:include page="/menu/bottom.jsp"/>
</body> 
</html> 


