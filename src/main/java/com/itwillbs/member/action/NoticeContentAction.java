package com.itwillbs.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.itwillbs.commons.Action;
import com.itwillbs.commons.ActionForward;
import com.itwillbs.member.db.MemberDAO;
import com.itwillbs.member.db.NoticeDTO;

public class NoticeContentAction implements Action{

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("M: NoticeContentAction_execute()메소드 호출!");
		
		NoticeDTO dto = new NoticeDTO();
		
//		HttpSession session = request.getSession();
//		String notice_id = (String) session.getAttribute("notice_id");
		
		String notice_id = request.getParameter("notice_id");
		String pageNum = request.getParameter("pageNum");
//		System.out.println("여기여기보세요================"+notice_id);
		
		ActionForward forward = new ActionForward();
		
		MemberDAO dao = new MemberDAO();

		NoticeDTO dto1 = dao.getNoticeContent(notice_id);
		
		request.setAttribute("dto", dto1);
		request.setAttribute("pageNum", pageNum);
		
		forward.setPath("./notice/noticeContent.jsp");
		forward.setRedirect(false);
		
		
		
		
		
		
		return forward;
	}

}
