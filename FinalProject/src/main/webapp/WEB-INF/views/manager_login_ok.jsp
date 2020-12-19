<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int flag = (Integer)request.getAttribute("flag");
	
	out.println("<script type='text/javascript'>");
	if (flag == 1) {
		String id = (String)request.getAttribute("id");
		session.setAttribute("m_id", id);
		out.println("location.href='index.jsp';");
	} else {
		out.println("alert('없는 아이디거나 비밀번호가 다릅니다.');");
		out.println("history.back();");
	}
	out.println("</script>");
%>