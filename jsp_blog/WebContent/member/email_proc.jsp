<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi.jsp"%>
<%
	String email = request.getParameter("email");
	boolean flag = dao.duplicateEmail(email);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
* {
	font-family: gulim;
	font-size: 20px;
}
</style>
<script type="text/javascript">
function use(){
	opener.frm.email.value='<%=email%>';
	window.close();
}
</script>
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
</head>
<!-- *********************************************** -->
<body>
	<!-- *********************************************** -->

	<DIV class="title">중복 확인</DIV>

	<DIV class='content'>
		입력된 Email:	<%=email %><br><br>

<%
  if (flag){
    out.println("중복되어 사용할 수 없습니다.<br><br>");
  }else{
    out.println("중복 아님, 사용 가능합니니다.<br><br>");
    out.println("<input type='button' value='사용' onclick='use()'>");
  }
  %>

	</DIV>

	<DIV class="bottom">
		<input type='button' value='다시시도'
			onclick="location.href='email_form.jsp'"> 
		<input	type='button' value='닫기' onclick="window.close()">
	</DIV>


	<!-- *********************************************** -->
</body>
<!-- *********************************************** -->
</html>
