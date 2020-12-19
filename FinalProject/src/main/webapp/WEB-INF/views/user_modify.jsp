<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>>
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>교육 사이트</title>
    <link rel="icon" type="image/x-icon" href="img/favicon.ico" />
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/base/jquery-ui.css" />
    <script type="text/javascript" src="js/jquery-3.5.1.js"></script>
    <script type="text/javascript" src="js/jquery-ui.js"></script>
    <script type="text/javascript">
	    $(document).ready(function() {
	    	$("#modifyDialog").css('display', 'none');
	        $("#deleteDialog").css('display', 'none');
	        
	        document.getElementById('mbtn').onclick = function() {
				if (document.mfrm.newPassword.value.trim() != document.mfrm.newPasswordCheck.value.trim()) {
					alert('동일한 새 비밀번호를 입력해주세요.');
					return false;
				}
			};
			
	        $(document).on('click', 'button.action', function() {
	            if ($(this).attr('action') == 'modify') {
	                $('#modifyDialog').dialog({
	                    width: 370,
	                    height: 450,
	                    modal: true
	                });
	            } else if ($(this).attr('action') == 'delete') {
	                $('#deleteDialog').dialog({
	                    width: 370,
	                    height: 250,
	                    modal: true
	                });
	            }
	        });
	    });
	</script>
</head>
<body>
	<br><br><br><br><br>
    <div align="center">
        <div class="col-lg-6">
            <div class="section_title text-center mb-70">
                <h3 class="wow fadeInUp">회원 정보 수정</h3>
            </div>
        </div>
    </div>
	<hr>
    <div class="get_in_tauch_area" style="padding-top: 50px">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="touch_form">
                        <div class="row">
                        	<div class="col-md-12" >
                                <div class="submit_btn wow fadeInUp">
                                    <button class="action boxed-btn3" onclick="location.href='UserLogout.do'">로그아웃</button>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="submit_btn wow fadeInUp" style="padding-top: 30px">
                                    <button action="modify" class="action boxed-btn3">비밀번호 변경</button>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="submit_btn wow fadeInUp" style="padding-top: 30px">
                                    <button action="delete" class="action boxed-btn3">회원 탈퇴</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- dialog form start-->
	<div id="modifyDialog" title="비밀번호 변경" class="get_in_tauch_area" style="padding: 0px">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="touch_form">
                    	<form action="UserModify_ok.do" method="post" name="mfrm">
                    	<input type="hidden" name="seq" value="<%=session.getAttribute("u_seq") %>" /> 
	                        <div class="row">
	                        	<fieldset>
		                            <div class="col-md-12" style="padding-top: 10px">
		                                <div class="single_input wow fadeInUp">
		                                    <input type="password" id="password" name="password" maxlength="20" placeholder="기존 비밀번호" />
		                                </div>
		                            </div>
		                            <div class="col-md-12" style="padding-top: 10px">
		                                <div class="single_input wow fadeInUp">
		                                    <input type="password" id="newPassword" name="newPassword" maxlength="20" placeholder="새 비밀번호" />
		                                </div>
		                            </div>
		                            <div class="col-md-12" style="padding-top: 10px">
		                                <div class="single_input wow fadeInUp">
		                                    <input type="password" id="newPasswordCheck" name="newPasswordCheck" maxlength="20" placeholder="새 비밀번호 확인" />
		                                </div>
		                            </div>
		                            <div class="col-md-12" style="padding-top: 30px">
		                                <div class="submit_btn wow fadeInUp">
		                                    <button id="mbtn" class="boxed-btn3">확인</button>
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
    
    <div id="deleteDialog" title="회원 탈퇴" class="get_in_tauch_area" style="padding: 0px">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="touch_form">
                    	<form action="UserDelete_ok.do" method="post" name="dfrm">
                    	<input type="hidden" name="seq" value="<%=session.getAttribute("u_seq") %>" /> 
	                        <div class="row">
	                        	<fieldset>
		                            <div class="col-md-12" style="padding-top: 10px">
		                                <div class="single_input wow fadeInUp">
		                                    <input type="password" id="passwordD" name="passwordD" maxlength="30" placeholder="비밀번호 확인" />
		                                </div>
		                            </div>
		                            <div class="col-md-12" style="padding-top: 30px">
		                                <div class="submit_btn wow fadeInUp">
		                                    <button class="boxed-btn3">탈퇴</button>
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
</body>
</html>