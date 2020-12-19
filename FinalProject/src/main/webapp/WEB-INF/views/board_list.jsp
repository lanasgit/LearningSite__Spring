<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.LcategoryTO"%>
<%@ page import="model.ScategoryTO"%>
<%@ page import="java.util.ArrayList"%>
<%
	ArrayList<LcategoryTO> LcategoryList = (ArrayList<LcategoryTO>)request.getAttribute("LcategoryList");
	ArrayList<ScategoryTO> ScategoryList = (ArrayList<ScategoryTO>)request.getAttribute("ScategoryList");

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

    <div class="slider_area">
        <div class="single_slider d-flex align-items-center slider_bg_1 overlay">
            <div class="container">
                <div class="row align-items-center justify-content-start">
                    <div class="col-lg-10 col-md-10">
                        <div class="slider_text">
                            <h3 class="wow fadeInLeft">
                            </h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>