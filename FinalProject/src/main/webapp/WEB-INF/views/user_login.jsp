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
</head>
<body>
	<br><br><br>
    <div align="center">
        <div class="col-lg-6">
            <div class="section_title text-center mb-70">
                <span class="wow fadeInUp">Login</span>
                <h3 class="wow fadeInUp">로그인</h3>
            </div>
        </div>
    </div>
	<hr>
    <div class="get_in_tauch_area">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="touch_form">
                        <form action="UserLogin_ok.do" method="post">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="single_input wow fadeInUp">
                                        <input type="email" name="email" placeholder="ID(이메일)" required />
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="single_input wow fadeInUp">
                                        <input type="password" name="password" placeholder="Password" required />
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="submit_btn wow fadeInUp">
                                        <button class="boxed-btn3" type="submit">Sign in</button>
                                    </div>
                                </div>
                            </div>
                        </form>
                        <hr>
                        <div align="right">
                        	<a href="UserFindPassword.do">비밀번호 찾기 /</a>	
                        	<a href="UserSignup.do">회원가입</a>	
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>