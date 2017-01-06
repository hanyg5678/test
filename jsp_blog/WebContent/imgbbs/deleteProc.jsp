<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp"%>
<% 
	int no = Integer.parseInt(request.getParameter("no"));
	String passwd = request.getParameter("passwd");
	
	String col = request.getParameter("col");
	String word = request.getParameter("word");
	String nowPage = request.getParameter("nowPage");
	String oldfile = request.getParameter("oldfile");
	
	Map map = new HashMap();
	map.put("no", no);
	map.put("passwd", passwd);
	boolean pflag = idao.passCheck(map);
	//수정처리
	boolean flag = false;
	if (pflag) {
		flag = idao.delete(no);
	}
	if(flag){
		String upDir = application.getRealPath("/imgbbs/storage");
		UploadSave.deleteFile(upDir,oldfile);
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
  font-size: 20px; 
} 
</style>
<script type="text/javascript">
function ilist(){
	var url = "./list.jsp";
	url += "?col=<%=col%>";
	url += "&word=<%=word%>";
	url += "&nowPage=<%=nowPage%>";
	location.href=url;
}
</script> 
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 
<DIV class="title">삭제처리</DIV>

<div class="content">
<%
	if(pflag==false){
		out.print("패스워드 불일치");}
	else if(flag){
		out.print("글을 삭제하였습니다.");}
	else{
		out.print("글삭제를 실패했습니다.");}

%>
</div>
 

  <%if(pflag==false){%>
  <DIV class='bottom'>
    <input type='button' value='다시시도'onclick="history.back()">
    <input type='button' value='목록' onclick="ilist()">
  </DIV>
  

 
  <%}else{%>
  <DIV class='bottom'>
    <input type='submit' value='다시등록'onclick="location='./createForm.jsp'">
    <input type='button' value='목록' onclick="ilist()">
  </DIV>
 <%} %>
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 