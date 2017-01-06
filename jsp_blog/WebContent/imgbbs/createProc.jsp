<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/ssi/ssi.jsp" %>
<jsp:useBean id="dto" class="imgbbs.ImgbbsDTO"/>
<% 
	//--업로드용 변수 선언(폴더명)
	String upDir = "/imgbbs/storage";
	String tempDir = "/imgbbs/temp";
	//절대경로
	upDir = application.getRealPath(upDir);
	tempDir = application.getRealPath(tempDir);
	//사진저장을 위한 객체생성.
	UploadSave upload = new UploadSave(request,-1,-1, tempDir);
	dto.setName(UploadSave.encode(upload.getParameter("name")));
	dto.setTitle(UploadSave.encode(upload.getParameter("title")));
	dto.setContent(UploadSave.encode(upload.getParameter("content")));
	dto.setPasswd(UploadSave.encode(upload.getParameter("passwd")));
	//사진의 파일이름과 데이터베이스와의 매칭
	FileItem fileItem = upload.getFileItem("filename");
	int size = (int)fileItem.getSize();
	String filename = null;
	if(size>0){
		filename = UploadSave.saveFile(fileItem, upDir);
	}
	//dto에 파일이름을 저장
	dto.setFilename(filename);
	boolean flag = false;

	flag = idao.create(dto);
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
	var url = "list.jsp";
	
	location.href=url;
}



</script>
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 
<DIV class="title">등록 처리</DIV>

<DIV class="content">
<%
  if (flag){
    out.println("이미지를 등록 했습니다.");
  }else{
    out.println("이미지 등록에 실패했습니다.");
  }
  %>

</DIV>

  
  <DIV class='bottom'>
    <input type='button' value='계속등록' onclick="location.href='./createForm.jsp'">
    <input type='button' value='목록' onclick="ilist()">
  </DIV>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 