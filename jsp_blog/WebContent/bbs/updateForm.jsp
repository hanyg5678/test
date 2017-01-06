<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/ssi/ssi.jsp" %>
<% 
	int bbsno = Integer.parseInt(request.getParameter("bbsno"));
	int cnt = 0;
	BbsDTO dto = bdao.read(bbsno);
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
  font-size: 20px; 
} 
</style> 
<script type="text/javascript">

function incheck(f) {
	if(f.wname.value==""){
		alert("이름을 입력하세요");
		f.wname.focus();
		return false;
	}
	if(f.title.value==""){
		alert("제목을 입력하세요");
		f.title.focus();
		return false;
	}
	if(f.content.value==""){
		alert("내용을 입력하세요");
		f.content.focus();
		return false;
	}
	if(f.passwd.value==""){
		alert("비밀번호을 입력하세요");
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
 
<DIV class="title">수정</DIV>
 
<FORM name='frm' 
	  method='POST' 
	  action='./updateProc.jsp' 
	  onsubmit="return incheck(this)"
	  enctype="multipart/form-data">
	<input type='hidden' name='bbsno' size='30' value='<%=bbsno %>'>
	<input type='hidden' name='col' size='30' value='<%=request.getParameter("col")%>'>
	<input type='hidden' name='word' size='30' value='<%=request.getParameter("word")%>'>
	<input type='hidden' name='nowPage' size='30' value='<%=request.getParameter("nowPage")%>'>
	<input type='hidden' name='oldfile' size='30' value='<%=dto.getFilename()%>'>
  <TABLE class='table'>
     <TR>
      <TH>제목</TH>
      <TD><input type='text' name='title' size='40' value='<%=dto.getTitle() %>'></TD>
    </TR>
    <TR>
      <TH>내용</TH>
      <TD><TEXTAREA name='content' rows='10' cols='40'><%=dto.getContent() %></TEXTAREA></TD>
    </TR>
    <TR>
      <TH>성명</TH>
      <TD><input type='text' name='wname' size='40' value='<%=dto.getWname() %>'></TD>
    </TR>  
    <TR>
      <TH>패스워드</TH>
      <TD><input type='password' name='passwd' size='40' value=''></TD>
    </TR>    
  <TR>
      <TH>파일등록</TH>
      <TD><input type="file" name="filename" size="40">(<%=Utility.checkNull(dto.getFilename())%>)</TD>
    </TR> 
  </TABLE>
 
  <DIV style='text-align: center; margin-top: 20px; margin-bottom: 20px;'>
    <input type='submit' value='전송'>
    <input type='button' value='취소' onclick="history.back();"> 
  </DIV>  
</Form>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 