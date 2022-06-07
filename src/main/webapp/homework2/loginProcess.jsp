<%@page import="homework.MembershipDTO"%>
<%@page import="homework.MembershipDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
//로그인 페이지에서 사용자가 입력한 회원정보 받기
String userId = request.getParameter("userid");
String userPwd = request.getParameter("passwd");

//application 내장객체를 통해 web.xml에 입력된 DB접속정보를 읽어옴
String oracleDriver = application.getInitParameter("OracleDriver");
String oracleURL = application.getInitParameter("OracleURL");
String oracleId = application.getInitParameter("OracleId");
String oraclePwd = application.getInitParameter("OraclePwd");

//JDBC를 통해 오라클 접속
MembershipDAO dao = new MembershipDAO(oracleDriver, oracleURL, oracleId, oraclePwd);
//받아온 아이디, 패스워드를 매개변수로 메서드 호출, 일치하는 회원정보가 있는지 확인함.
MembershipDTO membershipDTO = dao.getMembershipDTO(userId, userPwd);
//DB작업이 끝나면 자원해제 
dao.close();

if(membershipDTO.getId() !=null){
	//회원인증(로그인)에 성공한 경우
	//세션영역에 아이디와 기타 정보를 저장한다. 
	session.setAttribute("UserId", membershipDTO.getId());
	session.setAttribute("UserName", membershipDTO.getName());
	
	//로그인 페이지로 이동한다.
	response.sendRedirect("memberLogin.jsp");
}
else{
	//인증에 실패한 경우
	//리퀘스트 영역에 실패 메세지를 저장한다. 
	request.setAttribute("LoginErrMsg", "로그인 오류입니다. 다시 시도해주세요");
	//로그인 페이지로 포워드(요청 전달)한다.
	request.getRequestDispatcher("memberLogin.jsp").forward(request, response);
}
%>


