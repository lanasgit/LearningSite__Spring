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
    <script type="text/javascript" src="js/jquery-3.5.1.js"></script>
    <script type="text/javascript">
    	$(document).ready(function() {
			$(document).on('click', '#btn', function() {
				checkEmail();
				if ($('#emailCheck').val() == '0') {
					alert('회원정보가 없습니다.');
					return false;
				}
			});
	    });
    	
    	var checkEmail = function() {
			$.ajax({
				url: 'UserSignupCheck.do',
				data: {
					email: $('#email').val()
				},
				type: 'get',
				dataType: 'json',
				async: false,
				success: function(json) {
					
					if (json.flag == 0) {
						$('#emailCheck').val('0');
					} else {
						$('#emailCheck').val('1');
					}
					
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
	<br><br><br><br><br>
    <div align="center">
        <div class="col-lg-6">
            <div class="section_title text-center mb-70">
                <h3 class="wow fadeInUp">비밀번호 찾기</h3>
            </div>
        </div>
    </div>
	<hr>
    <div class="get_in_tauch_area">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="touch_form">
                        <form action="UserFindPasswordEmail.do" method="post">
                        <input type="hidden" id="emailCheck" value="0" />
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="single_input wow fadeInUp">
                                        <input type="email" id="email" name="email" placeholder="ID(이메일)" required />
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="submit_btn wow fadeInUp">
                                        <button id="btn" class="boxed-btn3" type="submit">비밀번호 찾기</button>
                                    </div>
                                </div>
                            </div>
                        </form>
                        <hr>
                        <div align="right">
                        	<a href="UserSignup.do">회원가입</a>	
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
</body>
</html>