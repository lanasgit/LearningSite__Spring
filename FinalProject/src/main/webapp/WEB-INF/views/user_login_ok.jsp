<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.UserTO"%>
<%
	int flag = (Integer)request.getAttribute("flag");
	
	out.println("<script type='text/javascript'>");
	if (flag == 1) {
		UserTO uto = (UserTO)request.getAttribute("uto");
		String seq = uto.getSeq();
		String name = uto.getName();
		
		session.setAttribute("u_seq", seq);
		session.setAttribute("u_name", name);
		out.println("location.href='index.jsp';");
	} else {
		out.println("alert('없는 아이디거나 비밀번호가 다릅니다.');");
		out.println("history.back();");
	}
	out.println("</script>");
%>