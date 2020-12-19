<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.LcategoryTO"%>
<%@ page import="model.ScategoryTO"%>
<%@ page import="model.BoardTO"%>
<%@ page import="java.util.ArrayList"%>
<%
	// dropdown start
	ArrayList<LcategoryTO> LcategoryList = (ArrayList<LcategoryTO>)request.getAttribute("LcategoryList");
	ArrayList<ScategoryTO> ScategoryList = (ArrayList<ScategoryTO>)request.getAttribute("ScategoryList");
	ArrayList<BoardTO> BoardList = (ArrayList<BoardTO>)request.getAttribute("BoardList");

	StringBuffer dropdown = new StringBuffer();
	
	for (LcategoryTO lto : LcategoryList) {
		dropdown.append("<li><a href='#'>" + lto.getName() + "<i class='ti-angle-down'></i></a>");
		dropdown.append("<ul class='submenu'>");
		
		for (ScategoryTO sto : ScategoryList) {
			if (lto.getSeq().equals(sto.getLseq())) {
				dropdown.append("<li><a href='view.do?sseq=" + sto.getSeq() + "&sname=" + sto.getName() + "&lname=" + lto.getName() + "'>" + sto.getName() + "</a></li>");
			}
		}
		
		dropdown.append("</ul>");
		dropdown.append("</li>");
	}
	// dropdown end

	
	// subject list start
	String sname = (String)request.getAttribute("sname");
	String lname = (String)request.getAttribute("lname");
	
	StringBuffer list = new StringBuffer();
	
	for (BoardTO to : BoardList) {
		list.append("<ul class='nav nav-tabs flex-column'>");
		list.append("<li class='nav-item'><a style='color:white;' href='view.do?seq="+to.getSeq()+"&sseq="+to.getSseq()+"&sname="+sname+"&lname="+lname+"'>" + to.getSubject() + "</a></li>");
		list.append("<hr color='white'>");
		list.append("</ul>");
	}
	// subject list end

	
	// view start
	BoardTO to = (BoardTO)request.getAttribute("to");
	String seq = "";
	String subject = "'해당 소분류의 글이 존재하지 않습니다'";
	String link = "";
	String content = "";
	String wdate = "없음";
	
	if (to != null) {
		seq = to.getSeq();
		subject = to.getSubject();
		link = to.getLink();
		content = to.getContent();
		wdate = to.getWdate();
	} 
	// view end
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
    <link rel="stylesheet" href="css/themify-icons.css">
    <link rel="stylesheet" href="css/style.css">
  	<link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  	<link href="assets/vendor/icofont/icofont.min.css" rel="stylesheet">
  	<link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
  	<link href="assets/vendor/animate.css/animate.min.css" rel="stylesheet">
  	<link href="assets/vendor/owl.carousel/assets/owl.carousel.min.css" rel="stylesheet">
  	<link href="assets/vendor/venobox/venobox.css" rel="stylesheet">
  	<link href="assets/vendor/aos/aos.css" rel="stylesheet">
  	<link href="assets/css/style.css" rel="stylesheet">
  	<style>
  		iframe {width: 640px; height: 360px; border-width: thick; border-color: black;}
  		a:hover {font-weight: bold;}
  	</style>
  	<script type="text/javascript" src="js/jquery-3.5.1.js"></script>
    <script type="text/javascript">
<%
	if (to != null && session.getAttribute("u_name") != null) {
		// 소분류 글이 존재하고 사용자 로그인 상태
%>     
	    window.onload = function() {
	    	readComment();
	    	
			document.getElementById('wbtn').onclick = function() {
				if (document.frm.password.value == '') {
					alert('비밀번호를 입력하셔야 합니다.');
					return false;
				}
				if (document.frm.content.value == '') {
					alert('내용을 입력하셔야 합니다.');
					return false;
				}
				writeComment();
			};
	    };
<%
	} else if (to != null && session.getAttribute("u_name") == null) {
		// 소분류 글이 존재하고 사용자 로그아웃 상태
%>	    
		window.onload = function() {
			readComment();
		};
<%
	}
