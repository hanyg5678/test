<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<%
	String col = Utility.checkNull(request.getParameter("col")); 
	String word = Utility.checkNull(request.getParameter("word")); 
	
	 //plz
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

	int total = adao.total(col, word);

	List<AddressDTO> list = adao.list(map);
	Iterator<AddressDTO> iter = list.iterator();
	
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
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
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

function del(no){
	if(confirm("삭제 하시겠습니까?")){
	var url = "deleteProc.jsp";
	url += "?no="+no;
	url += "&col=<%=col%>";
	url += "&word=<%=word%>";
	url += "&nowPage=<%=nowPage%>";
	location.href=url;
}
}
</script>  
</head> 
<body> 
<jsp:include page="/menu/top.jsp"/>
<div class="title">주소등록자 목록</div>


 <DIV class="search"> 
  <FORM name="frm" method='post' action="./list.jsp"> 
  <SELECT name='col'> <!-- 검색할 컬럼 -->
    <OPTION value='name' <% if (col.equals("name") ) out.print("selected='selected'"); %>>성     명</OPTION> 
    <OPTION value='phone' <% if (col.equals("phone") ) out.print("selected='selected'"); %>>전화 번호</OPTION> 
    <OPTION value='zipcode' <% if (col.equals("zipcode") ) out.print("selected='selected'"); %>>우편 번호</OPTION> 
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
<th>우편번호</th>
<th>등록날짜</th>
<th>비고</th>
</tr>
<%
if(list.size()== 0){
%>
<tr>
<td colspan="5">등록된 주소가 없습니다</td>
</tr>
<%} else{
		while(iter.hasNext()){
			AddressDTO dto = iter.next();
%>
<tr>	
<td><%=dto.getNo()%></td>
<td>
<a href="javascript:read('<%=dto.getNo()%>')"><%=dto.getName()%></a></td>
<td><%=dto.getPhone()%></td>
<td><%=dto.getZipcode()%></td>
<td><%=dto.getWdate()%></td>
<td>
<a href="javascript:update('<%=dto.getNo()%>')">수정</a>
      /
<a href="javascript:del('<%=dto.getNo()%>')">삭제</a>
</td>
</tr>

<%
		}//while end
	}//if end
%>
</table>
 <DIV class="bottom">
    <%=Utility.paging3(total, nowPage, recordPerPage, col, word) %>
	<input type="button" value="등록" onclick="location.href='./createForm.jsp'">
  </DIV>

<jsp:include page="/menu/bottom.jsp"/>
</body> 
</html>
