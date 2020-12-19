<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.GalleryListTO"%>
<%@ page import="model.GalleryTO"%>
<%@ page import="java.util.ArrayList"%>
<%
	/* 페이징 */
	GalleryListTO listTO = (GalleryListTO)request.getAttribute("listTO");

	int cpage = listTO.getCpage();
	int totalRecord = listTO.getTotalRecord();
	int totalPage = listTO.getTotalPage();
	int blockPerPage = listTO.getBlockPerPage();
	int recordPerPage = listTO.getRecordPerPage();
	int startBlock = listTO.getStartBlock();
	int endBlock = listTO.getEndBlock();
	/* 페이징 끝 */
	
	ArrayList<GalleryTO> lists = (ArrayList<GalleryTO>)request.getAttribute("lists");
	StringBuffer gallery = new StringBuffer();
	for (GalleryTO to : lists) {
		String seq = to.getSeq();
		String subject = to.getSubject();
		String filename = to.getFilename();
		String wdate = to.getWdate();
		
		gallery.append("<div class='col-lg-4 col-md-6 col-lg-4'>");
		gallery.append("<div class='single_Portfolio wow fadeInUp' data-wow-duration='1s' data-wow-delay='.5s'>");
		gallery.append("<div class='portfolio_thumb'>");
		gallery.append("<img src='resources/upload/" + filename + "'>");
		gallery.append("</div>");
		gallery.append("<div class='portfolio_hover'>");
		gallery.append("<div class='title'>");
		gallery.append("<span>" + wdate + "</span>");
		gallery.append("<h3>" + subject + "</h3>");
		if (session.getAttribute("m_id") == null) {
			// 관리자 로그아웃 상태
		gallery.append("<a class='boxed-btn3' target='_blank' href='resources/upload/" + filename + "'>View</a>");
		} else {
			// 관리자 로그인 상태
			gallery.append("<a action='modify' class='action boxed-btn3' seq=" + seq + "href='#'>Modify</a>");
			gallery.append("<a action='delete' class='action boxed-btn3' seq=" + seq + "href='#'>Delete</a>");
		}
		gallery.append("</div>");
		gallery.append("</div>");
		gallery.append("</div>");
		gallery.append("</div>");
	}
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
    <link rel="stylesheet" href="css/owl.carousel.min.css">
    <link rel="stylesheet" href="css/magnific-popup.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="css/themify-icons.css">
    <link rel="stylesheet" href="css/nice-select.css">
    <link rel="stylesheet" href="css/flaticon.css">
    <link rel="stylesheet" href="css/gijgo.css">
    <link rel="stylesheet" href="css/animate.min.css">
    <link rel="stylesheet" href="css/slick.css">
    <link rel="stylesheet" href="css/slicknav.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/base/jquery-ui.css" />
    <script type="text/javascript" src="js/jquery-3.5.1.js"></script>
    <script type="text/javascript" src="js/jquery-ui.js"></script>
    <script type="text/javascript">
	    $(document).ready(function() {
	    	$("#writeDialog").css('display', 'none');
	        $("#modifyDialog").css('display', 'none');
	        $("#deleteDialog").css('display', 'none');
	        
	    	$(document).on('click', '#wbtn', function() {
	    		if ($('#w_subject').val() == '') {
	  		    	alert('제목을 입력하셔야 합니다.');
	  			  	return false;
	  		  	}
	    		if ($('#w_filename').val() == '') {
	  		    	alert('이미지 파일을 첨부하셔야 합니다.');
	  			  	return false;
	  		  	}
	    		if ($('#w_filename').val() != '') {
  			  		//이미지 파일 확장자만 업로드 허용
		  	    	var reg = /(.*?)\.(jpg|jpeg|png|gif|bmp|JPG|JPEG|PNG|GIF|BMP)$/;
		  	        if (!$('#w_filename').val().match(reg)) {
		  	            alert("해당 파일은 이미지 파일이 아닙니다.");
		  	            return false;
		  	        }
	  	      	}
	    		document.wfrm.submit();
	    	});
	    	
	    	$(document).on('click', '#mbtn', function() {
	    		if ($('#m_subject').val() == '') {
	  		    	alert('제목을 입력하셔야 합니다.');
	  			  	return false;
	  		  	}
	    		if ($('#m_filename').val() != '') {
  			  		//이미지 파일 확장자만 업로드 허용
		  	    	var reg = /(.*?)\.(jpg|jpeg|png|gif|bmp|JPG|JPEG|PNG|GIF|BMP)$/;
		  	        if (!$('#m_filename').val().match(reg)) {
		  	            alert("해당 파일은 이미지 파일이 아닙니다.");
		  	            return false;
		  	        }
	  	      	}
	    		document.mfrm.submit();
	    	});
	    	
	    	$(document).on('click', 'a.action', function() {
	            if ($(this).attr('action') == 'write') {
	                $('#writeDialog').dialog({
	                	width: 450,
	                    height: 300,
	                    modal: true
	                });
	            } else if ($(this).attr('action') == 'modify') {
	            	var seq = $(this).attr('seq');
	            	modifyData(seq);
	                $('#modifyDialog').dialog({
	                    width: 500,
	                    height: 500,
	                    modal: true
	                });
	            } else if ($(this).attr('action') == 'delete') {
	            	var seq = $(this).attr('seq');
	            	deleteData(seq);
	                $('#deleteDialog').dialog({
	                    width: 400,
	                    height: 400,
	                    modal: true
	                });
	            }
	        });
	    });

		var modifyData = function(seq) {
			$.ajax({
				url: 'galleryModify.do',
				data: {
					seq: seq
				},
				type: 'get',
				dataType: 'json',
				success: function(json) {
					$('#m_seq').val(json.seq);
					$('#m_subject').val(json.subject);
					$('#filename').val(json.filename);
				},
				error: function(error) {
					console.log('[에러]' + error.status);
					console.log('[에러]' + error.responseText);
				}
			});
		};
		
		var deleteData = function(seq) {
			$.ajax({
				url: 'galleryDelete.do',
				data: {
					seq: seq
				},
				type: 'get',
				dataType: 'json',
				success: function(json) {
					$('#d_seq').val(json.seq);
					$('#d_subject').val(json.subject);
					$('#d_filename').val(json.filename);
				},
				error: function(error) {
					console.log('[에러]' + error.status);
					console.log('[에러]' + error.responseText);
				}
			});
		};
	</script>
