<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/ssi/ssi.jsp" %>

<%
	int bbsno = Integer.parseInt(request.getParameter("bbsno"));
	String col = request.getParameter("col");
	String word = request.getParameter("word");
	String nowPage = request.getParameter("nowPage");
	
	int cnt = 0;
	/*조회수 증가*/
	bdao.upViewcnt(bbsno);
	BbsDTO dto = bdao.read(bbsno);
	String content = dto.getContent();
	
	content = content.replaceAll("\r\n", "<br>");

%>
 
<!DOCTYPE html> 
<html> 
<head> 
<meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<meta charset="UTF-8"> 
<title></title> 
<style type="text/css"> 
*{ 
  font-family: gulim; 
  font-size: 20px; 
} 
</style> 
<script type="text/javascript">
	function bcreate(){
		var url = "createForm.jsp";
		location.href=url;
	}
	
	function bupdate(){
		var url = "updateForm.jsp";
		url += "?bbsno=<%=bbsno %>";
		url += "&col=<%=col %>";
		url += "&word=<%=word %>";
		url += "&nowPage=<%=nowPage%>";
		location.href=url;
	}
	
	function bdelete(){
		var url = "deleteForm.jsp";
		url += "?bbsno=<%=bbsno %>";
		url += "&col=<%=col %>";
		url += "&word=<%=word %>";
		url += "&nowPage=<%=nowPage%>";
		url += "&oldfile=<%=dto.getFilename()%>";
		location.href=url;
	}
	function breply(){
		var url = "replyForm.jsp";
		url += "?bbsno=<%=bbsno %>";
		url += "&col=<%=col %>";
		url += "&word=<%=word %>";
		url += "&nowPage=<%=nowPage%>";
		location.href=url;
	}
	
	function blist(){
		var url = "list.jsp";
		url += "?col=<%=col %>";
		url += "&word=<%=word %>";
		url += "&nowPage=<%=nowPage%>";
		location.href=url;
	}
	
	function down(filename){
		var url = "<%=root%>/download";
		url += "?dir=/bbs/storage";
		url += "&filename="+filename;
		
		location.href = url;
		
	}
</script>
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 
<DIV class="title">조회</DIV>
 
  <TABLE style=" width: 60%; padding: 20px;">
  <TR>
    <TH>제목</TH>
    <TD><%=dto.getTitle() %></TD>
  </TR>
  <TR>
    <TH>내용</TH>
    <TD><%=content %></TD>
  </TR>
  <TR>
    <TH>성명</TH>
    <TD><%=dto.getWname() %></TD>
  </TR>
  
  <TR>
    <TH>조회수</TH>
    <TD><%=dto.getViewcnt() %></TD>
  </TR>
  <TR>
    <TH>등록일</TH>
    <TD><%=dto.getWdate().substring(0, 10) %></TD>
  </TR>
  <TR>
    <TH>파일</TH>
    <TD>
    <%if(dto.getFilename()==null) {
    		out.print("파일없음");
      }else{
    %>
      <%=dto.getFilename() %>(<%=dto.getFilesize()/1024 %>KB)
  	  <a href="javascript:down('<%=dto.getFilename()%>')">
		  <span class='glyphicon glyphicon-file'></span>
		  </a>
        <%} %>
    </TD>
  </TR>
  
</TABLE>
  
  <div class="bottom">
<input type="button" value="등록" onclick="bcreate()">
<input type="button" value="목록" onclick="blist()">
<input type="button" value="수정" onclick="bupdate()">
<input type="button" value="삭제" onclick="bdelete()">
<input type="button" value="답변" onclick="breply()">
</div>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 