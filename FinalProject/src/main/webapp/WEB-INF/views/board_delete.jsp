<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.BoardTO" %>    
<%
	BoardTO to = (BoardTO)request.getAttribute("to");
	
	String seq = to.getSeq();
	String subject = to.getSubject();
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
	<link rel="stylesheet" type="text/css" href="css/board_write.css">
	<link rel="stylesheet" href="css/base/jquery-ui.css" />
	<link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  	<link href="assets/css/style.css" rel="stylesheet">
	<script type="text/javascript" src="js/jquery-3.5.1.js"></script>
    <script type="text/javascript" src="js/jquery-ui.js"></script>
</head>
<body>
	<div class="container" style="padding-top: 50px;">
	    <div class="row justify-content-center">
	        <div class="col-lg-6">
	            <div class="section_title text-center mb-70">
	                <span class="wow fadeInUp">Delete</span>
	                <h3 class="wow fadeInUp">강의 삭제</h3>
	            </div>
	        </div>
	    </div>
	</div>
	
	<form action="delete_ok.do" method="post">
		<input type="hidden" name="seq" value="<%=seq %>" />
		<div class="section-top-border1">
			<div class="progress-table contents_sub">
				<div class="table-head">
					<div class="serial"></div>
						<div class="country">제목</div>
					<div class="mt-10">
						<input type="text" name="subject" value="<%=subject %>" class="single-input" readonly />
					</div>
				</div>
			</div>
		</div>
		<div class="get_in_tauch_area" style="padding-top: 1px; padding-bottom: 1px;">
	       <div class="container">
	            <div class="row justify-content-center">
	                <div class="col-lg-8">
	                    <div class="touch_form">
	                        <div class="col-md-12">
	                            <div class="submit_btn wow fadeInUp">
	                                <button class="boxed-btn3" type="submit">Delete</button>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
	</form>
	
	<!-- JS here -->
    <script src="js/bootstrap.min.js"></script>
</body>
</html>