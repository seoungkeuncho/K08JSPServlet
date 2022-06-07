<%@page import="utils.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 
	out태그
	-영역에 저장된 변수를 출력할때 사용한다.
	-escapeXml속성이 true이면 HTML태그가 그대로 출력된다. innerText()와 동일하다.
	 -->
	<!-- 변수선언. <i>태그를 포함한 문자열  -->
	<c:set var="iTag">
		i태그는 <i>기울임</i>을 표현합니다.
	</c:set>
	
	<!-- escapeXml 속성은 true가 디폴트값이다 .즉, HTML태그가 그대로 출력된다. -->
	<h4>기본 사용</h4>
	<c:out value="${iTag }" escapeXml="true"/>
	
	<!-- false가 되면 HTML태그가 적용되어 출력된다. innerHTML()과 동일하다. -->
	<h4>escapeXml 속성</h4>
	<c:out value="${iTag }" escapeXml="false"/>
	
	<!-- 최초 실행시에는 파라미터가 없은 상태이므로 default값이 출력된다. -->
	<h4>default 속성</h4>
	<c:out value="${param.name }" default="이름 없음"/>
	<!-- value속성이 null일때만 default값이 출력되고, 빈값인 경우에는 출력되지
	않는다. -->
	<c:out value="" default="빈 문자열도 값입니다."/>
	
	<!-- 
	최초실행시 js라는 파라미터가 없은 상태이므로 default로 지정된 EL이 실행된다.
	EL은 Javascipt실행을 위해 제작한 JSFunction클래스의 alertMsg()메서드를
	호출하고 있다 <script>를 포함한 문자열이 HTML문서에 출력되면 JS함수가
	실행되므로 escapeXml속성을 false로 지정하면된다.
	 -->
	<h4>default속성을 활용하여 Javascript함수 실행하기</h4>
	<c:out value="${param.js}" default="${JSFunction.alertMsg('하이룽~',out) }"
		escapeXml="false"/>
	
	
</body>
</html>