%>		
	    var writeComment = function() {
			var request = new XMLHttpRequest();
			request.onreadystatechange = function() {
				if (request.readyState == 4) {
					if (request.status == 200) {
						var data = request.responseText.trim();
						var json = eval('(' + data + ')');
						if (json.flag == 1) {
							readComment();
							document.frm.password.value = '';
							document.frm.content.value = '';
						} else {
							alert('[오류] 댓글이 작성되지 않았습니다');
						}
					} else {
						alert('페이지 처리 에러');
					};
				};
			};
			var url = 'commentWrite_ok.do?';
			url += 'writer=' + encodeURIComponent(document.frm.writer.value)
			url += '&password=' + document.frm.password.value
			url += '&content=' + encodeURIComponent(document.frm.content.value)
			url += '&cseq=' + document.frm.cseq.value
			request.open('get', url, true);
			request.send();
		};
	    
	    var readComment = function() {
			var request = new XMLHttpRequest();
			request.onreadystatechange = function() {
				if (request.readyState == 4) {
					if (request.status == 200) {
						showData(request.responseText.trim());
					} else {
						alert('페이지 처리 에러');
					};
				};
			};
			
			var url = 'commentList.do?';
			url += 'cseq=' + <%=seq %>
			request.open('get', url, true);
			request.send();
			
			var showData = function(data) {
				var json = eval('(' + data + ')');
				
				// 팝업창 크기 (수정, 삭제)
				var width = 700;
				var height = 700;
				// 팝업창 위치
				var left = (screen.width - width) / 2 ;
			    var top = (screen.height - height) / 2 ;
			    
			    var	result = '';
				$.each (json.data, function(index, item) {
					result += '<div class="whole-wrap">';
					result += '<div class="container box_1170">';
			    	result += '<div class="section-top-border22">';
			    	result += '<h33 class="mb-30">' + item.writer + '<p11 class="wdate">&nbsp&nbsp&nbsp'+ item.cdate +'</p11></h33> ';
			    	result += '<div class="row">';
			    	result += '<div class="col-lg-12">';
			    	result += '<blockquote class="generic-blockquote" style="word-wrap:break-word; word-break:break-all;">';
			    	result += item.content;
			    	<%
			    		if (session.getAttribute("u_name") != null || session.getAttribute("m_id") != null) {
			    	%>
			    	result += '<div align="right" class="title">';
					result += '<button class="btn genric-btn default" onclick="window.open(\'commentModify.do?seq=' + item.seq + '\', \'\', \'width='+width+', height='+height+', toolbar=no, location=no, menubar=no, scrollbars=no, status=no, resizable=no, left='+left+', top='+top+'\')">수정</button>';
					result += '&nbsp&nbsp';
					result += '<button class="btn genric-btn default" onclick="window.open(\'commentDelete.do?seq=' + item.seq + '\', \'\', \'width='+width+', height='+height+', toolbar=no, location=no, menubar=no, scrollbars=no, status=no, resizable=no, left='+left+', top='+top+'\')">삭제</button>';
			    	result += '</div>';
			    	<%
			    		}
			    	%>
			    	result += '</blockquote>';
			    	result += '</div>';
			    	result += '</div>';
			    	result += '</div>';
			    	result += '</div>';
			    	result += '</div>';
				});
				
				document.getElementById('commentlist').innerHTML = result;
			};
		};
	</script>
</head>
<body data-aos-easing="ease" data-aos-duration="1000" data-aos-delay="0">
    <header>
        <div class="header-area">
            <div id="sticky-header" class="main-header-area">
                <div class="container-fluid p-0">
                    <div class="row align-items-center no-gutters">
                        <div class="col-xl-2 col-lg-2">
                            <div class="logo-img">
	                            <a href="index.jsp">
	                            	<img src="img/logo.png">
	                            </a>
                            </div>
                        </div>
                        <div class="col-xl-8 col-lg-8">
                            <div class="main-menu d-none d-lg-block text-center">
                                <nav>
                                    <ul id="navigation">
                                        <%=dropdown %>
                                    </ul>
                                </nav>
                            </div>
                        </div>
<%
	if (session.getAttribute("m_id") != null) {
		// 관리자 로그인 상태
%>                        
                        <div class="col-lg-2 d-none d-lg-block">
                            <div class="log_chat_area d-flex align-items-end">
                                <a href="write.do" class="say_hi">강의 등록</a>
                            </div>
                        </div>
<%
	} else if (session.getAttribute("u_name") != null) {
		// 사용자 로그인 상태
%>
						<div class="col-lg-2 d-none d-lg-block">
                            <div class="log_chat_area d-flex align-items-end">
                                <a href="UserModify.do" class="say_hi"><%=session.getAttribute("u_name") %>님 환영합니다.</a>
                            </div>
                        </div>
<%
	}
%>                          
                        <div class="col-12">
                            <div class="mobile_menu d-block d-lg-none"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <div class="slider_area1">
        <div class="single_slider1 d-flex align-items-center slider_bg_1 overlay">
            <div class="container">
                <div class="row align-items-center justify-content-start">
                    <div class="col-lg-10 col-md-10">
                        <div class="slider_text">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <section id="specials" class="specials">
    	<div class="container" data-aos="fade-up">
    		<div class="section-title">
          		<h2><%=lname %></h2>
          		<p><%=sname %></p>
        	</div>
