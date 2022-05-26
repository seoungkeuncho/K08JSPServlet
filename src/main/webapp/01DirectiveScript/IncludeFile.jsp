<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--
	포함되는 페이지를 만들때에도 반드시 page지시어는 있어야한다.
	page 지시어가 없는 Jsp파일은 오류가 발생한다.
--%>
<%
	LocalDate today = LocalDate.now(); //오늘날짜
	LocalDateTime tomorrow = LocalDateTime.now().plusDays(1);//내일날짜
%>
