package com.exam.mvc01;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import model.MailSender;
import model.UserTO;

@Controller
public class UserController {
	
	@Autowired
	private Mapper mapper;
	
	@RequestMapping("UserLogin.do")
	public String UserLogin() {
		
		return "user_login";
	}
	
	@RequestMapping("UserLogin_ok.do")
	public String UserLoginOk(HttpServletRequest request, Model model) {
		
		int flag = 0;
		
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		
		UserTO to = new UserTO();
		to.setEmail(email);
		to.setPassword(password);
		
		UserTO uto = mapper.UserLoginOk(to);
		if (uto != null) {
			flag = 1;
		}
		
		model.addAttribute("flag", flag);
		model.addAttribute("uto", uto);
		
		return "user_login_ok";
	}
	
	@RequestMapping("UserLogout.do")
	public String UserLogout() {
		
		return "session_logout";
	}
	
	@RequestMapping("UserSignup.do")
	public String UserSignup() {
		
		return "user_signup";
	}
	
	@RequestMapping("UserSignupCheck.do")
	public @ResponseBody JSONObject UserSignupCheck(HttpServletRequest request) {
		
		String email = request.getParameter("email");
		
		int flag = mapper.UserSignupCheck(email);
		
		JSONObject result = new JSONObject();
		result.put("flag", flag);
		
		return result;
	}
	
	@RequestMapping("UserSignupEmail.do")
	public String UserSignupEmail(HttpServletRequest request, Model model) {
		
		int code = (int)(Math.random() * 999999) + 100000;
		
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		
		UserTO uto = new UserTO();
		uto.setName(name);
		uto.setEmail(email);
		uto.setPassword(password);
		
		String subject = "(가입 인증코드 발송)안녕하세요. 교육 사이트입니다.";
		String content = code + " <- 이 인증코드를 입력해주시면 가입이 완료됩니다.";
		
		MailSender mailSender = new MailSender();
		mailSender.sendMail(email, name, subject, content);
		
		model.addAttribute("uto", uto);
		model.addAttribute("code", code);
		
		return "user_signup_email";
	}
	
	@RequestMapping("UserSignup_ok.do")
	public String UserSignupOk(HttpServletRequest request, Model model) {
		
		UserTO uto = new UserTO();
		uto.setName(request.getParameter("name"));
		uto.setEmail(request.getParameter("email"));
		uto.setPassword(request.getParameter("password"));
		
		int flag = mapper.UserSignupOk(uto);
		
		model.addAttribute("flag", flag);
		
		return "user_signup_ok";
	}
	
	@RequestMapping("UserModify.do")
	public String UserModify() {
		
		return "user_modify";
	}
	
	@RequestMapping("UserModify_ok.do")
	public String UserModifyOk(HttpServletRequest request, Model model) {
		
		String seq = request.getParameter("seq");
		String password = request.getParameter("password");
		String newPassword = request.getParameter("newPassword");
		
		UserTO newUto = new UserTO();
		newUto.setSeq(seq);
		newUto.setPassword(newPassword);
		
		int flag = 0;
		
		UserTO to = new UserTO();
		to.setSeq(seq);
		to.setPassword(password);
		
		UserTO uto = mapper.UserModify(to);
		if (uto != null) {
			flag = mapper.UserModifyOk(newUto);
		}
		
		model.addAttribute("flag", flag);
		
		return "user_modify_ok";
	}
	
	@RequestMapping("UserDelete_ok.do")
	public String UserDeleteOk(HttpServletRequest request, Model model) {
		
		String seq = request.getParameter("seq");
		String password = request.getParameter("passwordD");
		
		int flag = 0;
		
		UserTO to = new UserTO();
		to.setSeq(seq);
		to.setPassword(password);
		
		UserTO uto = mapper.UserDelete(to);
		if (uto != null) {
			flag = mapper.UserDeleteOk(seq);
		}
		
		model.addAttribute("flag", flag);
		
		return "user_delete_ok";
	}
	
	@RequestMapping("UserFindPassword.do")
	public String UserFindPassword() {
		
		return "user_findpassword";
	}
	
	@RequestMapping("UserFindPasswordEmail.do")
	public String UserFindPasswordEmail(HttpServletRequest request, Model model) {
		
		String email = request.getParameter("email");
		
		int code = (int)(Math.random() * 999999) + 100000;
		
		UserTO uto = mapper.UserFindPassword(email);
		String name = uto.getName();
		
		String subject = "(비밀번호 찾기)안녕하세요. 교육 사이트입니다.";
		String content = code + " <- 이 인증코드를 입력해주시면 임시 비밀번호가 발급됩니다.";
		
		MailSender mailSender = new MailSender();
		mailSender.sendMail(email, name, subject, content);
		
		model.addAttribute("uto", uto);
		model.addAttribute("code", code);
		
		return "user_findpassword_email";
	}
	
	@RequestMapping("UserFindPassword_ok.do")
	public String UserFindPasswordOk(HttpServletRequest request, Model model) {
		
		String seq = request.getParameter("seq");
		String passwordTemp = String.valueOf((int)(Math.random() * 999) + 100);
		
		UserTO uto = new UserTO();
		uto.setSeq(seq);
		uto.setPassword(passwordTemp);
		
		int flag = mapper.UserFindPasswordOk(uto);
		
		model.addAttribute("flag", flag);
		model.addAttribute("passwordTemp", passwordTemp);
		
		return "user_findpassword_ok";
	}
	
}