<%
	if (session.getAttribute("m_id") != null && to != null) {
		// 관리자 로그인 상태
%>  			
			<div align="right">
				<div class="button-group-area mt-10">
					<button class="genric-btn success-border medium" onclick="location.href='modify.do?seq=<%=seq %>'">수정</button>
					<button class="genric-btn success-border medium" onclick="location.href='delete.do?seq=<%=seq %>'">삭제</button>
				</div>
			</div>
<%	
	}
%>
	    	<div class="row" data-aos="fade-up" data-aos-delay="100">
	          	<div class="col-lg-3">
		        	<%=list %>
	          	</div>
				<div class='col-lg-9 mt-4 mt-lg-0'>
	            	<div class='tab-content'>
	              		<div class='tab-pane active show'>
	                		<div class='row'>
	                  			<div class='col-lg-8 details order-2 order-lg-1'>
	                    			<h3><%=subject %></h3>
	                    			<p class='font-italic'> 등록일 : <%=wdate %></p>
	                    			<p><%=link %></p>
	                    			<p><%=content %></p>
	                  			</div>
	                		</div>
	              		</div>
	             	</div>
	            </div>
			</div>
		</div>
  	</section>
<%
	if (to != null && session.getAttribute("u_name") != null) {
		// 소분류 글이 존재하고 사용자 로그인 상태
%> 			
	<section class="contact">
		<div class="container aos-init aos-animate" data-aos="fade-up">
			<div class="col-lg-12 mt-5 mt-lg-0">
           	 	<form role="form" method="post" class="php-email-form" name="frm">
           	 	<input type="hidden" id="cseq" name="cseq" value="<%=seq %>" />
              		<div class="form-row">
                		<div class="col-md-3 form-group">
                  			<input type="text" class="form-control" id="writer" name="writer" value="<%=session.getAttribute("u_name") %>" readonly>
                		</div>
	                	<div class="col-md-3 form-group">
	                  		<input type="password" class="form-control" id="password" name="password" placeholder="Password" maxlength="15">
	                	</div>
              		</div>
	              	<div class="form-group">
	                	<textarea class="form-control" id="content" name="content" rows="5" placeholder="Content" maxlength="1000"></textarea>
	              	</div>
              		<div class="text-center">
              			<button id="wbtn" type="submit">Comment</button>
              		</div>
            	</form>
          	</div>
		</div>
	</section>
<%
	} else if (to != null && session.getAttribute("u_name") == null) {
		// 소분류 글이 존재하고 사용자 로그아웃 상태
%> 	
	<section class="contact">
		<div class="container aos-init aos-animate" data-aos="fade-up">
			<div class="col-lg-12 mt-5 mt-lg-0">
				<form role="form" method="post" class="php-email-form">
				<input type="hidden" id="cseq" name="cseq" value="<%=seq %>" />
	           		<div class="form-row">
	             		<div class="col-md-3 form-group">
	               			<input type="text" class="form-control" placeholder="Your Name" readonly>
	             		</div>
	              		<div class="col-md-3 form-group">
	                		<input type="password" class="form-control" placeholder="Password" readonly>
	              		</div>
	           		</div>
	            	<div class="form-group">
	              		<textarea class="form-control" rows="5" placeholder="Content" readonly></textarea>
	            	</div>
	           		<div class="text-center">
	           			<button type="submit" onclick="location.href='UserLogin.do'">로그인이 필요합니다</button>
	           		</div>
	           	</form>
          	</div>
		</div>
	</section>
<% 
	}
%>	
   	<section id="why-us" class="why-us">
      	<div class="container aos-init aos-animate" data-aos="fade-up">
			<div class=“row”>
				<div class=“col-lg-4”>
					<div class="section_title22 wow fadeInUp text-center" data-wow-duration="1s" data-wow-delay=".1s" >COMMENT</div>
					<div id="commentlist"></div>
				</div>
			</div>
		</div>
	</section>
	
	<!-- Vendor JS Files -->
  	<script src="assets/vendor/jquery/jquery.min.js"></script>
  	<script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  	<script src="assets/vendor/jquery.easing/jquery.easing.min.js"></script>
  	<script src="assets/vendor/php-email-form/validate.js"></script>
  	<script src="assets/vendor/owl.carousel/owl.carousel.min.js"></script>
  	<script src="assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
  	<script src="assets/vendor/venobox/venobox.min.js"></script>
  	<script src="assets/vendor/aos/aos.js"></script>

  	<!-- Template Main JS File -->
  	<script src="assets/js/main.js"></script>
</body>
</html>