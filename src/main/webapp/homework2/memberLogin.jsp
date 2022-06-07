<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.user_input{border:1px solid rgb(75, 75, 75);width:320px;height:27px;padding:10px;font-size:18px;}
input[type=image]{margin-top: 2px;}

#span {
display: table;
margin: 0 auto;
}

</style>
</head>
<body>


<span style="color: red; font-size: 1.5em;" id="span">
	<%= request.getAttribute("LoginErrMsg") == null ? "": request.getAttribute("LoginErrMsg") %>
</span>

<%
if(session.getAttribute("UserId")==null){
	//session영역에 저장된 속성값이 없다면 로그아웃 상태이다. 즉, 로그인 폼이 화면에 출력되어야 한다.

%>

<script>
//로그인 폼의 입력값을 검증하기 위한 함수로 빈값인지를 확인한다. 
function loginValdidate(form){
	//입력값이 공백인지 확인 후 경고창, 포커스이동, 폼값전송 중단처리를 한다. 
	if(!form.userid.value){
		alert("아이디를 입력하세요");
		form.userid.focus();
		return false;
	}
	if(form.passwd.value==""){
		alert("패스워드를 입력하세요");
		form.passwd.focus();
		return false;
	}
}
</script>

<fieldset>
    <table border="0" cellpadding="40" cellspacing="0" width="100%">
        <tr>
            <td align="center" valign="middle">
                <table border="0" cellpadding="0" cellspacing="0" width="470">
                    <tr>
                        <td align="center"><img src="./images/login_logo.gif" /></td>
                    </tr>
                </table>
                <form name="loginFrm" action="loginProcess.jsp" method="post" onsubmit="return loginValdidate(this);">
                <table width="470" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="350">
                            <input type="text" name="userid" placeholder="아이디" class="user_input" />
                        </td>
                        <td width="120" rowspan="3" align="right">
                            <input type="image" src="./images/login_bt.gif" />
                        </td>
                    </tr>
                    <tr height="5">
                        <td></td>
                    </tr>
                    <tr>
                        <td>
                            <input type="password" name="passwd" placeholder="****" class="user_input" />
                        </td>
                    </tr>
                </table>
                <div style="margin-top:15px;"></div>
                <div style="margin-top:15px;"></div>
                <table width="470" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td align="left">
                            <a href="#" onClick=""><img src="./images/login_member.gif" alt="아직도 회원이 아니세요?" /></a>
                        </td>
                        <td align="right">
                            <a href="#" onClick=""><img src="./images/login_idpw.gif" alt="아이디/비밀번호를 잊어버리셨어요?" /></a>
                        </td>
                    </tr>
                </table>
                </form>
<%
} else {
	//session영역에 저장된 속성값이 있다면 로그인된 상태이므로 회원정보 및 로그아웃 버튼을 화면에 출력한다.
%>
<%= session.getAttribute("UserName") %> 회원님, 로그인하셨습니다.
<a href="logout.jsp">[로그아웃]</a>
<%
}
%>
                <div style="margin-top:30px;"></div>
            </td>
        </tr>
    </table>
</fieldset>
</body>
</html>
