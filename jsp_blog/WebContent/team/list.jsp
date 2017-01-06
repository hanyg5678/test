<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<%
	String col = Utility.checkNull(request.getParameter("col")); 
	String word = Utility.checkNull(request.getParameter("word")); 

	 int nowPage = 1;
	  if(request.getParameter("nowPage")!=null){
	    nowPage = Integer.parseInt(request.getParameter("nowPage"));
	  }
	  int recordPerPage = 3;//한페이지당 보여줄 레코드 갯수
	  
	  //DB 에서 가져올 순번
	  int sno = ((nowPage-1)*recordPerPage)+1;
	  int eno = nowPage * recordPerPage;
	  
	  
	  
	  Map map = new HashMap();
	  map.put("col", col);
	  map.put("word", word);
	  map.put("sno", sno);
	  map.put("eno", eno);
	  
	  int total = tdao.total(col, word);



	if(col.equals("total")){
	word="";
	}

	List<TeamDTO> list = tdao.list(map);
	Iterator<TeamDTO> iter = list.iterator();
	
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
img{
	width:250px;
	height:200px;
}
</style> 
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
<link href="css/style.css" rel="stylesheet">
<script type="text/javascript">
	function read(no){
  		//alert(no);
  		var url = "read.jsp";
  		url += "?no="+no;
  		url += "&col=<%=col%>";
  		url += "&word=<%=word%>";
  		url += "&nowPage=<%=nowPage%>";
  
 		 location.href=url;
	}

	function update(no){
			var url = "updateForm.jsp";
			url += "?no="+no;
			url += "&col=<%=col%>";
    		url += "&word=<%=word%>";
    		url += "&nowPage=<%=nowPage%>";
			location.href=url;
	}
	function del(no,oldfile){
			
		if(confirm("정말 삭제할꺼야?")){

			var url = "deleteProc.jsp";
			url += "?no="+no;
			url += "&col=<%=col%>";
    		url += "&word=<%=word%>";
    		url += "&nowPage=<%=nowPage%>";
    		url += "&oldfile="+oldfile;
			location.href=url;
	}
}
</script> 
</head> 
<body> 
<jsp:include page="/menu/top.jsp"/>
<div class="title">팀정보</div>

 <DIV class="search"> 
  <FORM name="frm" method='post' action="./list.jsp"> 
  <SELECT name='col'> <!-- 검색할 컬럼 -->
    <OPTION value='name' <% if (col.equals("name") ) out.print("selected='selected'"); %>>성     명</OPTION> 
    <OPTION value='phone' <% if (col.equals("phone") ) out.print("selected='selected'"); %>>전화 번호</OPTION> 
    <OPTION value='skill' <% if (col.equals("skill") ) out.print("selected='selected'"); %>>보유 기술</OPTION> 
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
<th>이름</th>
<th>전화번호</th>
<th>보유 기술</th>
<th>사진</th>
<th>수정/삭제</th>
</tr>
<%
if(list.size()==0){
%>

<tr>
  <td colspan='5'>등록된 메모가 없습니다.</td>
</tr>

<% }else{
    while(iter.hasNext()){
    	TeamDTO dto = iter.next();
    %>
    
    <tr>
      <td><%=dto.getNo()%></td>
      <td><a href="javascript:read('<%=dto.getNo() %>')"><%=dto.getName() %></a></td>
      <td><%=dto.getPhone()%></td>
      <td><%=dto.getSkillstr()%></td>
      <td><img src='./storage/<%=dto.getFilename() %>'></td>
      <td>
      <a href="javascript:update('<%=dto.getNo()%>')">수정</a>
      /
      <a href="javascript:del('<%=dto.getNo()%>','<%=dto.getFilename()%>')">
      	  
        삭제
      </a>
     
      </td>
    </tr>
    
  <%
    }// while END
  } // if END
  %>
</table>
<DIV class='bottom'>
    <%=Utility.paging3(total, nowPage, recordPerPage, col, word) %>
	<input type="button" value="등록" onclick="location.href='./createForm.html'">
  </DIV>
<jsp:include page="/menu/bottom.jsp"/>
</body> 
</html> 



