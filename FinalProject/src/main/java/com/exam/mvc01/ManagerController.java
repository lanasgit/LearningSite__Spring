package com.exam.mvc01;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import model.ManagerTO;

@Controller
public class ManagerController {
	
	@Autowired
	private Mapper mapper;
	
	@RequestMapping("ManagerLogin.do")
	public String ManagerLogin() {
		
		return "manager_login";
	}
	
	@RequestMapping("ManagerLogin_ok.do")
	public String ManagerLoginOk(HttpServletRequest request, Model model) {
		
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		
		ManagerTO mto = new ManagerTO();
		mto.setId(id);
		mto.setPassword(password);
		
		int flag = mapper.ManagerLoginOk(mto);

		model.addAttribute("flag", flag);
		model.addAttribute("id", id);
		
		return "manager_login_ok";
	}
	
	@RequestMapping("ManagerLogout.do")
	public String ManagerLogout() {
		
		return "session_logout";
	}
	
}
