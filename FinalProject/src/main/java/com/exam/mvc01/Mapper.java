package com.exam.mvc01;

import java.util.ArrayList;

import model.BoardTO;
import model.CommentTO;
import model.GalleryTO;
import model.GuestbookTO;
import model.LcategoryTO;
import model.ManagerTO;
import model.ScategoryTO;
import model.UserTO;

public interface Mapper {
	
	public abstract ArrayList<LcategoryTO> lacategoryList();
	public abstract ArrayList<ScategoryTO> sacategoryList();
	public abstract void lcategorySeq();
	public abstract int lcategoryWriteOk(String name);
	public abstract LcategoryTO lcategoryModify(String seq);
	public abstract int lcategoryModifyOk(LcategoryTO lto);
	public abstract LcategoryTO lcategoryDelete(String seq);
	public abstract int lcategoryDeleteOk(LcategoryTO lto);
	public abstract void scategorySeq();
	public abstract int scategoryWriteOk(ScategoryTO sto);
	public abstract ScategoryTO scategoryModify(String seq);
	public abstract int scategoryModifyOk(ScategoryTO lto);
	public abstract ScategoryTO scategoryDelete(String seq);
	public abstract int scategoryDeleteOk(ScategoryTO lto);
	public abstract ArrayList<LcategoryTO> lcategorySelect();
	public abstract ArrayList<ScategoryTO> scategorySelect(String lseq);
	public abstract ArrayList<BoardTO> boardList(String sseq);
	public abstract void boardSeq();
	public abstract int boardWriteOk(BoardTO to);
	public abstract BoardTO boardView(String seq);
	public abstract BoardTO boardViewRecent(String sseq);
	public abstract BoardTO boardModify(String seq);
	public abstract int boardModifyOk(BoardTO to);
	public abstract BoardTO boardDelete(String seq);
	public abstract int boardDeleteOk(String seq);
	
	public abstract ArrayList<CommentTO> commentList(String cseq);
	public abstract void commentSeq();
	public abstract int commentWriteOk(CommentTO cto);
	public abstract CommentTO commentModify(String seq);
	public abstract int commentModifyOk(CommentTO cto);
	public abstract CommentTO commentDelete(String seq);
	public abstract int commentDeleteOk(CommentTO cto);
	public abstract int commentManagerDeleteOk(String seq);
	
	public abstract ArrayList<GuestbookTO> guestbookList();
	public abstract void guestbookSeq();
	public abstract int guestbookWriteOk(GuestbookTO gto);
	public abstract GuestbookTO guestbookModify(String seq);
	public abstract int guestbookModifyOk(GuestbookTO gto);
	public abstract GuestbookTO guestbookDelete(String seq);
	public abstract int guestbookDeleteOk(GuestbookTO gto);
	public abstract int guestbookManagerDeleteOk(String seq);
	
	public abstract ArrayList<GalleryTO> galleryMain();
	public abstract ArrayList<GalleryTO> galleryList(Integer pageStart);
	public abstract int galleryTotal();
	public abstract void gallerySeq();
	public abstract int galleryWriteOk(GalleryTO gto);
	public abstract GalleryTO galleryModify(String seq);
	public abstract int galleryModifyOk(GalleryTO gto);
	public abstract GalleryTO galleryDelete(String seq);
	public abstract int galleryDeleteOk(String seq);
	
	public abstract int ManagerLoginOk(ManagerTO mto);
	
	public abstract int UserSignupCheck(String email);
	public abstract int UserSignupOk(UserTO uto);
	public abstract UserTO UserLoginOk(UserTO uto);
	public abstract UserTO UserModify(UserTO uto);
	public abstract int UserModifyOk(UserTO uto);
	public abstract UserTO UserDelete(UserTO uto);
	public abstract int UserDeleteOk(String seq);
	public abstract UserTO UserFindPassword(String email);
	public abstract int UserFindPasswordOk(UserTO uto);
}