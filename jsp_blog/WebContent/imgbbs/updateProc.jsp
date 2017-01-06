<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp"%>
<jsp:useBean id="dto" class="imgbbs.ImgbbsDTO"/>

<%
	  String upDir = "/imgbbs/storage";
	  String tempDir ="/imgbbs/temp";
	  
	  upDir = application.getRealPath(upDir);
	  tempDir = application.getRealPath(tempDir);
	
	
	  UploadSave upload = new UploadSave(request,-1,-1,tempDir);
		//패스워드 검증
		//수정처리
	  String col = upload.getParameter("col");
	  String word = UploadSave.encode(upload.getParameter("word")); 
	  String nowPage = upload.getParameter("nowPage");
	  String oldfile = UploadSave.encode(upload.getParameter("oldfile"));
	  
	  dto.setNo(Integer.parseInt(upload.getParameter("no")));
	  dto.setName(UploadSave.encode(upload.getParameter("name")));
	  dto.setTitle(UploadSave.encode(upload.getParameter("title")));
	  dto.setPasswd(UploadSave.encode(upload.getParameter("passwd")));
	  dto.setContent(UploadSave.encode(upload.getParameter("content")));
	  
	  FileItem fileItem = upload.getFileItem("filename");
	  int filesize = (int)fileItem.getSize();
	  String filename = null;
	  if(filesize>0){//새로운 파일을 업로드 했음
	    UploadSave.deleteFile(upDir, oldfile);
	    filename = UploadSave.saveFile(fileItem, upDir);
	  }
	
	  dto.setFilename(filename);
	  
	  Map map = new HashMap();
	  map.put("no",dto.getNo());
	  map.put("passwd",dto.getPasswd());
	  boolean pflag = idao.passCheck(map);
	  
	  boolean flag = false;
	  if(pflag){
	    flag = idao.update(dto);
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
function ilist(){
  var url = "./list.jsp";
  url += "?col=<%=col%>";
  url += "&word=<%=word%>";
  url += "&nowPage=<%=nowPage%>";
  
  location.href = url;
}
function incheck(){ //f는 그냥 변수 그냥 다른걸로 써도됨
  if(flag==false){
    alert("내용만 변경할 수 없습니다.");
    f.content.focus()
    
  }
}

</script>
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 
<DIV class="title">처리 결과</DIV>
  <DIV class="content">
    <%
	  if(pflag==false){
	    out.print("패스워드가 일치하지 않습니다.");
	  }else if(flag){
	    out.print("글수정을 성공했습니다");
	  }else{
	    out.print("글수정을 실패 했습니다");
	  }
	%>

  </DIV>
  <% if(pflag==false){ %>

  <DIV class='bottom'>
    <input type='button' value='다시시도' onclick="history.back()"> 
    <input type='button' value='목록' onclick="ilist()">
  </DIV>

  <% }else{ %>
  
  <DIV class='bottom'>
    <input type='button' value='다시등록' onclick="location.href='createForm.jsp'"> 
    <input type='button' value='목록' onclick="ilist()">
    
  </DIV>

  <%} %>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 