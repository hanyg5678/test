<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<%
	int no = Integer.parseInt(request.getParameter("no"));
	String col = request.getParameter("col");
	String word = request.getParameter("word");
	String nowPage = request.getParameter("nowPage");
	
	String oldfile = request.getParameter("oldfile");
	
	boolean flag = tdao.delete(no);
	if(flag){
		String upDir = application.getRealPath("/team/storage");
		UploadSave.deleteFile(upDir, oldfile);
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
<script type="text/javascript">
function tlist(){
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
	out.println("정보를 삭제했습니다");
} else{
	out.println("정보를 삭제를 실패했습니다");
}
%>
<br>
</div>
<div class="bottom">
<input type='button' value='목록' onclick="tlist()">
</div>
<jsp:include page="/menu/bottom.jsp"/>
</body> 
</html> 
