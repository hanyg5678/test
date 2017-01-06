<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<% 
	int bbsno = Integer.parseInt(request.getParameter("bbsno"));
	String nowPage = request.getParameter("nowPage");
	
	boolean flag = bdao.chechRefno(bbsno);
	
	
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
function incheck(f){
	if(f.passwd.value==""){
		alert("패스워드를 입력하세요");
		f.passwd.focus();
		return false;
	}
}
</script> 
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 
<DIV class="title">삭제</DIV>
 
<DIV class='content'> 
<%
if(flag) {
	out.print("답변 있는 글이므로 삭제 할 수 없습니다.<br>");
	out.print("<input type='button' value='목록으로' onclick='history.go(-2)'>");
} else{ %>
	<FORM name='frm' method='POST' action='./deleteProc.jsp' onsubmit="return incheck(this)">
  		<input type='hidden' name='bbsno' size='30' value='<%=bbsno %>'>
  		<input type='hidden' name='col' size='30' value='<%=request.getParameter("col")%>'>
  		<input type='hidden' name='word' size='30' value='<%=request.getParameter("word")%>'>
  		<input type='hidden' name='nowPage' size='30' value='<%=request.getParameter("nowPage")%>'>
  		<input type='hidden' name='oldfile' size='30' value='<%=request.getParameter("oldfile")%>'>
  		삭제하면 복구 할 수 없습니다 <br><br>
  		<TABLE>
    		<TR>
		      <TH>패스워드</TH>
      		  <TD>
      			<input type='password' name='passwd' size='40' value=''>
      		  </TD>
    		</TR>		
  		</TABLE>
  
  <DIV class='bottom'>
    <input type='submit' value='삭제'>
    <input type='button' value='취소' onclick="history.back();">
  </DIV>
	</FORM>
<% } %>
</DIV>

 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 