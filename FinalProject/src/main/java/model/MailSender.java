package model;

import java.io.UnsupportedEncodingException;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class MailSender {
	private String fromEmail;
	private String fromPassword;
	
	
	public MailSender() {
		this.fromEmail = "";			// 구글 아이디
		this.fromPassword = "";  			// 구글 암호
	}

	public void sendMail(String toEmail, String toName, String subject, String content) {
		
		try {
			// 서버 연결 환경
			Properties props = new Properties();
			props.put("mail.smtp.starttls.enable", "true");
			props.put("mail.transport.protocol", "smtp");
			props.put("mail.smtp.host", "smtp.gmail.com");
			props.put("mail.smtp.port", "465");
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
			
			// 인증
			MyAuth auth = new MyAuth(fromEmail, fromPassword);
			Session session = Session.getDefaultInstance(props, auth);
			
			// 메시지
			MimeMessage msg = new MimeMessage(session);
			msg.setHeader("Content-type", "text/plain; charset=utf-8");
			// 보낼 사람
			msg.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmail, toName, "utf-8"));
			// 보낼 제목
			msg.setSubject(subject);
			// 보낼 내용
			msg.setContent(content, "text/html; charset=utf-8");
			// 보낼 시간
			msg.setSentDate(new java.util.Date());
			
			Transport.send(msg);
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
