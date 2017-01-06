<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<jsp:useBean id="dto" class="team.TeamDTO"/>
<%
	String upDir = application.getRealPath("/team/storage");
	String tempDir = application.getRealPath("/team/temp");
	
	UploadSave upload = new UploadSave(request, -1,-1, tempDir);
	
	//form 의 값 가져온다
	dto.setName(UploadSave.encode(upload.getParameter("name")));
	dto.setGender(UploadSave.encode(upload.getParameter("gender")));
	dto.setPhone(upload.getParameter("phone"));
	dto.setZipcode(upload.getParameter("zipcode"));
	dto.setAddress1(UploadSave.encode(upload.getParameter("address1")));
	dto.setAddress2(UploadSave.encode(upload.getParameter("address2")));
	dto.setHobby(UploadSave.encode(upload.getParameter("hobby")));
	dto.setSkill(upload.getParameterValues("skill"));
	
	FileItem fileItem = upload.getFileItem("filename");
	int size = (int)fileItem.getSize();
	String filename = null;
	if(size > 0){
		filename = UploadSave.saveFile(fileItem, upDir);
	}else{
		filename = "member.jpg";
	}

	dto.setFilename(filename);
	boolean flag = tdao.create(dto);


%>


<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<style type="text/css"> 
*{ 
  font-family: gulim; 
  font-size: 24px; 
} 
</style> 
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<body>
<jsp:include page="/menu/top.jsp"/>
<div class="content">
<%
if(flag){
  out.println("팀 정보를 등록했습니다");
}else{
  out.println("팀 정보 등록에 실패했습니다");
}
%>
<br>
</div>
<div class="bottom">
<input type='button' value='계속 등록' onclick="location.href='./createForm.html'">
<input type='button' value='목록' onclick="location.href='./list.jsp'">
</div>
<jsp:include page="/menu/bottom.jsp"/>
</body> 
</html> 


