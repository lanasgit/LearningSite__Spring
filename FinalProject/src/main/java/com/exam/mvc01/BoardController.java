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

import model.BoardTO;
import model.LcategoryTO;
import model.ScategoryTO;

@Controller
public class BoardController {
	
	@Autowired
	private Mapper mapper;
	
	@RequestMapping("list.do")
	public String list(Model model) {	
		
		ArrayList<LcategoryTO> LcategoryList = new ArrayList<LcategoryTO>();
		ArrayList<ScategoryTO> ScategoryList = new ArrayList<ScategoryTO>();
		
		LcategoryList = mapper.lacategoryList();
		ScategoryList = mapper.sacategoryList();
		
		model.addAttribute("LcategoryList", LcategoryList);
		model.addAttribute("ScategoryList", ScategoryList);
		
		return "board_list";
	}
	
	@RequestMapping("write.do")
	public String write() {
		
		return "board_write";
	}
	
	@RequestMapping("write_ok.do")
	public String writeOk(HttpServletRequest request, Model model) {
		
		// 자동 증가 컬럼(seq) 초기화
		mapper.boardSeq();
		
		BoardTO to = new BoardTO();
		to.setSubject(request.getParameter("subject"));
		to.setLink(request.getParameter("link"));
		to.setContent(request.getParameter("content"));
		to.setSseq(request.getParameter("scategory"));
		
		int flag = mapper.boardWriteOk(to);
		
		model.addAttribute("flag", flag);
				
		return "board_write_ok";
	}
	
	@RequestMapping("view.do")
	public String view(HttpServletRequest request, Model model) {
		
		// scategory의 seq와 name
		String sseq = request.getParameter("sseq");
		String sname = request.getParameter("sname");
		// lcategory의  name
		String lname = request.getParameter("lname");
		
		if (request.getParameter("seq") != null) {
			String seq = request.getParameter("seq");
			BoardTO to = mapper.boardView(seq);
			model.addAttribute("to", to);
			model.addAttribute("sname", sname);
			model.addAttribute("lname", lname);
		} else {
			BoardTO to = mapper.boardViewRecent(sseq);
			model.addAttribute("to", to);
			model.addAttribute("sname", sname);
			model.addAttribute("lname", lname);
		}
		
		ArrayList<LcategoryTO> LcategoryList = mapper.lacategoryList();
		ArrayList<ScategoryTO> ScategoryList = mapper.sacategoryList();
		ArrayList<BoardTO> BoardList = mapper.boardList(sseq);
		
		model.addAttribute("LcategoryList", LcategoryList);
		model.addAttribute("ScategoryList", ScategoryList);
		model.addAttribute("BoardList", BoardList);
		
		return "board_view";
	}
	
	@RequestMapping("modify.do")
	public String modify(HttpServletRequest request, Model model) {
		
		String seq = request.getParameter("seq");
		
		BoardTO to = new BoardTO();
		to = mapper.boardModify(seq);
		
		model.addAttribute("to", to);
		
		return "board_modify";
	}
	
	@RequestMapping("modify_ok.do")
	public String modifyOk(HttpServletRequest request, Model model) {
		
		BoardTO to = new BoardTO();
		to.setSeq(request.getParameter("seq"));
		to.setSubject(request.getParameter("subject"));
		to.setLink(request.getParameter("link"));
		to.setContent(request.getParameter("content"));
		to.setSseq(request.getParameter("scategory"));
		
		int flag = mapper.boardModifyOk(to);
		
		model.addAttribute("flag", flag);
		
		return "board_modify_ok";
	}
	
	@RequestMapping("delete.do")
	public String delete(HttpServletRequest request, Model model) {
		
		String seq = request.getParameter("seq");
		
		BoardTO to = new BoardTO();
		to = mapper.boardDelete(seq);
		
		model.addAttribute("to", to);
		
		return "board_delete";
	}
	
	@RequestMapping("delete_ok.do")
	public String deleteOk(HttpServletRequest request, Model model) {
		
		String seq = request.getParameter("seq");
		
		int flag = mapper.boardDeleteOk(seq);
		
		model.addAttribute("flag", flag);
		
		return "board_delete_ok";
	}
	
	@RequestMapping("categorySet.do")
	public String categorySet() {
		
		return "category_set";
	}
	
	@RequestMapping("lcategoryWrite_ok.do")
	public @ResponseBody JSONObject lcategoryWriteOk(HttpServletRequest request){
		
		// 자동 증가 컬럼(seq) 초기화
		mapper.lcategorySeq();
		
		String name = request.getParameter("name");
		
		int flag = mapper.lcategoryWriteOk(name);
		
		JSONObject result = new JSONObject();
		result.put("flag", flag);
		
		return result;
	}
	
	@RequestMapping("lcategoryModify.do")
	public @ResponseBody JSONObject lcategoryModify(HttpServletRequest request){
		
		String seq = request.getParameter("seq");
		
		LcategoryTO lto = mapper.lcategoryModify(seq);
		
		JSONObject result = new JSONObject();
		result.put("name", lto.getName());
		
		return result;
	}
	
