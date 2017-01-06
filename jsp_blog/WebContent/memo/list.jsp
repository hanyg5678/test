<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<%

	String col = Utility.checkNull(request.getParameter("col")); 
	String word = Utility.checkNull(request.getParameter("word")); 
	int nowPage = 1;
	if(request.getParameter("nowPage")!=null){
	    nowPage = Integer.parseInt(request.getParameter("nowPage"));
	  }
	int recordPerPage = 5;

	int sno = ((nowPage-1)*recordPerPage)+1;
	int eno = nowPage*recordPerPage;
	
	Map map = new HashMap();
	map.put("col", col);
	map.put("word", word);
	map.put("sno", sno);
	map.put("eno", eno);
	int total = mdao.total(col, word);
			
	
	List<MemoDTO> list = mdao.list(map);
	Iterator<MemoDTO> iter = list.iterator();

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
  font-family: gulim; 
  font-size: 24px; 
} 
</style>
<script type="text/javascript">
function read(memono){
	//alert(memono);
	var url = "read.jsp";
	url += "?memono="+memono;
	url += "&col=<%=col%>";
	url += "&word=<%=word%>";
	url += "&nowPage=<%=nowPage%>";
	
	location.href=url;
}
</script> 
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<body> 
<jsp:include page="/menu/top.jsp"/>
<div class="title">
메모목록
</div>
 <DIV class="search"> 
  <FORM method='post' action="./list.jsp"> 
  <SELECT name='col'> <!-- 검색할 컬럼 -->
    <OPTION value='title' <% if (col.equals("title") ) out.print("selected='selected'"); %>>제 목</OPTION> 
    <OPTION value='content' <% if (col.equals("content") ) out.print("selected='selected'"); %>>내 용</OPTION> 
    <OPTION value='total'>전체출력</OPTION> 
  </SELECT> 
  <input type='text' name='word' value='<%=word %>'> <!-- 검색어 -->
  <input type='submit' value='검색'> 
  <input type='button' value='등록' onclick="location.href='./createForm.jsp'"> 
  </FORM> 
</DIV> 
<table>
<tr>
<th>번호</th>
<th>제목</th>
<th>날짜</th>
<th>조회수</th>
</tr>
<%
if(list.size() ==0){
%>

<tr>
	<td colspan='4'>등록된 메모가 없습니다.</td>
</tr>

<% }else{
    while(iter.hasNext()){
    	MemoDTO dto = iter.next();
    %>
    <tr>
      <td><%=dto.getMemono() %></td>
      <td><a href="javascript:read('<%=dto.getMemono()%>')"><%=dto.getTitle() %></a></td>
      <td><%=dto.getWdate() %></td>
      <td><%=dto.getViewcnt() %></td>
      
    </tr>
    
  <%
    } // for END
  } // if END
  %>
</table>


<div class="bottom">
<%=Utility.paging3(total, nowPage, recordPerPage, col, word) %>
<input type="button" value="등록" onclick="location.href='./createForm.jsp'">
</div>
<jsp:include page="/menu/bottom.jsp"/>
</body> 
</html>

