package model;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

// 메일 서버에서 사용자 인증
public class MyAuth extends Authenticator {
	private String userName;
	private String userPassword;
	
	public MyAuth(String userName, String userPassword) {
		this.userName = userName;
		this.userPassword = userPassword;
	}
	
	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		return new PasswordAuthentication(userName, userPassword);
	}
}
