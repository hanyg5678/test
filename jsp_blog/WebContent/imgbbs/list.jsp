<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/ssi/ssi.jsp" %>
<jsp:useBean id="dto" class="imgbbs.ImgbbsDTO"/>
<% 
//검색관련
	String col = Utility.checkNull(request.getParameter("col"));
	String word = Utility.checkNull(request.getParameter("word"));
	if(col.equals("total")){
		word="";
	}
	//페이징관련
	int nowPage = 1;
	int recordPerPage = 5;
	if(request.getParameter("nowPage")!=null){
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
	
	int sno = ((nowPage-1)*recordPerPage)+1;
	int eno = nowPage*recordPerPage;
	
	Map map = new HashMap();
	map.put("col", col);
	map.put("word", word);
	map.put("sno", sno);
	map.put("eno", eno);
	
	int total = idao.total(col, word);
	List<ImgbbsDTO> list = idao.list(map);
	Iterator<ImgbbsDTO> iter = list.iterator();
	
	String paging = Utility.paging3(total, nowPage, recordPerPage, col, word);
	
%> 
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<style type="text/css"> 
*{ 
  font-size: 20px; 
} 
</style>
<script type="text/javascript">
function read(no){
	var url ="<%=root%>/imgbbs/read.jsp";
	url += "?no="+no;
	url += "&nowPage=<%=nowPage%>";
	url += "&col=<%=col%>";
	url += "&word=<%=word%>";
	location.href = url;
}
function down(filename){
	  var url = "<%=root%>/download";
	  url += "?dir=/imgbbs/storage";
	  url += "&filename="+filename;
	  
	  location.href = url;
	  
	}
</script> 
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 
<DIV class="title">이미지 게시판</DIV>
<DIV class="search">
<FORM name='frm' method='POST' action='./list.jsp'>
<SELECT name="col">
	<option value="name" 
		<%if(col.equals("name")) out.print("selected='selected'"); %> >성명</option>
	<option value="title"
		<%if(col.equals("title")) out.print("selected='selected'"); %> >제목</option>
	<option value="content"
		<%if(col.equals("content")) out.print("selected='selected'"); %> >내용</option>
	<option value="total">전체출력</option>
</SELECT>
<input type="text" name="word" value='<%=word %>'>
<input type="submit" value="검색" class="button" >
<input type="button" value="등록" class="button" onclick="location.href='./createForm.jsp'"> 
</FORM>
 </DIV>
 <TABLE style="width: 80%;">
    <TR>
      <TH>번호</TH>
      <TH>제목</TH>
      <TH>글쓴이</TH>
      <TH>조회수</TH>
      <TH>등록일</TH>
      <TH>이미지</TH>
    </TR>
    <%if(list.size()==0){ %>
    <tr>
    <td colspan= "8">등록된 글이 없습니다.</td>
    </tr>
    <%}else{
      while(iter.hasNext()){
       dto = iter.next();
%>
      <tr>
      <td><%=dto.getNo() %></td>
      <td>
<%
	for(int i=0;i<dto.getIndent();i++){
    		out.print("&nbsp;&nbsp;");
	}%>
	<%	if(dto.getIndent()>0) {  %>
   			<img src="images/reply.JPG" style=" width:10px; height:10px;">
  		
<% } %>
  <a href="javascript:read('<%=dto.getNo() %>')">
  <%=dto.getTitle() %>
  </a>
  
   <% if(Utility.compareDay(dto.getWdate())){ %> 
    <img src="images/new.gif"> 
    <% } %> 
    </td>
    <td><%=dto.getName() %></td>
    <td><%=dto.getViewcnt() %></td>
    <td><%=dto.getWdate()%></td>   
    <td>
    <% if(dto.getFilename()==null){
      out.print("이미지 없음");
    }else{ %>
    <a href="javascript:down('<%=dto.getFilename()%>')">
      <span class='glyphicon glyphicon-download-alt'></span>
      </a>
      <% } %>   
    </td>  
</tr>
<%  
    }//while-end
  }//if-end
%>
</TABLE>

 <DIV class='bottom'>
   <%=Utility.paging3(total, nowPage, recordPerPage, col, word) %>
  </DIV>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 