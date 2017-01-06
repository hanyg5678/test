<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<%
int no = Integer.parseInt(request.getParameter("no"));
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
<script type="text/javascript">
function input(f){

if(f.phone.value==""){
alert("전화번호를 입력하시오");
f.phone.focus();
return false;
}
if(f.zipcode.value==""){
alert("우편번호를 입력하시오");
f.zipcode.focus();
return false;
}
if(f.address1.value==""){
alert("주소를 입력하시오");
f.address1.focus();
return false;
}
if(f.address2.value==""){
alert("상세주소를 입력하시오");
f.address2.focus();
return false;
}


}

</script>
</head> 
<body> 
<jsp:include page="/menu/top.jsp"/>
<div class="title">주소 정보 입력</div>
<br>
<br>
<form name="frm"
  	  action="updateProc.jsp" 
  	  method="POST"
  	  onsubmit="return input(this)">
   <input type='hidden' name='no' value='<%=no %>'>
     <input type='hidden' name='col' size='30' value='<%=request.getParameter("col")%>'>
	  <input type='hidden' name='word' size='30' value='<%=request.getParameter("word")%>'>
 	   <input type='hidden' name='nowPage' size='30' value='<%=request.getParameter("nowPage")%>'>
<table>
<tr>
<th>이름</th>
<td><%=dto.getName()%></td>
</tr>

<tr>
<th>전화번호</th>
<td><input type="text" name="phone" value="<%=dto.getPhone()%>"></td>
</tr>

<tr>
<th>우편번호</th>
<td>
<input type="text" name="zipcode" size="8" 
   maxlength="6" id="sample6_postcode" placeholder="우편번호"
   value="<%=dto.getZipcode()%>">
<input type="button" onclick="sample6_execDaumPostcode()" 
   value="우편번호 검색"></td>
</tr>

<tr>
<th>주소</th>
<td>
<input type="text" name="address1" size="45"
   id="sample6_address" placeholder="주소"
   value="<%=dto.getAddress1()%>">
</td>
</tr>

<tr>
<th>상세주소</th>
<td>
<input type="text" name="address2" size="45"
   id="sample6_address2" placeholder="상세주소"
   value="<%=dto.getAddress2()%>">
</td>
</tr>
<tr>
<td colspan="2">
<input type="submit" name="수정" value="수정">
<input type="reset" name="다시입력">
</td>
</tr>

</table>

</form>
<jsp:include page="/menu/bottom.jsp"/>
</body> 
</html> 
