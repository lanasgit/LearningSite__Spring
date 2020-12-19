package com.exam.mvc01;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import model.GuestbookTO;

@Controller
public class GuestbookController {
	
	@Autowired
	private Mapper mapper;
	
	@RequestMapping("guestbookList.do")
	public @ResponseBody JSONObject guestbookList() {
		
		ArrayList<GuestbookTO> lists = mapper.guestbookList();
		
		JSONArray jsonArray = new JSONArray();
		for (GuestbookTO gto : lists) {
			JSONObject obj = new JSONObject();
			obj.put("seq", gto.getSeq());
			obj.put("writer", gto.getWriter());
			obj.put("content", gto.getContent());
			obj.put("wdate", gto.getWdate());
			
			jsonArray.add(obj);
		}
		
		JSONObject result = new JSONObject();
		result.put("data", jsonArray);
		
		return result;
	}
	
	@RequestMapping("guestbookWrite_ok.do")
	public @ResponseBody JSONObject guestbookWriteOk(HttpServletRequest request) {
		
		// 자동 증가 컬럼(seq) 초기화
		mapper.guestbookSeq();
		
		GuestbookTO gto = new GuestbookTO();
		gto.setWriter(request.getParameter("writer"));
		gto.setPassword(request.getParameter("password"));
		gto.setContent(request.getParameter("content"));
		
		int flag = mapper.guestbookWriteOk(gto);
		
		JSONObject result = new JSONObject();
		result.put("flag", flag);
		
		return result;
	}
	
	@RequestMapping("guestbookModify.do")
	public String guestbookModify(HttpServletRequest request, Model model) {
		
		String seq = request.getParameter("seq");
		
		GuestbookTO gto = mapper.guestbookModify(seq);
		
		model.addAttribute("gto", gto);
		
		return "guestbook_modify";
	}
	
	@RequestMapping("guestbookModify_ok.do")
	public String guestbookModifyOk(HttpServletRequest request, Model model) {
		
		String seq = request.getParameter("seq");
		String password = request.getParameter("password");
		String content = request.getParameter("content");
		
		GuestbookTO gto = new GuestbookTO();
		gto.setSeq(seq);
		gto.setPassword(password);
		gto.setContent(content);
		
		int flag = mapper.guestbookModifyOk(gto);
		
		model.addAttribute("flag", flag);
		
		return "guestbook_modify_ok";
	}
	
	@RequestMapping("guestbookDelete.do")
	public String guestbookDelete(HttpServletRequest request, Model model) {
		
		String seq = request.getParameter("seq");
		
		GuestbookTO gto = mapper.guestbookDelete(seq);
		
		model.addAttribute("gto", gto);
		
		return "guestbook_delete";
	}
	
	@RequestMapping("guestbookDelete_ok.do")
	public String guestbookDeleteOk(HttpServletRequest request, Model model) {
		
		String seq = request.getParameter("seq");
		String password = request.getParameter("password");
		
		GuestbookTO gto = new GuestbookTO();
		gto.setSeq(seq);
		gto.setPassword(password);
		
		int flag = mapper.guestbookDeleteOk(gto);
		
		model.addAttribute("flag", flag);
		
		return "guestbook_delete_ok";
	}
	
	@RequestMapping("guestbookManagerDelete_ok.do")
	public String guestbookManagerDeleteOk(HttpServletRequest request, Model model) {
		
		String seq = request.getParameter("seq");
		
		int flag = mapper.guestbookManagerDeleteOk(seq);
		
		model.addAttribute("flag", flag);
		
		return "guestbook_delete_ok";
	}
	
}
