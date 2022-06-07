<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>MVC 패턴으로 회원 인증하기</h2>
	<p>
		<!-- 서블릿(컨트롤러)에서 request영역에 저장된 속성값 출력 -->
		<strong>${authMessage }</strong>
		<br>
		<!-- 요청명은 web.xml에서 매핑 설정 -->
		<a href = "./MemberAuth.mvc?id=nakja&pass=1234">회원인증(관리자)</a>
		&nbsp;&nbsp;
		<a href = "./MemberAuth.mvc?id=musthave&pass=1234">회원인증(회원)</a>
		&nbsp;&nbsp;
		<a href = "./MemberAuth.mvc?id=stranger&pass=1234">회원인증(비회원)</a>
		
	</p>
</body>
</html>