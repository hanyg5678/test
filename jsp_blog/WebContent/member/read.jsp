<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<%
	String id = request.getParameter("id");
	String grade = (String)session.getAttribute("grade");
	
	if(id==null){	// 관리자가 아닐때
		id = (String)session.getAttribute("id");
	}
	MemberDTO dto =dao.read(id);


%> 
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<script type="text/javascript">

function update(){
	var url = "updateForm.jsp";
	url += "?id=<%=id%>";
	url += "&col=<%=request.getParameter("col") %>";
	url += "&word=<%=request.getParameter("word") %>";
	url += "&nowPage=<%=request.getParameter("nowPage") %>";

	location.href = url;
}

function updatePw(){
	var url = "updatePwForm.jsp";
	url += "?id=<%=id%>";

	location.href = url;
}

function updateFile(){
	var url = "updateFileForm.jsp";
	url += "?id=<%=id%>";
	url += "&oldfile=<%=dto.getFname()%>";

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
 
<DIV class="title"><%=dto.getMname() %> 의 회원 정보</DIV>
 <DIV class="content">
  <TABLE>
  <TR>
  <TD colspan="2">
  <img src="./storage/<%=dto.getFname() %>" >
  </TD>
  </TR>
    <TR>
      <TH>ID</TH>
      <TD><%=dto.getId() %></TD>
    </TR>
    <TR>
      <TH>이름</TH>
      <TD><%=dto.getMname() %></TD>
    </TR>
    <TR>
      <TH>전화번호</TH>
      <TD><%=dto.getTel() %></TD>
    </TR>
    <TR>
      <TH>Email</TH>
      <TD><%=dto.getEmail() %></TD>
    </TR>
    <TR>
      <TH>우편번호</TH>
      <TD><%=dto.getZipcode()%></TD>
    </TR>
    <TR>
      <TH>주소</TH>
      <TD>
      		<%=dto.getAddress1() %>
      		<%=Utility.checkNull(dto.getAddress2()) %>
      </TD>
    </TR>
   
    <TR>
      <TH>직업</TH>
      <TD>
       		직업 코드 : <%=dto.getJob() %>
      		(<%=Utility.getCodeValue(dto.getJob()) %>)
      </TD>
    </TR>
    <TR>
      <TH>가입날짜</TH>
      <TD><%=dto.getMdate() %></TD>
    </TR>
  
  </TABLE>
 </DIV>
  
  <DIV class='bottom'>
    <input type='button' value='정보수정' onclick="update()">
    <%if(id!=null && grade.equals("A")) { %>
    <input type='button' value='회원목록' onclick="mlist()">
    <% } else { %>
    <input type='button' value='사진수정' onclick="updateFile()">
    <input type='button' value='패스워드 수정' onclick="updatePw()">
  	 <input type='button' value='다운로드' 
  	 onclick="location.href='<%=root %>/download?dir=/member/storage&filename=<%=dto.getFname()%>'">
  	 <% } %> 
  </DIV>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 