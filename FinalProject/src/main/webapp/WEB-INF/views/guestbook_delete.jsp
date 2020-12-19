<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.GuestbookTO" %>    
<% 
	GuestbookTO gto = (GuestbookTO)request.getAttribute("gto");
	String seq = gto.getSeq();
	String writer = gto.getWriter();
	String content = gto.getContent();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>교육 사이트</title>
    <link rel="icon" type="image/x-icon" href="img/favicon.ico" />
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
	<br><br><br>
<%
	if (session.getAttribute("m_id") == null) {
		// 관리자 로그아웃 상태
%>  
	<div class="container">
	    <div class="row justify-content-center">
	        <div class="col-lg-6">
	            <div class="section_title text-center mb-70">
	                <span class="wow fadeInUp">Guestbook Delete</span>
	                <h3 class="wow fadeInUp">방명록 삭제</h3>
	                <p class="wow fadeInUp">비밀번호를 입력해주세요</p>
	            </div>
	        </div>
	    </div>
	</div>
	<hr>
    <div class="get_in_tauch_area" style="padding-top: 1px; padding-bottom: 1px">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="touch_form">
                        <form action="guestbookDelete_ok.do" method="post">
                        	<input type="hidden" name="seq" value="<%=seq %>" />
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="single_input wow fadeInUp">
                                        <input type="text" name="writer" value="<%=writer %>" readonly />
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="single_input wow fadeInUp">
                                        <input type="password" name="password" placeholder="Password" required />
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="submit_btn wow fadeInUp">
                                        <button class="boxed-btn3" type="submit">Delete</button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
<%	
	} else {
		// 관리자 로그인 상태
%>
	<div class="container">	   
	    <div class="row justify-content-center">
	        <div class="col-lg-6">
	            <div class="section_title text-center mb-70">
	                <span class="wow fadeInUp">Guestbook Delete</span>
	                <h3 class="wow fadeInUp">방명록 관리자용 삭제</h3>
	                <p class="wow fadeInUp">버튼을 누르시면 아래 방명록이 삭제됩니다</p>
	            </div>
	        </div>
	    </div>
    </div>
    <div data-scroll-index="0" class="get_in_tauch_area" style="padding-top: 1px; padding-bottom: 1px">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="touch_form">
	                    <div class="row">
	                        <div class="col-md-12">
	                            <div class="single_input wow fadeInUp">
	                                <input type="text" name="writer" value="<%=writer %>" readonly />
	                            </div>
	                        </div>
	                        <div class="col-md-12">
                                <div class="single_input wow fadeInUp">
                                   <textarea name="content" cols="30" rows="10" placeholder="Message" readonly><%=content %></textarea>
                                </div>
                            </div>
	                        <div class="col-md-12">
	                            <div class="submit_btn wow fadeInUp">
	                                <button class="boxed-btn3" onclick="location.href='guestbookManagerDelete_ok.do?seq=<%=seq %>'">관리자용 강제 삭제 버튼</button>
	                            </div>
	                        </div>
	                    </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
<%
	}
%>
</body>
</html>