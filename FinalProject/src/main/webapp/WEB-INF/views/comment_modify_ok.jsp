<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
	int flag = (Integer)request.getAttribute("flag");
	
	out.println("<script type='text/javascript'>");
	if (flag == 1) {
		out.println("alert('댓글이 수정되었습니다.');");
		out.println("close();");
		out.println("window.opener.location.reload();");
	} else {
		out.println("alert('비밀번호를 확인해주세요.');");
		out.println("history.back();");
	}
	out.println("</script>");
%>