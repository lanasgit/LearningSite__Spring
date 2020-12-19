package com.exam.mvc01;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import model.GalleryListTO;
import model.GalleryTO;

@Controller
public class GalleryController {
	
	@Autowired
	private Mapper mapper;
	
	@RequestMapping("galleryMain.do")
	public @ResponseBody JSONObject galleryMain() {
		
		ArrayList<GalleryTO> lists = mapper.galleryMain();
		
		JSONArray jsonArray = new JSONArray();
		for (GalleryTO gto : lists) {
			JSONObject obj = new JSONObject();
			obj.put("subject", gto.getSubject());
			obj.put("filename", gto.getFilename());
			
			jsonArray.add(obj);
		}
		
		JSONObject result = new JSONObject();
		result.put("data", jsonArray);
		
		return result;
	}
	
	@RequestMapping("galleryList.do")
	public String galleryList(HttpServletRequest request, Model model) {
		
		int cpage = 1;
		if (request.getParameter("cpage") != null && !request.getParameter("cpage").equals("")) {
			cpage = Integer.parseInt(request.getParameter("cpage"));
		}
		
		GalleryListTO listTO = new GalleryListTO();
		listTO.setCpage(cpage);
		
		int recordPerPage = listTO.getRecordPerPage();
		int blockPerPage = listTO.getBlockPerPage();
		int totalRecord = mapper.galleryTotal();
		
		listTO.setTotalPage(((totalRecord - 1) / recordPerPage) + 1);
		listTO.setStartBlock(((cpage - 1) / blockPerPage) * blockPerPage + 1);
		listTO.setEndBlock(((cpage - 1) / blockPerPage) * blockPerPage + blockPerPage);
		if (listTO.getEndBlock() >= listTO.getTotalPage()) {
			listTO.setEndBlock (listTO.getTotalPage());
		}
		
		int pageStart = (cpage - 1) * recordPerPage;
		ArrayList<GalleryTO> lists = mapper.galleryList(pageStart);
		listTO.setGalleryList(lists);
		
		model.addAttribute("lists",lists);
		model.addAttribute("listTO",listTO);
		
		return "gallery_list";
	}
	
	@RequestMapping("galleryWrite_ok.do")
	public String galleryWriteOk(MultipartHttpServletRequest requestM, HttpServletRequest request, Model model) {
		
		// 자동 증가 컬럼(seq) 초기화
		mapper.gallerySeq();
		
		int flag = 0;
		
		String uploadPath = request.getSession().getServletContext().getRealPath("/") + "resources/upload/";
		
		Iterator<String> iterator = requestM.getFileNames();
		String uploadFile = iterator.next();
		MultipartFile mFile = requestM.getFile(uploadFile);
		
		String orgfileName = mFile.getOriginalFilename();	// 원본 파일명
		String saveFilename = "";							// DB에 저장할 변환된 파일명
		
		if (orgfileName != null) {
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("-yyyyMMddHHmmss");
			Calendar calendar = Calendar.getInstance();
			saveFilename = orgfileName + simpleDateFormat.format(calendar.getTime());
		}
		
		try {
			mFile.transferTo(new File(uploadPath + saveFilename));
			GalleryTO gto = new GalleryTO();
			gto.setSubject(request.getParameter("w_subject"));
			gto.setFilename(saveFilename);
			
			flag = mapper.galleryWriteOk(gto);
			
		} catch (IOException e) {
			System.out.println("[에러] : " + e.getMessage());
		}
		
		model.addAttribute("flag", flag);
		
		return "gallery_write_ok";
	}
	
	@RequestMapping("galleryModify.do")
	public @ResponseBody JSONObject galleryModify(HttpServletRequest request) {
		
		String seq = request.getParameter("seq");
		
		GalleryTO gto = mapper.galleryModify(seq);
		
		JSONObject result = new JSONObject();
		result.put("seq", gto.getSeq());
		result.put("subject", gto.getSubject());
		result.put("filename", gto.getFilename());
		
		return result;
	}
	
	@RequestMapping("galleryModify_ok.do")
	public String galleryModifyOk(MultipartHttpServletRequest requestM, HttpServletRequest request, Model model) {
		
		int flag = 0;
		
		String uploadPath = request.getSession().getServletContext().getRealPath("/") + "resources/upload/";
		
		Iterator<String> iterator = requestM.getFileNames();
		String uploadFile = iterator.next();
		MultipartFile mFile = requestM.getFile(uploadFile);
		
		String newfileName = mFile.getOriginalFilename();
		String newSaveFilename = "";
		
		if (newfileName != null) {
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("-yyyyMMddHHmmss");
			Calendar calendar = Calendar.getInstance();
			newSaveFilename = newfileName + simpleDateFormat.format(calendar.getTime());
		}
		
		try {
			String oldFilename = request.getParameter("filename");
			
			GalleryTO gto = new GalleryTO();
			gto.setSeq(request.getParameter("m_seq"));
			gto.setSubject(request.getParameter("m_subject"));
			
			if (newfileName != "") {
				mFile.transferTo(new File(uploadPath + newSaveFilename));
				gto.setFilename(newSaveFilename);
			} else {
				gto.setFilename(oldFilename);
			}
			
			flag = mapper.galleryModifyOk(gto);
			
			if (flag == 1 && newfileName != "") {
				File file = new File(uploadPath + oldFilename);
				file.delete();
			}
			
		} catch (IOException e) {
			System.out.println("[에러] : " + e.getMessage());
		}
		
		model.addAttribute("flag", flag);
		
		return "gallery_modify_ok";
	}
	
	@RequestMapping("galleryDelete.do")
	public @ResponseBody JSONObject galleryDelete(HttpServletRequest request) {
		
		String seq = request.getParameter("seq");
		
		GalleryTO gto = mapper.galleryDelete(seq);
		
		JSONObject result = new JSONObject();
		result.put("seq", gto.getSeq());
		result.put("subject", gto.getSubject());
		result.put("filename", gto.getFilename());
		
		return result;
	}
	
	@RequestMapping("galleryDelete_ok.do")
	public String galleryDeleteOk(HttpServletRequest request, Model model) {
		
		String uploadPath = request.getSession().getServletContext().getRealPath("/") + "resources/upload/";
		
		String seq = request.getParameter("d_seq");
		String filename = request.getParameter("d_filename");
		
		int flag = mapper.galleryDeleteOk(seq);
		
		if (flag == 1) {
			File file = new File(uploadPath + filename);
			file.delete();
		}
		
		model.addAttribute("flag", flag);
		
		return "gallery_delete_ok";
	}
	
}
