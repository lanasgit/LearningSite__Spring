<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.BoardTO" %>    
<%
	BoardTO to = (BoardTO)request.getAttribute("to");
	
	String seq = to.getSeq();
	String subject = to.getSubject();
	String link = to.getLink();
	String content = to.getContent();
	String sseq = to.getSseq();
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
  	<style type="text/css">
	    ::selection {
			background-color: white;
			color: black;
		}
    </style>
	<script type="text/javascript" src="js/jquery-3.5.1.js"></script>
    <script type="text/javascript" src="js/jquery-ui.js"></script>
    <script type="text/javascript">
		$(document).ready(function() {
			$('#accordion1').accordion({
				heightStyle: 'content'
	        });
			$('#accordion2').accordion({
				heightStyle: 'content'
	        });
			
			lcategorySelect();
	        
	        $('#accordion1').on('change', function() {
	        	scategorySelect();
	        });
		}); 
		
		var lcategorySelect = function() {
			$.ajax({
				url: 'lcategorySelect.do',
				type: 'get',
				dataType: 'json',
				success: function(json) {
					
					$('#accordion1').empty();
					
					var selectlist = '<select class="form-control" name="lcategory">';
						selectlist += '<option>대분류 선택</option>';
					$.each(json.data, function(index, item) {
						selectlist += '<option value="' + item.seq + '">' + item.name + '</option>';
					});
					selectlist += '</select>';
						
					$('#accordion1').append(selectlist);
					$('#accordion1').accordion('refresh');
					
				},
				error: function(error) {
					console.log('[에러]' + error.status);
					console.log('[에러]' + error.responseText);
				}
			});
		};
		
		var scategorySelect = function() {
			$.ajax({
				url: 'scategorySelect.do',
				data: {
					lseq: $('#accordion1 option:selected').val()
				},
				type: 'get',
				dataType: 'json',
				success: function(json) {
					
					$('#accordion2').empty();
					
					var selectlist = '<select class="form-control" name="scategory">';
					$.each(json.data, function(index, item) {
						selectlist += '<option value="' + item.seq + '">' + item.name + '</option>';
					});
					selectlist += '</select>';
					
					$('#accordion2').append(selectlist);
					$('#accordion2').accordion('refresh');
					
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
	<div class="container" style="padding-top: 50px;">
	    <div class="row justify-content-center">
	        <div class="col-lg-6">
	            <div class="section_title text-center mb-70">
	                <span class="wow fadeInUp" data-wow-duration="1s" data-wow-delay=".1s">Modify</span>
	                <h3 class="wow fadeInUp" data-wow-duration="1.2s" data-wow-delay=".2s">강의 수정</h3>
	            </div>
	        </div>
	    </div>
	</div>
	
	<nav class="nav-menu d-none d-lg-block">
    	<ul>
	    	<li class="book-a-table text-center"><a href="categorySet.do"> 목록 관리 </a></li>
        </ul>
    </nav>
    
    <hr color="white">
	
	<form action="modify_ok.do" method="post">
		<input type="hidden" name="seq" value="<%=seq %>" />
		<div class="section-top-border">
			<div class="progress-table contents_sub">
				<div class="table-head">
					<div class="serial"></div>
					<div class="country">대분류 </div>
					<div class="" id="accordion1"></div>
				</div>
				<div class="table-row">
					<div class="serial"></div>
					<div class="country">소분류 </div>
					<div class="" id="accordion2"></div>
				</div>
				<div class="table-row">
					<div class="serial"></div>
					<div class="country">제목 </div>
					<div class="mt-10">
						<input type="text" class="single-input" id="subject" name="subject" placeholder="제목을 입력하세요." value="<%=subject %>" required />
					</div>
				</div>
				<div class="table-row">
					<div class="serial"></div>
					<div class="country">유튜브 링크 </div>
					<div class="mt-10">
						<textarea class="single-input" id="link" name="link" placeholder="유튜브 링크를 입력하세요." required><%=link %></textarea>
					</div>
				</div>
			</div>
		</div>
		<textarea name="content" id="content" class="single-input1" style="width:100%; height:300px;"><%=content %></textarea>
		<div class="get_in_tauch_area" style="padding-top: 1px; padding-bottom: 1px">
			<div class="container">
				<div class="row justify-content-center1">
	                <div class="col-lg-8">
	                    <div class="touch_form">
	                        <div class="col-md-12">
	                            <div class="submit_btn wow fadeInUp" data-wow-duration="1s" data-wow-delay=".7s">
	                                <button id="mbtn" class="boxed-btn3" type="submit">Modify</button>
	                            </div>
	                        </div>
	                    </div>
	             	</div>
	          	</div>
	      	</div>
	   	</div>
	</form>

	<!-- JS here -->
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
</body>
	<script type="text/javascript" src="./smart_editor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
	<script type="text/javascript">
		window.onload = function(){
			document.getElementById('mbtn').onclick = function() {
				editor_object.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
	    		if ($('#accordion2 option:selected').val() == null) {
	  		    	alert('대소분류를 선택하셔야 합니다.');
	  			  	return false;
	  		  	}
		    };
		};
	
		var editor_object = []; 
		nhn.husky.EZCreator.createInIFrame({ 
			oAppRef : editor_object, 
			elPlaceHolder: "content", 
			sSkinURI: "./smart_editor/SmartEditor2Skin.html", 
			fCreator : "createSEditor2",
			htParams : {  
				bUseToolbar : true,  
				bUseVerticalResizer : true,  
				bUseModeChanger : true, 
			} 
		});
	</script>
</html>