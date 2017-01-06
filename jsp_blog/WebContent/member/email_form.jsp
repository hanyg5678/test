<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
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
<!-- *********************************************** -->
 
<DIV class="title">E-mail 중복확인</DIV>
<FORM name='frm' method='POST' action='./email_proc.jsp'>
 <DIV class="content">
Email 을 입력해주세요<br><br>
  <TABLE>
    <TR>
      <TH>E-mail</TH>
      <TD>
      <input type="text" name="email" size="20">
      </TD>
    </TR>
  </TABLE>
  
 </DIV>
  <DIV class='bottom'>
    <input type='submit' value='중복확인'>
    <input type='button' value='취소' onclick="window.close()">
  </DIV>
</FORM>
 
 
<!-- *********************************************** -->
</body>
<!-- *********************************************** -->
</html> 