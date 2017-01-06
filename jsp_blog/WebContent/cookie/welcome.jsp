<%@ page contentType="text/html; charset=UTF-8" %> 
<% 
	request.setCharacterEncoding("utf-8"); 
	String root = request.getContextPath();
	//client안에 있는 모든 쿠키를 전부 읽어 옵니다. 
	Cookie[] cookies = request.getCookies(); 
	Cookie cookie = null; 
	 
	String sw = null; 
	 
	if (cookies != null){
	  for (int i = 0; i < cookies.length; i++) { 
	    //쿠키 변수를 각각 추출합니다. 
	    cookie = cookies[i]; 
	 
	    if (cookie.getName().equals("sw")){ 
	      sw = cookie.getValue(); 
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
 
<DIV class="title">접속 환영</DIV>
 <DIV class='content'> 
<% 
if (sw != null){ // Cookie 변수가 있다면  
  out.println ("재 접속을 환영합니다." + "<br>"); 
     
}else{ 
  out.println("처음 접속 하셨군요~~~" + "<br>");
  
  Cookie wcookie = null; 
 
  wcookie = new Cookie("sw", "1");     // 한글 저장시 에러  
  wcookie.setMaxAge(60);               // 60초
  
  response.addCookie(wcookie);         // 쿠키를 Client에 저장합니다. 
} 
%> 
 
  <br><br>
</DIV>
<div class="bottom">
  <A href='./welcome.jsp'>Server 접속</A>
</div> 
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 