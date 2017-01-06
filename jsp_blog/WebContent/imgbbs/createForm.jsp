<%@ page contentType="text/html; charset=UTF-8" %>
<% 
	request.setCharacterEncoding("utf-8"); 
	String root = request.getContextPath();
%> 
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<script type="text/javascript">

function incheck(f) {
	if(f.name.value==""){
		alert("이름을 입력하세요");
		f.name.focus();
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
	if(f.filename.value==""){
		alert("이미지를 저장하세요");
		f.filename.focus();
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
 
<DIV class="title">사진 게시판 등록</DIV>
 
<FORM name='frm' 
	  method='POST' 
	  action='./createProc.jsp' 
	  onsubmit="return incheck(this)"
	  enctype="multipart/form-data">
  <TABLE>
     <TR>
      <TH>이름</TH>
      <TD><input type="text" name="name" size="40"></TD>
    </TR>
    <TR>
      <TH>제목</TH>
      <TD><input type="text" name="title" size="40"></TD>
    </TR>
    <TR>
      <TH>이미지등록</TH>
      <TD><input type="file" name="filename" size="40"></TD>
    </TR>
    <TR>
      <TH>내용</TH>
      <TD>
		<textarea rows="10" cols="40" name="content"></textarea>
      </TD>
    </TR>
    <TR>
      <TH>비밀번호</TH>
      <TD><input type="password" name="passwd" size="40"></TD>
    </TR>
 
  </TABLE>
  
  <DIV class='bottom'>
    <input type='submit' value='등록' class="button"  >
    <input type='button' value='취소' class="button" onclick="history.back()">
  </DIV>
</FORM>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 