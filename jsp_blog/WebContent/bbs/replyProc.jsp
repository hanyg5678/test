<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<jsp:useBean id="dto" class="bbs.BbsDTO"/>
<%
	String upDir = application.getRealPath("/bbs/storage");
	String tempDir = application.getRealPath("/bbs/temp");
	
	UploadSave upload = new UploadSave(request, -1, -1, tempDir);	

	//paging, search 를 위한값
	String col = upload.getParameter("col");
	String word = UploadSave.encode(upload.getParameter("word"));
	String nowPage = upload.getParameter("nowPage");
	//답변을 위한 부모의 값
	dto.setGrpno(Integer.parseInt(upload.getParameter("grpno")));
	dto.setIndent(Integer.parseInt(upload.getParameter("indent")));
	dto.setAnsnum(Integer.parseInt(upload.getParameter("ansnum")));
	//부모글 삭제를 제한하기위해서
	dto.setBbsno(Integer.parseInt(upload.getParameter("bbsno")));
	//form 의 입력된값 가져오기
	dto.setWname(UploadSave.encode(upload.getParameter("wname")));
	dto.setTitle(UploadSave.encode(upload.getParameter("title")));
	dto.setContent(UploadSave.encode(upload.getParameter("content")));
	dto.setPasswd(UploadSave.encode(upload.getParameter("passwd")));
	
	FileItem fileItem = upload.getFileItem("filename");
	int filesize = (int)fileItem.getSize();
	String filename = null;
	if(filesize>0){
		filename = UploadSave.saveFile(fileItem, upDir);
	}
	dto.setFilename(filename);
	dto.setFilesize(filesize);
	
	Map map = new HashMap();
	map.put("col", col);
	map.put("word", word);
	bdao.addAnsnum(dto.getGrpno(), dto.getAnsnum());
	boolean flag = bdao.reply(dto);


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
function blist() {
  var url = "list.jsp";
  	  url += "?col=<%=col %>";
      url += "&word=<%=word %>";
      url += "&nowPage=<%=nowPage %>";
  location.href=url;
}
</script> 
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 
<DIV class="title">답변 등록 처리</DIV>
<DIV class="content">
<%
  if(flag) {
    out.print("답변글이 등록되었습니다.");
  } else {
    out.print("답변글 등록이 실패했습니다.");
  }
%>
</DIV>

<div class="bottom">
<input type="button" value="계속 등록" onclick="location.href='./createForm.jsp'">
<input type="button" value="목록" onclick="blist()">
</div>
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 