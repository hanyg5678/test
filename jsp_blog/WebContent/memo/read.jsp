<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<%
int memono = Integer.parseInt(request.getParameter("memono"));
String col = request.getParameter("col");
String word = request.getParameter("word");
String nowPage = request.getParameter("nowPage");

mdao.increaseViewcnt(memono);
MemoDTO dto = mdao.read(memono);



String content = null;
if(dto != null){
	content = dto.getContent();
	content = content.replace("/r/n", "<br>");
}


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
function mcreate(){
var url = "createForm.jsp";
location.href=url;
}
function mupdate(memono){
var url = "updateForm.jsp";
url += "?memono="+memono;
url += "&col=<%=col %>";
url += "&word=<%=word %>";
url += "&nowPage=<%=nowPage %>";
location.href=url;
}
function mdelete(memono){
var url = "deleteForm.jsp";
url += "?memono="+memono;
url += "&col=<%=col %>";
url += "&word=<%=word %>";
url += "&nowPage=<%=nowPage %>";
location.href=url;
}
function mlist(){
var url = "list.jsp";
url += "?col=<%=col %>";
url += "&word=<%=word %>";
url += "&nowPage=<%=nowPage %>";
location.href=url;
}
</script> 
</head> 
<body> 
<jsp:include page="/menu/top.jsp"/>
<div class="title">조회</div>
<table>
<tr>
<th>제목</th>
<td><%=dto.getTitle() %></td>
</tr>
<tr>
<th>내용</th>
<td><%=dto.getContent() %></td>
</tr>
<tr>
<th>조회수</th>
<td><%=dto.getViewcnt() %></td>
</tr>
<tr>
<th>등록일</th>
<td><%=dto.getWdate() %></td>
</tr>

</table>

<div class="bottom">
<input type="button" value="등록" onclick="mcreate()">
<input type="button" value="수정" 
onclick="mupdate('<%=dto.getMemono()%>')">
<input type="button" value="삭제" 
onclick="mdelete('<%=dto.getMemono()%>')">
<input type="button" value="목록" onclick="mlist()">
</div>
<jsp:include page="/menu/bottom.jsp"/>
</body> 
</html>





