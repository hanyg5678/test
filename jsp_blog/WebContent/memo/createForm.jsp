<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<% request.setCharacterEncoding("utf-8"); %> 

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
function input(frm){
	if(frm.title.value==""){
		alert("제목 넣어라");
		frm.title.focus();
		return false;
	}
	if(frm.content.value==""){
		alert("내용 넣어라");
		frm.content.focus();
		return false;
	}
	
}

</script>
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<body> 
<jsp:include page="/menu/top.jsp"/>
<div class="title">등록</div>
<form name="frm" method="POST" action="./createProc.jsp"
onsubmit="return input(this)">
<table>
<tr>
	<th>제목</th>
	<td>
	<input type='text' name='title' size='30' value='화요일'>
	</td>
</tr>
<tr>
	<th>내용</th>
	<td>
	<textarea name='content' rows='10' cols='30' >SQL 수업</textarea>
	</td>
</tr>

</table>

<div class="bottom">
<input type='submit' value='전송'>
</div>
</form>
<jsp:include page="/menu/bottom.jsp"/>
</body> 
</html> 