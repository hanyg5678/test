<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<%
  int no = Integer.parseInt(request.getParameter("no"));
  ImgbbsDTO dto  = idao.read(no);
  
  String upDir = "/imgbbs/storage";
  String tempDir ="/imgbbs/temp";
  
  upDir = application.getRealPath(upDir);
  tempDir = application.getRealPath(tempDir);
  
  
  UploadSave upload = new UploadSave(request,-1,-1,tempDir);
  String oldfile = UploadSave.encode(upload.getParameter("oldfile"));
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
function incheck(f){ //f는 그냥 변수 그냥 다른걸로 써도됨
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
 
<DIV class="title">수정</DIV>
 
<FORM name='frm' 
	  method='POST' 
	  action='./updateProc.jsp'
	  enctype="multipart/form-data" 
	  onsubmit="return incheck(this)">
 
  <input name="no" value="<%=no %>" type="hidden">
  <input name="col" value="<%=request.getParameter("col") %>" type="hidden">
  <input name="word" value="<%=request.getParameter("word") %>" type="hidden">
  <input name="nowPage" value="<%=request.getParameter("nowPage") %>" type="hidden">
  <input name="oldfile" value="<%=dto.getFilename() %>" type="hidden">
  <TABLE style="width: 45%;">
     <TR>
      <TD colspan="2">
      <img style="width:300px;height:200px;" src="./storage/<%=dto.getFilename()%>">
      </TD>
      <td></td>
    </TR>
    <TR>
      <TH>성명</TH>
      <TD><input type="text" name="name" size="40" value="<%=dto.getName()%>"></TD>
    </TR>
    <TR>
      <TH>제목</TH>
      <TD><input type="text" name="title" size="40" value="<%=dto.getTitle()%>"></TD>
    </TR>
    <TR>
      <TH>사진파일</TH>
      <TD><input type="file" name="filename" size="40"><%=Utility.checkNull(dto.getFilename())%></TD>
    </TR>
    <TR>
      <TH>내용</TH>
      <TD>
      <textarea rows="10" cols="40" name="content"><%=dto.getContent() %></textarea>
      </TD>
    </TR>
    <TR>
      <TH>비밀번호</TH>
      <TD><input type="password" name="passwd"></TD>
    </TR>
  </TABLE>
  
  <DIV class='bottom'>
    <input type='submit' value='수정'>
    <input type='button' value='취소' onclick="history.back()">
  </DIV>
</FORM>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 