</head>
<body>
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
                                        <li><a href="galleryList.do">Gallery</a></li>
<%
	if (session.getAttribute("u_name") == null) {
		// 사용자 로그아웃 상태
%>                                      
										<li><a href="UserLogin.do">login</a></li>
<%	
	} else {
		// 사용자 로그인 상태
%>									
										<li><a href="UserLogout.do">logout</a></li>		
<%	
	}
%>
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
                                <a action="write" class="say_hi action" href="#">사진 등록</a>
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
	
	<div class="portfolio_image_area" style="padding-top: 50px; padding-bottom: 20px">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-lg-6">
					<div class="section_title text-center mb-90">
                        <h3 class="wow fadeInUp" data-wow-duration="1s" data-wow-delay=".3s">Gallery</h3>
                    </div>
                </div>
            </div>
            <div class="row">
				<%=gallery %>
            </div>
        </div>
	</div>
	
	<div class="container">
		<div class="row justify-content-center">
			<ul class="pagination">
<%			
	if (startBlock == 1) {
		out.println("<li class='page-item'><a class='page-link'>&lt;&lt;</a></li>");
	} else {
		out.println("<li class='page-item'><a class='page-link' href='galleryList.do?cpage=" + (startBlock - blockPerPage) + "'>&lt;&lt;</a></li>");
	}
	if (cpage == 1) {
		out.println("<li class='page-item'><a class='page-link'>&lt;</a></li>");
	} else {
		out.println("<li class='page-item'><a class='page-link' href='galleryList.do?cpage=" + (cpage - 1) + "'>&lt;</a></li>");
	}
	out.println("&nbsp;");

	for (int i = startBlock ; i <= endBlock ; i++) {
		if (cpage == i) {
			out.println("<li class='page-item active'><a class='page-link'>" + i + "</a></li>");
		} else {
			out.println("<li class='page-item'><a class='page-link' href='galleryList.do?cpage=" + i + "'>" + i + "</a></li>");
		}
	}
	out.println("&nbsp;");
	
	if (cpage == totalPage) {
		out.println("<li class='page-item'><a class='page-link'>&gt;</a></li>");
	} else {
		out.println("<li class='page-item'><a class='page-link' href='galleryList.do?cpage=" + (cpage + 1) + "'>&gt;</a></li>");
	}
	out.println("&nbsp;");
	
	if (endBlock == totalPage) {
		out.println("<li class='page-item'><a class='page-link'>&gt;&gt;</a></li>");
	} else {
		out.println("<li class='page-item'><a class='page-link' href='galleryList.do?cpage=" + (startBlock + blockPerPage) + "'>&gt;&gt;</a></li>");
	}
