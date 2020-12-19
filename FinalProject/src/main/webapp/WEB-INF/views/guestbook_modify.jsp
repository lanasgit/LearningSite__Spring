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
	<div class="container">
	    <div class="row justify-content-center">
	        <div class="col-lg-6">
	            <div class="section_title text-center mb-70">
	                <span class="wow fadeInUp">Guestbook Modify</span>
	                <h3 class="wow fadeInUp">방명록 수정</h3>
	                <p class="wow fadeInUp">비밀번호와 수정할 내용을 입력해주세요</p>
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
                        <form action="guestbookModify_ok.do" method="post">
                        	<input type="hidden" name="seq" value="<%=seq %>" />
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="single_input wow fadeInUp">
                                        <input type="text" name="writer" value="<%=writer %>" readonly />
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="single_input wow fadeInUp">
                                        <input type="password" name="password" maxlength="15" placeholder="Password" required />
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="single_input wow fadeInUp">
                                       <textarea name="content" cols="30" rows="10" maxlength="1000" placeholder="Message"><%=content %></textarea>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="submit_btn wow fadeInUp">
                                        <button class="boxed-btn3" type="submit">Modify</button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>