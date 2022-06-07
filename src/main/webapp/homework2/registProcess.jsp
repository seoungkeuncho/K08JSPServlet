<%@page import="utils.JSFunction"%>
<%@page import="homework.MembershipDTO"%>
<%@page import="homework.MembershipDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
//글쓰기 처리 페이지 (p 283 참고)

//폼값 받기
String userId = request.getParameter("userid");
String userPass = request.getParameter("pass1");
String userName = request.getParameter("name");
String userGender = request.getParameter("gender");
String userBirthday = request.getParameter("birthday");
String userAdress = request.getParameter("zipcode") +request.getParameter("address1") + request.getParameter("address2");
String userEmail = request.getParameter("email1") + request.getParameter("email2");
String userMobileNumber = request.getParameter("mobile1") + request.getParameter("mobile2") + request.getParameter("mobile3");
String userTelNumber = request.getParameter("tel1") + request.getParameter("tel2") + request.getParameter("tel3");

//application 내장객체를 통해 web.xml에 입력된 DB접속정보를 읽어옴
String oracleDriver = application.getInitParameter("OracleDriver");
String oracleURL = application.getInitParameter("OracleURL");
String oracleId = application.getInitParameter("OracleId");
String oraclePwd = application.getInitParameter("OraclePwd");


//폼값을 DTO 객체에 저장
MembershipDTO dto = new MembershipDTO();
dto.setId(userId);
dto.setPass(userPass);
dto.setName(userName);
dto.setGender(userGender);
dto.setBirthday(userBirthday);
dto.setAddress(userAdress);
dto.setEmailnum(userEmail);
dto.setMobilenum(userMobileNumber);
dto.setTelnum(userTelNumber);

//DAO 객체를 통해 DB에 DTO 저장
MembershipDAO dao = new MembershipDAO (application);
int iResult = dao.insertMembershipDTO(dto);
dao.close();

//성공 or 실패?
if(iResult == 1){
	JSFunction.alertLocation("가입성공", "memberLogin.jsp", out);
}else {
	JSFunction.alertBack("회원가입하는데 실패하였습니다.", out);
}
%>

