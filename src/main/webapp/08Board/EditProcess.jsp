<%@page import="utils.JSFunction"%>
<%@page import="model1.board.BoardDAO"%>
<%@page import="model1.board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 글쓰기 처리전 로그인 되었는지 확인한다. 글쓰기 페이지에 매우 오랜시간 작업없이
머물렀을 경우 session은 끊어질수 있다. -->
<%@ include file="./IsLoggedIn.jsp"%> 
<%
//폼값 받기
String num = request.getParameter("num");
String title = request.getParameter("title");
String content = request.getParameter("content");

//사용자가 입력한 폼값을 저장하기 위해 DTO객체를 생성한다.
BoardDTO dto = new BoardDTO();

//DTO에 데이터를 저장한다.
dto.setNum(num);
dto.setTitle(title);
dto.setContent(content);

//DAO객체 생성 및 게시물 수정을 위한 메서드 호출 
BoardDAO dao = new BoardDAO(application);
int affected = dao.updateEdit(dto);
dao.close();

if(affected == 1 ){
	//수정이 정상적으로 처된 경우에는 1이 반환되고, 상세보기로 이동한다.
	response.sendRedirect("View.jsp?num="+ dto.getNum());
}else{
	//실패한 경우에는 수정 페이지로 이동하기 위해 뒤로 이동한다.
	JSFunction.alertBack("수정에 실패하였습니다.", out);
}
%>