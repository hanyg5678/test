<%@ page contentType="text/html; charset=UTF-8" %> 
<% request.setCharacterEncoding("utf-8"); 
	String root = request.getContextPath();
%> 
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;

                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('sample6_address').value = fullAddr;

                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('sample6_address2').focus();
            }
        }).open();
    }
</script> 
<style type="text/css"> 
*{ 
  font-size: 20px; 
} 
</style>
<script type="text/javascript">
function inputCheck(f){
	if(f.id.value==""){
		alert("ID를 입력해주세요");
		f.id.focus();
		return false;
	}
	if(f.passwd.value==""){
		alert("Password를 입력해주세요");
		f.passwd.focus();
		return false;
	}
	if(f.repasswd.value==""){
		alert("Password 확인을 입력해주세요");
		f.repasswd.focus();
		return false;
	}
	if(f.passwd.value!=f.repasswd.value){
		alert("Password가 일치 하지 않습니다. 다시 입력해주세요 ");
		f.passwd.focus();
		return false;
	}
	if(f.mname.value==""){
		alert("이름을 입력해주세요");
		f.mname.focus();
		return false;
	}
	if(f.email.value==""){
		alert("E-mail을 입력해주세요");
		f.email.focus();
		return false;
	}
	if(f.job.value=="0"){
		alert("직업을 선택해주세요");
		f.job.focus();
		return false;
	}
	
}
function idCheck(id){
	
	if(id==""){
		alert("아이디를 입력해주세요");
		document.frm.id.focus();
	}else{
		var url = "id_proc.jsp"
		url += "?id="+id;
		var wr = window.open(url, "아이디 검색", "width=500, height=500");
		wr.moveTo((window.screen.width-500)/2, (window.screen.height-500)/2);
	}
}
function emailCheck(email){
	if(email==""){
		alert("이메일을 입력해주세요");
		document.frm.email.focus();
	}else{
			var url = "email_proc.jsp"
			url += "?email="+email;
			var wr = window.open(url, "이메일 검색", "width=500, height=500");
			wr.moveTo((window.screen.width-500)/2, (window.screen.height-500)/2);
		
	}
}
</script> 
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 
<DIV class="title">회원가입</DIV>
 
<FORM name='frm' 
	  method='POST' 
	  action='./prcreateProc.jsp'
	  enctype="multipart/form-data"
	  onsubmit="return inputCheck(this)">
  <TABLE>
    <TR>
      <TH>사진(이미지 파일만)</TH>
      <TD><input type="file" name="fname" ></TD>
	  <TD>사진은 JPG, PNG, GIF만 올려주세요</TD>      
    </TR>
    
    <TR>
      <TH>*아이디</TH>
      <TD>
      	<input type="text" name="id" size="15">
      	<input type="button" value="ID중복확인" 
      	       onclick="idCheck(document.frm.id.value)">
      </TD>
      <TD>아이디를 적어주세요.</TD>
    </TR>
    
    <TR>
      <TH>*패스워드</TH>
      <TD><input type="password" name="passwd" size="15"></TD>
      <TD> 패스워드를 적어주세요 </TD>
    </TR>
    <TR>
      <TH>*패스워드확인</TH>
      <TD><input type="password" name="repasswd" size="15"></TD>
      <TD> 패스워드를 확인합니다 </TD>
    </TR>
    <TR>
      <TH>*이름</TH>
      <TD><input type="text" name="mname" size="15"></TD>
      <TD> 실명을 적어주세요 </TD>
    </TR>
	<TR>
      <TH>전화번호</TH>
      <TD><input type="text" name="tel" size="15"></TD>
      <TD> 전화번호를 적어주세요 </TD>
      <TD>      </TD>
    </TR>    
    
    <TR>
      <TH>*E-mail</TH>
      <TD>
      <input type="text" name="email" size="25"> 
      <input type="button" value="Email중복확인" onclick="emailCheck(document.frm.email.value)">
      </TD>
      <TD> Email을 적어주세요 </TD>
    </TR>
    
    <TR>
      <TH>우편번호</TH>
      <TD>
      <input type="text" name="zipcode" size="7" maxlength="6" id="sample6_postcode" placeholder="우편번호">
	  <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 검색">
      </TD>
      <TD> 우편번호를 검색해주세요 </TD>
    </TR>

    <TR>
      <TH>주소</TH>
      <TD>
      <input type="text" name="address1" size="40" id="sample6_address" placeholder="주소"> 
      <input type="text" name="address2" size="40" id="sample6_address2" placeholder="상세주소">
      </TD>
      <TD> 주소를 입력해주세요 </TD>
    </TR>
    
    <TR>
      <TH>직업</TH>
      <TD>
      <SELECT name="job">
      	<OPTION 	value="0" SELECTED> 선택하세요	</OPTION>
      	<OPTION 	value="A01"	> 회사원				</OPTION>
      	<OPTION 	value="A02"	> 전산관련직  			</OPTION>
      	<OPTION 	value="A03"	> 연구전문직			</OPTION>
      	<OPTION 	value="A04"	> 각종학교학생 		</OPTION>
      	<OPTION 	value="A05"	> 일반자영업 			</OPTION>
      	<OPTION 	value="A06"	> 공무원 				</OPTION>
      	<OPTION 	value="A07"	> 의료인 				</OPTION>
      	<OPTION 	value="A08"	> 법조인 				</OPTION>
      	<OPTION 	value="A09"	> 종교/언론/예술인 	</OPTION>
      	<OPTION 	value="A10"	> 기타 				</OPTION>
      
      </SELECT>
      </TD>
      <TD> 직업을 선택해주세요 </TD>
    </TR>
    
  </TABLE>
  
  <DIV class='bottom'>
    <input type='submit' value='회원가입' class="button">
    <input type='button' value='취소' class="button" onclick="history.back()">
  </DIV>
</FORM>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 