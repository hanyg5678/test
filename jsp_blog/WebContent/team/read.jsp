<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<%
	int no = Integer.parseInt(request.getParameter("no"));
	String col = request.getParameter("col");
	String word = request.getParameter("word");
	String nowPage = request.getParameter("nowPage");
	TeamDTO dto = tdao.read(no);

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
<script type="text/javascript">
	function create(){
	var url = "createForm.jsp";
	location.href=url;
}
function tlist(){
	var url = "list.jsp";
	url += "?col=<%=col %>";
	url += "&word=<%=word %>";
	url += "&nowPage=<%=nowPage %>";
	location.href=url;
}
function imgUpdate(){
	var url = "updateFileForm.jsp";
	url += "?col=<%=col %>";
	url += "&word=<%=word %>";
	url += "&nowPage=<%=nowPage %>";
	url += "&no=<%=no %>";
	url += "&oldfile=<%=dto.getFilename() %>";
	location.href=url;
}
</script> 

</head> 
<body> 
<jsp:include page="/menu/top.jsp"/>
<div class="title">조회</div>
<table>
<tr>
	<td colspan="2" id="ftd">
	<img src='./storage/<%=dto.getFilename()%>'>
	</td>
</tr>
<tr>
	<th>이름</th>
	<td><%=dto.getName()%></td>
</tr>
<tr>
	<th>성별</th>
	<td><%=dto.getGender() %></td>
</tr>
<tr>
	<th>전화번호</th>
	<td><%=dto.getPhone()%></td>
</tr>
<tr>
	<th>주소</th>
	<td>
	<%=dto.getAddress1()%> <br>
	<%=dto.getAddress2()%> <br>
	우편번호 (<%=dto.getZipcode()%>)
	</td>
</tr>
<tr>
	<th>보유기술</th>
	<td><%=dto.getSkillstr()%></td>
</tr>
<tr>
	<th>취미</th>
	<td><%=dto.getHobby()%></td>
</tr>
<tr>
</table>
<div class="bottom">
<input type="button" value="생성" onclick="create()">
<input type="button" value="목록" onclick="tlist()">
<input type="button" value="사진변경" onclick="imgUpdate()">
<input type='button' value='다운로드' 
  	 onclick="location.href='<%=root %>/download?dir=/team/storage&filename=<%=dto.getFilename()%>'">
</div>
<jsp:include page="/menu/bottom.jsp"/>
</body> 
</html> 


