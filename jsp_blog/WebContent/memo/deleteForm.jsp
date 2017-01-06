<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %> 
<%
int memono = Integer.parseInt(request.getParameter("memono"));
String col = request.getParameter("col");
String word = request.getParameter("word");
String nowPage = request.getParameter("nowPage");

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
<div class="title">삭제 확인</div>
<form name="frm" method='POST' action='./deleteProc.jsp'>
<input type="hidden" name='memono' size='30' value='<%=memono %>'>
<input type='hidden' name='col' size='30' value='<%=request.getParameter("col")%>'>
<input type='hidden' name='word' size='30' value='<%=request.getParameter("word")%>'>
<input type='hidden' name='nowPage' size='30' value='<%=request.getParameter("nowPage")%>'>
<div class="content">
삭제를 하면 복구 될 수 없습니다.<br><br>
삭제를 하시려면 삭제 처리 버튼을 클릭하세요.<br><br>
취소는 '목록' 버튼을 누르세요.<br><br>
<input type='submit' value='삭제 처리'>
<input type='button' value='목록' onclick="mlist()">

</div>
</form>
<jsp:include page="/menu/bottom.jsp"/>
</body> 
</html> 





