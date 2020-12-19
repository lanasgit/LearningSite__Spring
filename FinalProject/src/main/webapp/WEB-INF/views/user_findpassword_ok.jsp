<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int flag = (Integer)request.getAttribute("flag");
	String passwordTemp = (String)request.getAttribute("passwordTemp");
	
	out.println("<script type='text/javascript'>");
	if (flag == 1) {
		out.println("alert('임시 비밀번호는 " + passwordTemp + " 입니다. 로그인 후 비밀번호를 변경해 주세요. 확인을 누르시면 창이 닫힙니다.');");
		out.println("location.href='UserLogin.do';");
	} else {
		out.println("alert('[에러]');");
		out.println("history.back();");
	}
	out.println("</script>");
%>