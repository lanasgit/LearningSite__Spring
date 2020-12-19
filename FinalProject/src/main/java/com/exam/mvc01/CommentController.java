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

import model.CommentTO;

@Controller
public class CommentController {
	
	@Autowired
	private Mapper mapper;
	
	@RequestMapping("commentList.do")
	public @ResponseBody JSONObject commentList(HttpServletRequest request) {
		
		String cseq = request.getParameter("cseq");
		
		ArrayList<CommentTO> lists = mapper.commentList(cseq);
		
		JSONArray jsonArray = new JSONArray();
		for (CommentTO cto : lists) {
			JSONObject obj = new JSONObject();
			obj.put("seq", cto.getSeq());
			obj.put("writer", cto.getWriter());
			obj.put("content", cto.getContent());
			obj.put("cdate", cto.getCdate());
			
			jsonArray.add(obj);
		}
		
		JSONObject result = new JSONObject();
		result.put("data", jsonArray);
		
		return result;
	}
	
	@RequestMapping("commentWrite_ok.do")
	public @ResponseBody JSONObject commentWriteOk(HttpServletRequest request) {
		
		// 자동 증가 컬럼(seq) 초기화
		mapper.commentSeq();
		
		CommentTO cto = new CommentTO();
		cto.setWriter(request.getParameter("writer"));
		cto.setPassword(request.getParameter("password"));
		cto.setContent(request.getParameter("content"));
		cto.setCseq(request.getParameter("cseq"));
		
		int flag = mapper.commentWriteOk(cto);
		
		JSONObject result = new JSONObject();
		result.put("flag", flag);
		
		return result;
	}
	
	@RequestMapping("commentModify.do")
	public String commentModify(HttpServletRequest request, Model model) {
		
		String seq = request.getParameter("seq");
		
		CommentTO cto = mapper.commentModify(seq);
		
		model.addAttribute("cto", cto);
		
		return "comment_modify";
	}
	
	@RequestMapping("commentModify_ok.do")
	public String commentModifyOk(HttpServletRequest request, Model model) {
		
		String seq = request.getParameter("seq");
		String password = request.getParameter("password");
		String content = request.getParameter("content");
		
		CommentTO cto = new CommentTO();
		cto.setSeq(seq);
		cto.setPassword(password);
		cto.setContent(content);
		
		int flag = mapper.commentModifyOk(cto);
		
		model.addAttribute("flag", flag);
		
		return "comment_modify_ok";
	}
	
	@RequestMapping("commentDelete.do")
	public String commentDelete(HttpServletRequest request, Model model) {
		
		String seq = request.getParameter("seq");
		
		CommentTO cto = mapper.commentDelete(seq);
		
		model.addAttribute("cto", cto);
		
		return "comment_delete";
	}
	
	@RequestMapping("commentDelete_ok.do")
	public String commentDeleteOk(HttpServletRequest request, Model model) {
		
		String seq = request.getParameter("seq");
		String password = request.getParameter("password");
		
		CommentTO cto = new CommentTO();
		cto.setSeq(seq);
		cto.setPassword(password);
		
		int flag = mapper.commentDeleteOk(cto);
		
		model.addAttribute("flag", flag);
		
		return "comment_delete_ok";
	}
	
	@RequestMapping("commentManagerDelete_ok.do")
	public String commentManagerDeleteOk(HttpServletRequest request, Model model) {
		
		String seq = request.getParameter("seq");
		
		int flag = mapper.commentManagerDeleteOk(seq);
		
		model.addAttribute("flag", flag);
		
		return "comment_delete_ok";
	}
	
}
