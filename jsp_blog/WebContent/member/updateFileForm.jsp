<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<%

	String id = request.getParameter("id");
	String oldfile = request.getParameter("oldfile");
	
	
	
%> 
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<script type="text/javascript">
function inCheck(f){
	if(f.fname.value==""){
		alert("사진넣어라");
		f.fname.focus();
		return false;
	}
}

</script>
<style type="text/css"> 
*{ 
  font-family: gulim; 
  font-size: 20px; 
} 
</style> 
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 
<DIV class="title">사진 수정</DIV>
 
<FORM name='frm' 
	  method='POST' 
	  action='./updateFileProc.jsp'
	  enctype="multipart/form-data"
	  onsubmit="return inCheck(this)">
	  <input type="hidden" name="id" value="<%=id%>">
	  <input type="hidden" name="oldfile" value="<%=oldfile%>">
  <TABLE>
    <TR>
      <TH>원본파일</TH>
      <TD>
      	<img src="./storage/<%=oldfile%>">
       	원본파일명 : <%=oldfile %>
      </TD>
    </TR>
    <TR>
      <TH>변경파일</TH>
      <TD>
      <input type="file" name="fname" accept=".png,.gif,.jpg">
      </TD>
    </TR>
  </TABLE>
  <DIV class="bottom">
		<input type="submit" value="변경">
		<input type="button" value="취소" onclick="history.back()">
  </DIV>
  
</FORM>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 