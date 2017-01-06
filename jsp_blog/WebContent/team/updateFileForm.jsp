<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<% 
	String oldfile = request.getParameter("oldfile");
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
img{
	width: 200px;
	height: 200px;
}
</style> 
<script type="text/javascript">
function incheck(f){
	if(f.filename.value==""){
		alert("파일을 선택하세요");
		f.filename.focus();
		return false;
	}else{
		alert("");
	}
}

</script>
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
	  onsubmit="return incheck(this)"
	  >
	  <input type="hidden" name="no" value="<%=request.getParameter("no")%>">
	  <input type="hidden" name="col" value="<%=request.getParameter("col")%>">
	  <input type="hidden" name="word" value="<%=request.getParameter("word")%>">
	  <input type="hidden" name="nowPage" value="<%=request.getParameter("nowPage")%>">
	  <input type="hidden" name="oldfile" value="<%=oldfile%>">
  <TABLE>
    <TR>
      <TH>원본 파일</TH>
      <TD>
      <img src="./storage/<%=oldfile %>"><br>
      	원본 파일명:<%=oldfile %>
      </TD>
    </TR>

    <TR>
      <TH>변경파일</TH>
      <TD><input type="file" name="filename" accept=".gif, .jpg, .png, .GIF, .JPG, .PNG"></TD>
    </TR>

    <TR>
      <TH></TH>
      <TD></TD>
    </TR>
  </TABLE>
  
  <DIV class='bottom'>
    <input type='submit' value='변경'>
    <input type='button' value='취소' onclick="history.back()">
  </DIV>
</FORM>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 