%>
			</ul>
		</div>
	</div>
	<br><br><br><br><br>
	
	<!-- dialog form start-->
	<div id="writeDialog" title="사진 등록" class="get_in_tauch_area" style="padding: 0px">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="touch_form">
                    	<form action="galleryWrite_ok.do" method="post" name="wfrm" enctype="multipart/form-data">
	                        <div class="row">
	                        	<fieldset>
		                            <div class="col-md-12" style="padding-top: 10px">
		                                <div class="single_input wow fadeInUp" data-wow-duration="1s" data-wow-delay=".1s">
		                                    <input type="text" id="w_subject" name="w_subject" maxlength="30" placeholder="제목" />
		                                </div>
		                            </div>
		                            <div class="col-md-12" style="padding-top: 10px">
		                                <div data-wow-duration="1s" data-wow-delay=".1s">
		                                    <input type="file" id="w_filename" name="w_filename" />
		                                </div>
		                            </div>
		                            <div class="col-md-12" style="padding-top: 30px">
		                                <div class="submit_btn wow fadeInUp" data-wow-duration="1s" data-wow-delay=".1s">
		                                    <button id="wbtn" class="boxed-btn3">Write</button>
		                                </div>
		                            </div>
	                            </fieldset>
	                        </div>
	                    </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div id="modifyDialog" title="사진 수정" class="get_in_tauch_area" style="padding: 0px">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="touch_form">
                    	<form action="galleryModify_ok.do" method="post" name="mfrm" enctype="multipart/form-data">
                    	<input type="hidden" id="m_seq" name="m_seq" />
	                        <div class="row">
	                        	<fieldset>
		                            <div class="col-md-12" style="padding-top: 10px">
		                                <div class="single_input wow fadeInUp" data-wow-duration="1s" data-wow-delay=".1s">
		                                                                제목 <input type="text" id="m_subject" name="m_subject" maxlength="30" />
		                                </div>
		                            </div>
		                            <div class="col-md-12" style="padding-top: 10px">
		                                <div class="single_input wow fadeInUp" data-wow-duration="1s" data-wow-delay=".1s">
		                                                                기존파일 <input type="text" id="filename" name="filename" readonly/>
		                                </div>
		                                                                새파일 <input type="file" id="m_filename" name="m_filename" />
		                            </div>
		                            <div class="col-md-12" style="padding-top: 30px">
		                                <div class="submit_btn wow fadeInUp" data-wow-duration="1s" data-wow-delay=".1s">
		                                    <button id="mbtn" class="boxed-btn3">Modify</button>
		                                </div>
		                            </div>
	                            </fieldset>
	                        </div>
	                    </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div id="deleteDialog" title="사진 삭제" class="get_in_tauch_area" style="padding: 0px">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="touch_form">
                    	<form action="galleryDelete_ok.do" method="post" name="dfrm">
                    	<input type="hidden" id="d_seq" name="d_seq" />
	                        <div class="row">
	                        	<fieldset>
		                            <div class="col-md-12" style="padding-top: 10px">
		                                <div class="single_input wow fadeInUp" data-wow-duration="1s" data-wow-delay=".1s">
		                                                                제목 <input type="text" id="d_subject" name="d_subject" readonly />
		                                </div>
		                            </div>
		                            <div class="col-md-12" style="padding-top: 10px">
		                                <div class="single_input wow fadeInUp" data-wow-duration="1s" data-wow-delay=".1s">
		                                                                파일이름 <input type="text" id="d_filename" name="d_filename" readonly />
		                                </div>
		                            </div>
		                            <div class="col-md-12" style="padding-top: 30px">
		                                <div class="submit_btn wow fadeInUp" data-wow-duration="1s" data-wow-delay=".1s">
		                                    <button class="boxed-btn3">Delete</button>
		                                </div>
		                            </div>
	                            </fieldset>
	                        </div>
	                    </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
	<!--/ dialog form end-->
	
    <!-- JS here -->
    <script src="js/vendor/modernizr-3.5.0.min.js"></script>
    <script src="js/vendor/jquery-1.12.4.min.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/owl.carousel.min.js"></script>
    <script src="js/isotope.pkgd.min.js"></script>
    <script src="js/ajax-form.js"></script>
    <script src="js/waypoints.min.js"></script>
    <script src="js/jquery.counterup.min.js"></script>
    <script src="js/imagesloaded.pkgd.min.js"></script>
    <script src="js/scrollIt.js"></script>
    <script src="js/jquery.scrollUp.min.js"></script>
    <script src="js/wow.min.js"></script>
    <script src="js/nice-select.min.js"></script>
    <script src="js/jquery.slicknav.min.js"></script>
    <script src="js/jquery.magnific-popup.min.js"></script>
    <script src="js/plugins.js"></script>
    <script src="js/gijgo.min.js"></script>

    <!--contact js-->
    <script src="js/contact.js"></script>
    <script src="js/jquery.ajaxchimp.min.js"></script>
    <script src="js/jquery.form.js"></script>
    <script src="js/jquery.validate.min.js"></script>
    <script src="js/mail-script.js"></script>
    <script src="js/main.js"></script>
</body>
</html>