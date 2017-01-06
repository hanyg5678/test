<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/ssi/ssi.jsp" %> 
<jsp:useBean id="dto" class="member.MemberDTO"/>
<% 
		String upDir = "/member/storage";
		String tempDir = "/member/temp";
		
		upDir = application.getRealPath(upDir);
		tempDir = application.getRealPath(tempDir);
		
		UploadSave upload = new UploadSave(request, -1, -1, tempDir);
		//form의 입력값을 밥는다.
		dto.setId(UploadSave.encode(upload.getParameter("id")));
		
		dto.setEmail(upload.getParameter("email"));
		
		//form의 선택한 파일 받기
	
		String id = dto.getId();
		String email = dto.getEmail();
		String str = "";
		if(dao.duplicateId(id)){
			str="중복된 ID";
		}else if(dao.duplicateEmail(email)){
			str="중복된 Email";
		}else{
			request.setAttribute("upload", upload);	
		
		%>
		<jsp:forward page="/member/createProc.jsp"/>
<%
	return;
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
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 
<DIV class="title">아이디 및 이메일 중복</DIV>
 <DIV class="content">
 
 <%=str %>
 
 </DIV>

  
  <DIV class='bottom'>
    <input type='button' value='다시시도' onclick="history.back()">
  </DIV>

 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 