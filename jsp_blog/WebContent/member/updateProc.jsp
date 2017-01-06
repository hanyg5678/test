<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<jsp:useBean id="dto" class="member.MemberDTO"/>
<jsp:setProperty property="*" name="dto"/>
<%
	boolean flag = dao.update(dto);
	String id = (String)session.getAttribute("id");
	String grade = (String)session.getAttribute("grade");
%> 
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<script type="text/javascript">
function read(){
	var url = "read.jsp";
	url+="?id=<%=dto.getId()%>";
	location.href = url;
}
function mlist(){
	var url = "list.jsp";
	location.href = url;
}
function mlist() {
	var url = "<%=root %>/admin/list.jsp";
	url += "?col=<%=request.getParameter("col") %>";
	url += "&word=<%=request.getParameter("word") %>";
	url += "&nowPage=<%=request.getParameter("nowPage") %>";

	location.href = url;
}
</script>
<style type="text/css"> 
*{ 
  font-family: gulim; 
  font-size: 20px; 
} 
</style> 
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 
<DIV class="title">정보 수정 처리</DIV>

 <DIV class="content">
 <%
	if(flag){
		out.print("정보수정을 성공했습니다");
	}else{
		out.print("정보수정을 실패했습니다");
	}
 
 
 %>
 </DIV>

  
  <DIV class='bottom'>
  <%if(id!=null && grade.equals("A")) { %>
    <input type='button' value='정보확인' onclick="mlist()">
    <% } else { %>
    <input type='button' value='정보확인' onclick="read()">
    <input type='button' value='다시시도' onclick="history.back()">
    <% } %>
  </DIV>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 