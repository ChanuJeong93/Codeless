package com.itwillbs.action.member;

import java.io.PrintWriter;
import java.net.Authenticator;
import java.util.Date;
import java.util.Properties;

import javax.mail.*;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.itwillbs.commons.Action;
import com.itwillbs.commons.ActionForward;
import com.itwillbs.commons.JSForward;
import com.itwillbs.db.MemberDAO;
import com.itwillbs.db.MemberDTO;

public class PwFindAction implements Action {


	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println(" M : PwFindAction_execute() 호출 ");
		System.out.println(" M :임시 비밀번호 전송");
		
		request.setCharacterEncoding("UTF-8");
		ActionForward forward = new ActionForward();
		
		
		//전달정보(name, phone_number) - dto에 저장

		MemberDAO dao = new MemberDAO();
		String id = request.getParameter("id");
		String email = dao.emailCheck(id);
		
		
		String randomPw = "";
		for (int i = 0; i < 12; i++) {
			randomPw += (char) ((Math.random() * 26) + 97);
		}
		System.out.println("임시 비밀번호 생성");
		
		//입력받은 아이디의 이메일 불러오기
		if(!email.equals("no email")) {
		  Properties p = System.getProperties();
	        p.put("mail.smtp.starttls.enable", "true");     // gmail은 true 고정
	        p.put("mail.smtp.host", "smtp.naver.com");      // smtp 서버 주소
	        p.put("mail.smtp.auth","true");                 // gmail은 true 고정
	        p.put("mail.smtp.port", "587");                 // 네이버 포트
	        p.put("mail.smtp.port", "587");                 // 네이버 포트
	        p.put("mail.smtp.ssl.protocols", "TLSv1.2"); // TLS 프로토콜 버전 설정
	        p.put("mail.smtp.ssl.ciphersuites", "TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384"); // 적절한 암호화 알고리즘 설정
	       
	        
	        javax.mail.Authenticator auth = new NaverMail();
	        //session 생성 및  MimeMessage생성
	        Session session = Session.getDefaultInstance(p, auth);
	        MimeMessage msg = new MimeMessage(session);
	         
	        try{
	            //편지보낸시간
	            msg.setSentDate(new Date());
	            InternetAddress from = new InternetAddress() ;
	            from = new InternetAddress("ydyd0809@naver.com"); //발신자 아이디
	            // 이메일 발신자
	            msg.setFrom(from);
	            // 이메일 수신자
	            InternetAddress to = new InternetAddress(email);
	            msg.setRecipient(Message.RecipientType.TO, to);
	            // 이메일 제목
	            msg.setSubject("codeless 임시 비밀번호입니다.", "UTF-8");
	            // 이메일 내용
	            msg.setText(id+"님의 임시 비밀번호는 "+randomPw+" 입니다. ", "UTF-8");
	            // 이메일 헤더
	            msg.setHeader("content-Type", "text/html");
	            //메일보내기
	            javax.mail.Transport.send(msg, msg.getAllRecipients());
	            System.out.println("이메일 발송 성공");
	            
	            dao.pwUpdate(email, randomPw);
	             
	        }catch (AddressException addr_e) {
	            addr_e.printStackTrace();
	        }catch (MessagingException msg_e) {
	            msg_e.printStackTrace();
	        }catch (Exception msg_e) {
	            msg_e.printStackTrace();
	        }
	        response.setContentType("text/html; charset=UTF-8");
		  	PrintWriter out = response.getWriter();
			  out.print("<script src='//cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
		    out.print("<script>");
		    out.print("document.addEventListener('DOMContentLoaded', function() {");
		    out.print("Swal.fire('등록된 이메일로 임시비밀번호를 전송하였습니다.', '', 'success').");
		    out.print("then(function(){location.href='./MemberLogin.me';});");
		    out.print("});");
		    out.print("</script>");
		    
			  out.close();
			
			return null; //컨트롤러에서는 이동 X
	    }else {
	    	response.setContentType("text/html; charset=UTF-8");
		  	PrintWriter out = response.getWriter();
			  out.print("<script src='//cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
		    out.print("<script>");
		    out.print("document.addEventListener('DOMContentLoaded', function() {");
		    out.print("Swal.fire('회원정보가 없습니다.', '', 'warning').");
		    out.print("then(function(){history.back();});");
		    out.print("});");
		    out.print("</script>");
		    
			  out.close();
			
			return null; //컨트롤러에서는 이동 X
	    }
	
	 
	}
	
		
			
	
	}

