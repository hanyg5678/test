<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<%
int no = Integer.parseInt(request.getParameter("no"));
String col = request.getParameter("col");
String word = request.getParameter("word");
String nowPage = request.getParameter("nowPage");
AddressDTO dto = adao.read(no);


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
function create(){
	var url = "createForm.jsp";
	location.href=url;
}
function alist(){
	var url = "list.jsp";
	url += "?col=<%=col %>";
	url += "&word=<%=word %>";
	url += "&nowPage=<%=nowPage%>";
	location.href=url;
}
</script> 
</head> 
<body> 
<jsp:include page="/menu/top.jsp"/>
<div class="title">조회</div>
<div class="content">
<table>

<tr>
<th>번호</th>
<td><%=no %></td>
</tr>
<tr>
<th>이름</th>
<td><%=dto.getName() %></td>
</tr>
<tr>
<th>전화번호</th>
<td><%=dto.getPhone()%></td>
</tr>
<tr>
<th>우편번호</th>
<td><%=dto.getZipcode()%></td>
</tr>
<tr>
<th>주소</th>
<td><%=dto.getAddress1()%></td>
</tr>
<tr>
<th>상세주소</th>
<td><%=dto.getAddress2()%></td>
</tr>
<tr>
<th>가입일자</th>
<td><%=dto.getWdate()%></td>
</tr>
<tr>
<td colspan="2">
<input type="button" value="생성" onclick="create()">
<input type="button" value="목록" onclick="alist()">
</td>

</tr>
</table>
</div>
<jsp:include page="/menu/bottom.jsp"/>
</body> 
</html> 

