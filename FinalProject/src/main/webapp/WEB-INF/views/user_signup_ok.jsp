<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int flag = (Integer)request.getAttribute("flag");
	
	out.println("<script type='text/javascript'>");
	if (flag == 1) {
		out.println("alert('회원가입 완료. 로그인페이지로 이동합니다.');");
		out.println("location.href='UserLogin.do';");
	} else {
		out.println("alert('[에러]');");
		out.println("history.back();");
	}
	out.println("</script>");
%>