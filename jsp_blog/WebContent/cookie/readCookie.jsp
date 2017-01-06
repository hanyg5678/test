<%@ page contentType="text/html; charset=UTF-8" %> 
<% request.setCharacterEncoding("utf-8"); 
	String root = request.getContextPath();
	//client안에 있는 모든 쿠키를 전부 읽어 옵니다. 
	Cookie[] cookies = request.getCookies(); 
	Cookie cookie = null; 
	 
	String name=null;  
	int kuk=0; 
	int eng=0; 
	 
	for (int i = 0; i < cookies.length; i++) { 
	  //쿠키 변수를 각각 추출합니다. 
	  cookie = cookies[i]; 
	 
	  if (cookie.getName().equals("name")){ 
	    name = cookie.getValue(); 
	  }else if (cookie.getName().equals("kuk")){ 
	    kuk = Integer.parseInt(cookie.getValue()); 
	  }else if (cookie.getName().equals("eng")){ 
	    eng = Integer.parseInt(cookie.getValue()); 
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
 
<DIV class="title">쿠키 읽어 오기(Cookie객체의 사용)</DIV>
 <DIV class='content'>
<% 
if (name != null){ // Cookie 변수가 있다면  
  out.println ("성명 : " + name + "<br>"); 
  out.println ("국어 : " + kuk + "<br>"); 
  out.println ("영어 : " + eng + "<br>"); 
  out.println ("총점 : " + (kuk+eng) + "<br>"); 
  out.println ("평균 : " + (kuk+eng)/2 + "<br>"); 
  out.println ("30초 후 쿠키는 인식이 되지 않습니다." + "<br>"); 
     
}else{ 
    out.println("쿠키를 읽어 들일수 없습니다." + "<br>"); 
} 
%> 
</DIV> 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 