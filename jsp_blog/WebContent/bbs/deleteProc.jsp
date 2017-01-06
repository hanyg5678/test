<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %> 
<%
	String col = request.getParameter("col");
	String word = request.getParameter("word");
	int bbsno = Integer.parseInt(request.getParameter("bbsno"));
	String passwd = request.getParameter("passwd");
	String nowPage = request.getParameter("nowPage");
	String oldfile = request.getParameter("oldfile");
	
	Map map = new HashMap();
	map.put("bbsno", bbsno);
	map.put("passwd", passwd);
	boolean pflag = bdao.passCheck(map);
	boolean flag = false;
	
	
		if(pflag){
			flag = bdao.delete(bbsno);
		}
		if(flag){
			String upDir = application.getRealPath("/bbs/storage");
			Utility.deleteFile(oldfile, upDir);
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
function blist(){
	var url = "list.jsp";
	url += "?col=<%=col %>";
    url += "&word=<%=word %>";
    url += "&nowPage=<%=nowPage %>";
	location.href=url;
}
</script> 
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 
<DIV class="title">처리결과</DIV>
<DIV class="content">
<%

	if(pflag==false){
		out.println("패스워드가 일치하지 않습니다");
	}else if(flag){
		out.println("삭제성공");
	}else{
		out.println("삭제 실패");
	}

%>
</DIV>

<%if(pflag == false){
%>
<DIV class="bottom">
	  <input type='button' value='다시 시도' onclick="history.back();">       
      <input type='button' value='목록' onclick="blist()">
</DIV>
<%} else{ %>
  <DIV class='bottom'>
      <input type='button' value='등록' onclick="location.href='./createForm.jsp'">       
      <input type='button' value='목록' onclick="blist()">
    </DIV>

<%} %>

 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 