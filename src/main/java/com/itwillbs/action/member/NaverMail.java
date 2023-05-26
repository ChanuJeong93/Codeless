package com.itwillbs.action.member;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;


public class NaverMail extends Authenticator {

	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		// TODO Auto-generated method stub
		return new PasswordAuthentication("ydyd0809@naver.com", "ekdud0512");
	}
		
}
