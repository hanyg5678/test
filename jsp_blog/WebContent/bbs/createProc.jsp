<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/ssi/ssi.jsp" %> 
<jsp:useBean id="dto" class="bbs.BbsDTO"/>
<% 	
	//--업로드용 변수 선언(폴더명)
	String upDir = "/bbs/storage";
	String tempDir = "/bbs/temp";
	//절대경로
	upDir = application.getRealPath(upDir);
	tempDir = application.getRealPath(tempDir);
	
	UploadSave upload = new UploadSave(request,-1,-1, tempDir);
	dto.setWname(UploadSave.encode(upload.getParameter("wname")));
	dto.setTitle(UploadSave.encode(upload.getParameter("title")));
	dto.setContent(UploadSave.encode(upload.getParameter("content")));
	dto.setPasswd(UploadSave.encode(upload.getParameter("passwd")));
	
	FileItem fileitem = upload.getFileItem("filename");
	int size = (int)fileitem.getSize();
	String filename = null;
	
	if(size>0)
	filename = UploadSave.saveFile(fileitem, upDir);
	
	dto.setFilesize(size);
	dto.setFilename(filename);
	

	
	boolean flag = bdao.create(dto);
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
	
	location.href=url;
}



</script>
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<div class="title">처리결과</div>
 
<DIV class="content">
  <%
  if (flag){
    out.println("메모를 등록 했습니다.");
  }else{
    out.println("메모 등록에 실패했습니다.");
  }
  %>
</DIV>
 
<DIV class='bottom'>
  <input type='button' value='계속 등록' onclick="location.href='./createForm.jsp'">
  <input type='button' value='목록' onclick="blist()">
 
</DIV>
 

<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 