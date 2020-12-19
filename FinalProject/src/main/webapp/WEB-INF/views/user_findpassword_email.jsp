<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.UserTO"%>
<%	
	UserTO uto = (UserTO)request.getAttribute("uto");
	int code = (Integer)request.getAttribute("code");
	
	String seq = uto.getSeq();
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
	<br><br><br><br><br>
    <div align="center">
        <div class="col-lg-6">
            <div class="section_title text-center mb-70">
                <h3 class="wow fadeInUp">임시 비밀번호 발급</h3>
                <span class="wow fadeInUp">E-mail 발송 완료</span>
            </div>
        </div>
    </div>
	<hr>
    <div class="get_in_tauch_area">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="touch_form">
                        <form action="UserFindPassword_ok.do" method="post" name="frm">
                        <input type="hidden" name="code" value="<%=code %>" />
                        <input type="hidden" name="seq" value="<%=seq %>" />
                            <div class="row">
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