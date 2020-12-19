<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    <script type="text/javascript">
		$(document).ready(function() {
			$("#lwriteDialog").css('display', 'none');
			$("#lmodifyDialog").css('display', 'none');
			$("#ldeleteDialog").css('display', 'none');
			$("#swriteDialog").css('display', 'none');
			$("#smodifyDialog").css('display', 'none');
			$("#sdeleteDialog").css('display', 'none');
			
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
	        
	        $(document).on('click', 'button.action', function() {
	            if ($(this).attr('action') == 'lwrite') {
	                $('#lwriteDialog').dialog({
	                	width: 300,
	                    height: 220,
	                    modal: true,
	                    buttons: {
	                    	"추가": function() {
							 	 var name = $('#w_lcategory').val();
	         	            	 lwrite(name);
	                         },
	                    	"닫기": function() {
	                             $(this).dialog('close');
	                         }
	                    }
	                });
	            } else if ($(this).attr('action') == 'lmodify' && $('#accordion1 option:selected').val() != '대분류 선택') {
	            	var seq = $('#accordion1 option:selected').val();
	            	lmodifyLoad(seq);
	                $('#lmodifyDialog').dialog({
	                    width: 300,
	                    height: 220,
	                    modal: true,
	                    buttons: {
	                    	"수정": function() {
							 	 var name = $('#m_lcategory').val();
	         	            	 lmodify(seq, name);
	                         },
	                    	"닫기": function() {
	                             $(this).dialog('close');
	                         }
	                    }
	                });
	            } else if ($(this).attr('action') == 'ldelete' && $('#accordion1 option:selected').val() != '대분류 선택') {
	            	var seq = $('#accordion1 option:selected').val();
	            	ldeleteLoad(seq);
	                $('#ldeleteDialog').dialog({
	                    width: 350,
	                    height: 250,
	                    modal: true,
	                    buttons: {
	                    	"삭제": function() {
	         	            	 ldelete(seq);
	                         },
	                    	"닫기": function() {
	                             $(this).dialog('close');
	                         }
	                    }
	                });
	            } else if ($(this).attr('action') == 'swrite' && $('#accordion1 option:selected').val() != '대분류 선택') {
	            	var lseq = $('#accordion1 option:selected').val();
	                $('#swriteDialog').dialog({
	                	width: 300,
	                    height: 220,
	                    modal: true,
	                    buttons: {
	                    	"추가": function() {
							 	 var name = $('#w_scategory').val();
	         	            	 swrite(name, lseq);
	                         },
	                    	"닫기": function() {
	                             $(this).dialog('close');
	                         }
	                    }
	                });
	            } else if ($(this).attr('action') == 'smodify' && $('#accordion2 option:selected').val() != null) {
	            	var seq = $('#accordion2 option:selected').val();
	            	smodifyLoad(seq);
	                $('#smodifyDialog').dialog({
	                    width: 300,
	                    height: 220,
	                    modal: true,
	                    buttons: {
	                    	"수정": function() {
							 	 var name = $('#m_scategory').val();
	         	            	 smodify(seq, name);
	                         },
	                    	"닫기": function() {
	                             $(this).dialog('close');
	                         }
	                    }
	                });
	            } else if ($(this).attr('action') == 'sdelete' && $('#accordion2 option:selected').val() != null) {
	            	var seq = $('#accordion2 option:selected').val();
	            	sdeleteLoad(seq);
	                $('#sdeleteDialog').dialog({
	                    width: 400,
	                    height: 250,
	                    modal: true,
	                    buttons: {
	                    	"삭제": function() {
	         	            	 sdelete(seq);
	                         },
	                    	"닫기": function() {
	                             $(this).dialog('close');
	                         }
	                    }
	                });
	            }
	        });
		});
		
		var lwrite = function(name) {
			$.ajax({
				url: 'lcategoryWrite_ok.do',
				data: {
					name: name
				},
				type: 'get',
				dataType: 'json',
				success: function(json) {
					
					if (json.flag == 1) {
						$('#lwriteDialog').dialog('close');
						$('#w_lcategory').val('');
						lcategorySelect();
					} else {
						alert('[에러] 추가 실패');
					}
					
				},
				error: function(error) {
					console.log('[에러]' + error.status);
					console.log('[에러]' + error.responseText);
				}
			});
		};
		
		var lmodifyLoad = function(seq) {
			$.ajax({
				url: 'lcategoryModify.do',
				data: {
					seq: seq
				},
				type: 'get',
				dataType: 'json',
				success: function(json) {
					$('#m_lcategory').val(json.name);
				},
				error: function(error) {
					console.log('[에러]' + error.status);
					console.log('[에러]' + error.responseText);
				}
			});
		};
		
		var lmodify = function(seq, name) {
			$.ajax({
				url: 'lcategoryModify_ok.do',
				data: {
					seq: seq,
					name: name
				},
				type: 'get',
				dataType: 'json',
				success: function(json) {
					
					if (json.flag == 1) {
						$('#lmodifyDialog').dialog('close');
						lcategorySelect();
					} else {
						alert('[에러] 수정 실패');
					}
					
				},
				error: function(error) {
					console.log('[에러]' + error.status);
					console.log('[에러]' + error.responseText);
				}
			});
		};
		
		var ldeleteLoad = function(seq) {
			$.ajax({
				url: 'lcategoryDelete.do',
				data: {
					seq: seq
				},
				type: 'get',
				dataType: 'json',
				success: function(json) {
					$('#d_lcategory').val(json.name);
				},
				error: function(error) {
					console.log('[에러]' + error.status);
					console.log('[에러]' + error.responseText);
				}
			});
		};
		
		var ldelete = function(seq, name) {
			$.ajax({
				url: 'lcategoryDelete_ok.do',
				data: {
					seq: seq,
					name: name
				},
				type: 'get',
				dataType: 'json',
				success: function(json) {
					
					if (json.flag == 1) {
						$('#ldeleteDialog').dialog('close');
						lcategorySelect();
					} else {
						alert('[에러] 삭제 실패');
					}
					
				},
				error: function(error) {
					console.log('[에러]' + error.status);
					console.log('[에러]' + error.responseText);
				}
			});
		};
		
		var swrite = function(name, lseq) {
			$.ajax({
				url: 'scategoryWrite_ok.do',
				data: {
					name: name,
					lseq: lseq
				},
				type: 'get',
				dataType: 'json',
				success: function(json) {
					
					if (json.flag == 1) {
						$('#swriteDialog').dialog('close');
						$('#w_scategory').val('');
						scategorySelect();
					} else {
						alert('[에러] 추가 실패');
					}
					
				},
				error: function(error) {
					console.log('[에러]' + error.status);
					console.log('[에러]' + error.responseText);
				}
			});
		};
		
		var smodifyLoad = function(seq) {
			$.ajax({
				url: 'scategoryModify.do',
				data: {
					seq: seq
				},
				type: 'get',
				dataType: 'json',
				success: function(json) {
					$('#m_scategory').val(json.name);
				},
				error: function(error) {
					console.log('[에러]' + error.status);
					console.log('[에러]' + error.responseText);
				}
			});
		};
		
		var smodify = function(seq, name) {
			$.ajax({
				url: 'scategoryModify_ok.do',
				data: {
					seq: seq,
					name: name
				},
				type: 'get',
				dataType: 'json',
				success: function(json) {
					
					if (json.flag == 1) {
						$('#smodifyDialog').dialog('close');
						scategorySelect();
					} else {
						alert('[에러] 수정 실패');
					}
					
				},
				error: function(error) {
					console.log('[에러]' + error.status);
					console.log('[에러]' + error.responseText);
				}
			});
		};
		
		var sdeleteLoad = function(seq) {
			$.ajax({
				url: 'scategoryDelete.do',
				data: {
					seq: seq
				},
				type: 'get',
				dataType: 'json',
				success: function(json) {
					$('#d_scategory').val(json.name);
				},
				error: function(error) {
					console.log('[에러]' + error.status);
					console.log('[에러]' + error.responseText);
				}
			});
		};
		
		var sdelete = function(seq, name) {
			$.ajax({
				url: 'scategoryDelete_ok.do',
				data: {
					seq: seq,
					name: name
				},
				type: 'get',
				dataType: 'json',
				success: function(json) {
					
					if (json.flag == 1) {
						$('#sdeleteDialog').dialog('close');
						scategorySelect();
					} else {
						alert('[에러] 삭제 실패');
					}
					
				},
				error: function(error) {
					console.log('[에러]' + error.status);
					console.log('[에러]' + error.responseText);
				}
			});
		};
		
		var lcategorySelect = function() {
			$.ajax({
				url: 'lcategorySelect.do',
				type: 'get',
				dataType: 'json',
				success: function(json) {
					
					$('#accordion1').empty();
					
					var selectlist = '<select class="form-control" name="lcategory">';
						selectlist += '<option value="대분류 선택">대분류 선택</option>';
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
	<br><br><br>
	<div class="container" style="padding-top: 50px;">
	    <div class="row justify-content-center">
	        <div class="col-md-12">
	            <div class="section_title text-center mb-70">
	                <span class="wow fadeInUp" data-wow-duration="1s" data-wow-delay=".1s">category</span>
	                <h3 class="wow fadeInUp" data-wow-duration="1.2s" data-wow-delay=".2s">목록 관리</h3>
	            </div>
	        </div>
	    </div>
	</div>
	
	<hr color="white">
	
	<div class="contents_sub section-top-border1">
		<div class="progress-table">
			<div class="table-head">
				<div class="serial"></div>
				<div class="country">대분류 </div>
				<div id="accordion1"></div>
			</div>
			<div class="table-row">
				<div class="serial"></div>
				<div class="country">대분류 관리 </div>
				<div class="button-group-area mt-10">
			    	<button action="lwrite" type="button" class="action genric-btn success-border medium">추가</button>
			    	<button action="lmodify" type="button" class="action genric-btn success-border medium">수정</button>
			    	<button action="ldelete" type="button" class="action genric-btn success-border medium">삭제</button>
			  	</div>
			</div>
			<div class="table-head">
				<div class="serial"></div>
				<div class="country">소분류</div>
				<div id="accordion2"></div>
			</div>
			<div class="table-row">
				<div class="serial"></div>
				<div class="country">소분류 관리 </div>
				<div class="button-group-area mt-10">
					<button action="swrite" type="button" class="action genric-btn success-border medium">추가</button>
				    <button action="smodify" type="button" class="action genric-btn success-border medium">수정</button>
				    <button action="sdelete" type="button" class="action genric-btn success-border medium">삭제</button>
			  	</div>
			</div>
		</div>
	</div>
    <div class="get_in_tauch_area" style="padding-top: 1px; padding-bottom: 80px">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="touch_form">
                        <div class="col-md-12">
                            <div class="submit_btn wow fadeInUp" data-wow-duration="1s" data-wow-delay=".7s">
                                <button id="wbtn" class="boxed-btn3" type="submit" onclick="javascript:history.back()">돌아가기</button>
                            </div>
                        </div>
					</div>
				</div>
			</div>
    	</div>
    </div>
    
	<!-- dialog form start-->
	<div id="lwriteDialog" title="대분류 추가" class="get_in_tauch_area" style="padding: 0px">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="touch_form">
                        <div class="row">
                        	<fieldset>
	                            <div class="col-md-12" style="padding-top: 15px">
	                                <div class="single_input wow fadeInUp" data-wow-duration="1s" data-wow-delay=".1s">
	                                    <input type="text" id="w_lcategory" name="w_lcategory" maxlength="100" placeholder="대분류명" />
	                                </div>
	                            </div>
                            </fieldset>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="lmodifyDialog" title="대분류 수정" class="get_in_tauch_area" style="padding: 0px">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="touch_form">
                        <div class="row">
                        	<fieldset>
	                            <div class="col-md-12" style="padding-top: 15px">
	                                <div class="single_input wow fadeInUp" data-wow-duration="1s" data-wow-delay=".1s">
	                                    <input type="text" id="m_lcategory" name="m_lcategory" maxlength="100" />
	                                </div>
	                            </div>
                            </fieldset>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="ldeleteDialog" title="대분류 삭제" class="get_in_tauch_area" style="padding: 0px">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="touch_form">
                        <div class="row">
                        	<fieldset>
	                            <div class="col-md-12" style="padding-top: 15px">
	                                <div class="single_input wow fadeInUp" data-wow-duration="1s" data-wow-delay=".1s">
	                                    <input type="text" id="d_lcategory" name="d_lcategory" readonly />
	                                </div>
	                                <strong style="color: red">%경고: 연결된 소분류 및 게시글도 모두 삭제됩니다.</strong>
	                            </div>
                            </fieldset>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div id="swriteDialog" title="소분류 추가" class="get_in_tauch_area" style="padding: 0px">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="touch_form">
                        <div class="row">
                        	<fieldset>
	                            <div class="col-md-12" style="padding-top: 15px">
	                                <div class="single_input wow fadeInUp" data-wow-duration="1s" data-wow-delay=".1s">
	                                    <input type="text" id="w_scategory" name="w_scategory" maxlength="100" placeholder="소분류명" />
	                                </div>
	                            </div>
                            </fieldset>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="smodifyDialog" title="소분류 수정" class="get_in_tauch_area" style="padding: 0px">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="touch_form">
                        <div class="row">
                        	<fieldset>
	                            <div class="col-md-12" style="padding-top: 15px">
	                                <div class="single_input wow fadeInUp" data-wow-duration="1s" data-wow-delay=".1s">
	                                    <input type="text" id="m_scategory" name="m_scategory" maxlength="100" />
	                                </div>
	                            </div>
                            </fieldset>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="sdeleteDialog" title="소분류 삭제" class="get_in_tauch_area" style="padding: 0px">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="touch_form">
                        <div class="row">
                        	<fieldset>
	                            <div class="col-md-12" style="padding-top: 15px">
	                                <div class="single_input wow fadeInUp" data-wow-duration="1s" data-wow-delay=".1s">
	                                    <input type="text" id="d_scategory" name="d_scategory" readonly />
	                                </div>
	                                <strong style="color: red">%경고: 연결된 게시글도 모두 삭제됩니다.</strong>
	                            </div>
                            </fieldset>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--/ dialog form end-->
    
</body>
</html>