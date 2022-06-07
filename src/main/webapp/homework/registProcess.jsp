<%@page import="utils.JSFunction"%>
<%@page import="homework.MembershipDAO"%>
<%@page import="homework.MembershipDTO"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

//폼값 받기
String userid = request.getParameter("userid");
String pass1 = request.getParameter("pass1");
String name = request.getParameter("name");
String gender = request.getParameter("gender");
String birthday = request.getParameter("birthday");
String address = request.getParameter("zipcode")+ request.getParameter("address1")+
		request.getParameter("address2");
String emailnum = request.getParameter("email1")+ request.getParameter("email2");
String mobilenum = request.getParameter("mobile1")+ request.getParameter("mobile2")+
		request.getParameter("mobile3");
String telnum = request.getParameter("tel1")+ request.getParameter("tel2")+
		request.getParameter("tel3");

//application 내장객체를 통해 web.xml에 입력된 DB접속정보를 읽어옴
String oracleDriver = application.getInitParameter("OracleDriver");
String oracleURL = application.getInitParameter("OracleURL");
String oracleId = application.getInitParameter("OracleId");
String oraclePwd = application.getInitParameter("OraclePwd");
//폼값을 DTO 객체에 저장
MembershipDTO dto = new MembershipDTO();

dto.setId(userid);
dto.setPass(pass1);
dto.setName(name);
dto.setGender(gender);
dto.setBirthday(birthday);
dto.setAddress(address);
dto.setEmailnum(emailnum);
dto.setMobilenum(mobilenum);
dto.setTelnum(telnum);



//DAO 객체를 통해 DB에 DTO저장
MembershipDAO dao = new MembershipDAO(application);
int iResult = dao.insertMembershipDTO(dto);
dao.close();

if(iResult == 1 ){
	JSFunction.alertLocation("가입성공", "memberLogin.jsp", out);
}else{
	JSFunction.alertBack("회원가입에 실패하였습니다.", out);
}
%>
