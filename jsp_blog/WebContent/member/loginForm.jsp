<%@ page contentType="text/html; charset=UTF-8" %> 
<% request.setCharacterEncoding("utf-8"); 
	String root = request.getContextPath();
	
	String c_id = "";     // ID 저장 여부를 저장하는 변수, Y
	String c_id_val = ""; // ID 값
	 
	Cookie[] cookies = request.getCookies(); 
	Cookie cookie=null; 
	 
	if (cookies != null){ 
	 for (int i = 0; i < cookies.length; i++) { 
	   cookie = cookies[i]; 
	 
	   if (cookie.getName().equals("c_id")){ 
	     c_id = cookie.getValue();     // Y 
	   }else if(cookie.getName().equals("c_id_val")){ 
	     c_id_val = cookie.getValue(); // user1... 
	   } 
	 } 
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
</style> 
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 
<DIV class="title">Log In</DIV>
 
<FORM name='frm' method='POST' action='<%=root %>/member/loginProc.jsp'>
  <TABLE>
    <TR>
      <TH>I D</TH>
      <TD>
      <input type="text" name="id" size="20" value='<%=c_id_val %>'>
       <% 
       if (c_id.equals("Y")){  // id 저장 상태라면 
       %>   
         <label><input type='checkbox' name='c_id' value='Y' checked='checked'> ID 저장 </label>
       <% 
       }else{ %> 
         <label><input type='checkbox' name='c_id' value='Y' > ID 저장 </label>
       <% 
       } 
       %> 
      </TD>
    </TR>
    <TR>
      <TH>Password</TH>
       <TD><input type="password" name="passwd" size="20"></TD>
    </TR>
  </TABLE>
  
  <DIV class='bottom'>
    <input type='submit' value='로그인' class="button" >
    <input type='button' value='회원가입' class="button" onclick="location.href='agreement.jsp'">
  </DIV>
</FORM>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 