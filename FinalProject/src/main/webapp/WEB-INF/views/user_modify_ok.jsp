<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int flag = (Integer)request.getAttribute("flag");
	
	out.println("<script type='text/javascript'>");
	if (flag == 1) {
		out.println("alert('비밀번호가 수정되었습니다. 다시 로그인해 주세요.');");
		session.invalidate();
		out.println("location.href='index.jsp';");
	} else {
		out.println("alert('비밀번호가 다릅니다.');");
		out.println("history.back();");
	}
	out.println("</script>");
%>