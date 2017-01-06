<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<jsp:useBean id="dto" class="bbs.BbsDTO"/>
<jsp:setProperty property="*" name="dto"/>
<%

	
	
	//--업로드용 변수 선언(폴더명)
		String upDir = "/bbs/storage";
		String tempDir = "/bbs/temp";
		//절대경로
		upDir = application.getRealPath(upDir);
		tempDir = application.getRealPath(tempDir);
		
		UploadSave upload = new UploadSave(request,-1,-1, tempDir);
		String col = upload.getParameter("col");
		String word = UploadSave.encode(upload.getParameter("word"));
		String nowPage = upload.getParameter("nowPage");
		String oldfile = UploadSave.encode(upload.getParameter("oldfile"));
		
		dto.setBbsno(Integer.parseInt(upload.getParameter("bbsno")));
		dto.setWname(UploadSave.encode(upload.getParameter("wname")));
		dto.setTitle(UploadSave.encode(upload.getParameter("title")));
		dto.setContent(UploadSave.encode(upload.getParameter("content")));
		dto.setPasswd(UploadSave.encode(upload.getParameter("passwd")));

		FileItem fileitem = upload.getFileItem("filename");
		int filesize = (int)fileitem.getSize(); 
		String filename = null;

		if(filesize>0){//새로운 파일을 업로드 했다.
			Utility.deleteFile(oldfile, upDir);//기존파일을 삭제
			filename = UploadSave.saveFile(fileitem, upDir);
		}
		dto.setFilename(filename);
		dto.setFilesize(filesize);
		
		Map map = new HashMap();
		map.put("bbsno", dto.getBbsno());
		map.put("passwd", dto.getPasswd());
	
		boolean pflag = bdao.passCheck(map);
		boolean flag = false;
		if(pflag){
			flag = bdao.update(dto);
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
<script type="text/javascript">
function read(bbsno){
	//alert(no);
	var url = "read.jsp";
	url += "?bbsno="+bbsno;
	url += "&col=<%=col %>";
    url += "&word=<%=word %>";
    url += "&nowPage=<%=nowPage%>";
	location.href=url;
	}
</script>
<script type="text/javascript">
function blist(){
	var url = "list.jsp";
	url += "?col=<%=col %>";
    url += "&word=<%=word %>";
    url += "&nowPage=<%=nowPage%>";
	location.href=url;
}
</script>
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<DIV class='title'>수정처리 결과</DIV>
 
<DIV class='content'>
<% 
	if(pflag==true && flag == true){
		bdao.update(dto);
%>
</DIV>
   글을 변경했습니다.<br><br>  
    <DIV class='bottom'>
      <input type='button' value='변경 확인' onclick="read(<%=dto.getBbsno() %>)">
      <input type='button' value='목록' onclick="blist()">
    </DIV>
    
  <%
  }
	if(pflag == true && flag == false){
  %>
    수정 실패<br>
    <DIV class='bottom'>
      <input type='button' value='다시 시도' onclick="history.back();">       
      <input type='button' value='목록' onclick="blist()">
    </DIV>
 
 <%
  }
	if(pflag == false){
  %>
    패스워드가 일치하지 않습니다.<br>
    <DIV class='bottom'>
      <input type='button' value='다시 시도' onclick="history.back();">       
      <input type='button' value='목록' onclick="blist()">
    </DIV>
 
  <%
  }
  %>
  
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 