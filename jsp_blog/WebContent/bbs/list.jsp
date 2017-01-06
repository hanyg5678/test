<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<% 

	String col = Utility.checkNull(request.getParameter("col")); 
	String word = Utility.checkNull(request.getParameter("word")); 
	
	//페이지 관련---------------
	int nowPage = 1;
	if(request.getParameter("nowPage")!=null){
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
	int recordPerPage = 5;//한페이지당 보여줄 레코드 갯수
	
	//DB 에서 가져올 순번
	int sno = ((nowPage-1)*recordPerPage)+1;
	int eno = nowPage * recordPerPage;
	
	
	
	Map map = new HashMap();
	map.put("col", col);
	map.put("word", word);
	map.put("sno", sno);
	map.put("eno", eno);
	
	int total = dao.total(col, word);
 
	List<BbsDTO> list = bdao.list(map);
	Iterator<BbsDTO> iter = list.iterator();

	if(col.equals("total")){
		word="";
	}
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
.search{
	width: 80%;
	text-align: center;
	margin: 2px auto;
}
</style> 
<script type="text/javascript">
function read(bbsno) {
  var url = "read.jsp";
  	  url += "?bbsno=" + bbsno;
      url += "&col=<%=col%>";
      url += "&word=<%=word%>";
      url += "&nowPage=<%=nowPage%>";
  
  location.href = url;
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
 <DIV class="search"> 
  <FORM method='post' action="./list.jsp"> 
  <SELECT name='col'> <!-- 검색할 컬럼 -->
    <OPTION value='wname' <% if (col.equals("wname") ) out.print("selected='selected'"); %>>성 명</OPTION> 
    <OPTION value='title' <% if (col.equals("title") ) out.print("selected='selected'"); %>>제 목</OPTION> 
    <OPTION value='content' <% if (col.equals("content") ) out.print("selected='selected'"); %>>내 용</OPTION> 
    <OPTION value='total'>전체출력</OPTION> 
  </SELECT> 
  <input type='text' name='word' value='<%=word %>'> <!-- 검색어 -->
  <input type='submit' value='검색' class="button_mini" > 
  <input type='button' value='등록' class="button_mini" onclick="location.href='./createForm.jsp'"> 
  </FORM> 
</DIV> 
 
 
<DIV class="title"> 게시판 목록 </DIV>
 

	<TABLE>
   <TR>
    <TH>번호</TH>
    <TH>제목</TH>
    <TH>성명</TH>
    <TH>조회수</TH>
    <TH>등록일</TH>
    <TH>파일명</TH>
    
  </TR>
  <% 
  	if (list.size() == 0){
  %>
    <TR>
      <TD colspan='8' align='center'>등록된 글이 없습니다.</TD>
    </TR>
  <%
  }else{
    for(int index=0; index <list.size(); index++){
      BbsDTO dto = list.get(index);
      
    %>
    <TR>
      <TD><%=dto.getBbsno() %></TD>
      <TD>
      <%
        for(int i = 0; i < dto.getIndent(); i++) {
          out.print("&nbsp;");
        }
      
        if(dto.getIndent() > 0) { 
         %>
       <img src="../menu/images/reply.JPG" style=" width:10px; height:10px;">
      <% } %>
       <a href="javascript:read('<%=dto.getBbsno() %>')"><%=dto.getTitle() %></a>
      <% if(Utility.compareDay(dto.getWdate().substring(0, 10))){ %>
      <img src="images/new.gif">
      <% } %>
      </TD>
      <TD><%=dto.getWname() %></TD>
      <TD><%=dto.getViewcnt() %></TD>
      <TD><%=dto.getWdate().substring(0, 10) %></TD>
      <TD>
      <%
      if(dto.getFilename()==null){
    	  out.print("파일 없음");
      }else{ %>
		  <a href="javascript:down('<%=dto.getFilename()%>')">
		  <span class='glyphicon glyphicon-file'></span>
		  </a>
      <%}
       
      %>
      
      </TD>
      
    </TR>
    
  <%
    } // for END
  } // if END
  %>   
  
  </TABLE>
  
  <DIV class='bottom'>
  	<%=Utility.paging3(total, nowPage, recordPerPage, col, word) %>
  </DIV>
 <DIV class='bottom'>
    <input type='button' value='등록' class="button" onclick="location.href='./createForm.jsp'">
    <input type='button' value='이전' class="button" onclick="location.href=history.back()">
 </DIV>
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 