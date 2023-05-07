package com.itwillbs.member.action;

import java.sql.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itwillbs.commons.Action;
import com.itwillbs.commons.ActionForward;
import com.itwillbs.member.db.ProductDAO;
import com.itwillbs.member.db.ProductDTO;

public class ProductContentAction implements Action {

@Override
public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	System.out.println("P : ProductContentAction_execute() 호출");
	
	// 상세 페이지를 보기 위해 상품번호를 가져옴
	int productId = Integer.parseInt(request.getParameter("product_id"));
	
	// DAO 객체 생성
	ProductDAO dao = new ProductDAO();
	// 상세 정보 가져오기
	ProductDTO product = dao.productContetnt(productId);
	
	// 상세 정보 request에 저장
	request.setAttribute("product", product);
	
	// 페이지 이동
	ActionForward forward = new ActionForward();
	forward.setPath("./ProductContent.me");
	forward.setRedirect(false);
	
	return forward;
}
}