	@RequestMapping("lcategoryModify_ok.do")
	public @ResponseBody JSONObject lcategoryModifyOk(HttpServletRequest request){
		
		String seq = request.getParameter("seq");
		String name = request.getParameter("name");
		
		LcategoryTO lto = new LcategoryTO();
		lto.setSeq(seq);
		lto.setName(name);
		
		int flag = mapper.lcategoryModifyOk(lto);
		
		JSONObject result = new JSONObject();
		result.put("flag", flag);
		
		return result;
	}
	
	@RequestMapping("lcategoryDelete.do")
	public @ResponseBody JSONObject lcategoryDelete(HttpServletRequest request){
		
		String seq = request.getParameter("seq");
		
		LcategoryTO lto = mapper.lcategoryDelete(seq);
		
		JSONObject result = new JSONObject();
		result.put("name", lto.getName());
		
		return result;
	}
	
	@RequestMapping("lcategoryDelete_ok.do")
	public @ResponseBody JSONObject lcategoryDeleteOk(HttpServletRequest request){
		
		String seq = request.getParameter("seq");
		String name = request.getParameter("name");
		
		LcategoryTO lto = new LcategoryTO();
		lto.setSeq(seq);
		lto.setName(name);
		
		int flag = mapper.lcategoryDeleteOk(lto);
		
		JSONObject result = new JSONObject();
		result.put("flag", flag);
		
		return result;
	}
	
	@RequestMapping("scategoryWrite_ok.do")
	public @ResponseBody JSONObject scategoryWriteOk(HttpServletRequest request){
		
		// 자동 증가 컬럼(seq) 초기화
		mapper.scategorySeq();
		
		String name = request.getParameter("name");
		String lseq = request.getParameter("lseq");
		
		ScategoryTO lto = new ScategoryTO();
		lto.setName(name);
		lto.setLseq(lseq);
		
		int flag = mapper.scategoryWriteOk(lto);
		
		JSONObject result = new JSONObject();
		result.put("flag", flag);
		
		return result;
	}
	
	@RequestMapping("scategoryModify.do")
	public @ResponseBody JSONObject scategoryModify(HttpServletRequest request){
		
		String seq = request.getParameter("seq");
		
		ScategoryTO lto = mapper.scategoryModify(seq);
		
		JSONObject result = new JSONObject();
		result.put("name", lto.getName());
		
		return result;
	}
	
	@RequestMapping("scategoryModify_ok.do")
	public @ResponseBody JSONObject scategoryModifyOk(HttpServletRequest request){
		
		String seq = request.getParameter("seq");
		String name = request.getParameter("name");
		
		ScategoryTO lto = new ScategoryTO();
		lto.setSeq(seq);
		lto.setName(name);
		
		int flag = mapper.scategoryModifyOk(lto);
		
		JSONObject result = new JSONObject();
		result.put("flag", flag);
		
		return result;
	}
	
	@RequestMapping("scategoryDelete.do")
	public @ResponseBody JSONObject scategoryDelete(HttpServletRequest request){
		
		String seq = request.getParameter("seq");
		
		ScategoryTO lto = mapper.scategoryDelete(seq);
		
		JSONObject result = new JSONObject();
		result.put("name", lto.getName());
		
		return result;
	}
	
	@RequestMapping("scategoryDelete_ok.do")
	public @ResponseBody JSONObject scategoryDeleteOk(HttpServletRequest request){
		
		String seq = request.getParameter("seq");
		String name = request.getParameter("name");
		
		ScategoryTO lto = new ScategoryTO();
		lto.setSeq(seq);
		lto.setName(name);
		
		int flag = mapper.scategoryDeleteOk(lto);
		
		JSONObject result = new JSONObject();
		result.put("flag", flag);
		
		return result;
	}
	
	@RequestMapping("lcategorySelect.do")
	public @ResponseBody JSONObject lcategoryList(){
		
		ArrayList<LcategoryTO> list = mapper.lcategorySelect();
		
		JSONArray jsonArray = new JSONArray();
		for (LcategoryTO lto : list) {
			JSONObject obj = new JSONObject();
			obj.put("seq", lto.getSeq());
			obj.put("name", lto.getName());
			
			jsonArray.add(obj);
		}
		
		JSONObject result = new JSONObject();
		result.put("data", jsonArray);
		
		return result;
	}
	
	@RequestMapping("scategorySelect.do")
	public @ResponseBody JSONObject scategoryList(HttpServletRequest request){
		
		String lseq = request.getParameter("lseq");
		
		ArrayList<ScategoryTO> list = mapper.scategorySelect(lseq);
		
		JSONArray jsonArray = new JSONArray();
		for (ScategoryTO sto : list) {
			JSONObject obj = new JSONObject();
			obj.put("seq", sto.getSeq());
			obj.put("name", sto.getName());
			
			jsonArray.add(obj);
		}
		
		JSONObject result = new JSONObject();
		result.put("data", jsonArray);
		
		return result;
	}
	
}
