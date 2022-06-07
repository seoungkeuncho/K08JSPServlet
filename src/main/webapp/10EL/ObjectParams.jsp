<%@page import="common.Person"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
//세가지 객체를 reqeust영역에 저장한다.
request.setAttribute("personObj", new Person("홍길동",33));
request.setAttribute("strinObj", "나는 문자열");
request.setAttribute("integerObj", new Integer(99));
%>
<!-- 액션 태그를 통해 포워드한다. -->
<!-- 두개의 정수를 파라미터로 전달한다.  -->
<jsp:forward page="ObjectResult.jsp">
	<jsp:param value="10" name="firstNum"/>
	<jsp:param value="20" name="secoundNum"/>
	
</jsp:forward>
<!-- 액션태그 사이에는 HTML주석을 사용할 수 없다. 에러가 발생한다. -->
</body>
</html>