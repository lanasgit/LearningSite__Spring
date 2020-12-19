<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.UserTO"%>
<%	
	UserTO uto = (UserTO)request.getAttribute("uto");
	int code = (Integer)request.getAttribute("code");
	
	String name = uto.getName();
	String email = uto.getEmail();
	String password = uto.getPassword();
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
    <script type="text/javascript">
	    window.onload = function() {
   			document.getElementById('btn').onclick = function() {
   				if (document.frm.code.value.trim() != document.frm.usercode.value.trim()) {
   					alert('인증코드를 다시 확인해주세요.');
   					return false;
   				}
   			};
	    };
	</script>
</head>
<body>
	<br><br><br>
    <div align="center">
        <div class="col-lg-6">
            <div class="section_title text-center mb-70">
                <span class="wow fadeInUp" data-wow-duration="1s" data-wow-delay=".1s">Sing up</span>
                <h3 class="wow fadeInUp" data-wow-duration="1.2s" data-wow-delay=".2s">회원가입</h3>
            </div>
        </div>
    </div>
	<hr>
    <div class="get_in_tauch_area">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="touch_form">
                        <form action="UserSignup_ok.do" method="post" name="frm">
                        <input type="hidden" name="code" value="<%=code %>" />
                        <input type="hidden" name="name" value="<%=name %>" />
                        <input type="hidden" name="email" value="<%=email %>" />
                        <input type="hidden" name="password" value="<%=password %>" />
                            <div class="row">
                            	 <div class="col-md-12">
                                    <div class="single_input wow fadeInUp">
                                       <textarea cols="30" rows="10" maxlength="1000" readonly>입력하신 이메일 주소로 인증 메일을 전송했습니다. 인증 코드를 입력하시면 회원가입이 완료됩니다. 
혹시, 못 받으셨다면 스팸메일함을 확인해주세요!
                                       </textarea>
                                    </div>
                                </div>
	                            <div class="col-md-12">
	                                <div class="single_input wow fadeInUp">
	                                    <input type="text" name="usercode" placeholder="인증코드" required />
	                                </div>
	                            </div>
	                            <div class="col-md-12">
                                    <div class="submit_btn wow fadeInUp">
                                        <button id="btn" class="boxed-btn3" type="submit">확인</button>
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