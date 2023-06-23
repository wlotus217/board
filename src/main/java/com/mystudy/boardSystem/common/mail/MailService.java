package com.mystudy.boardSystem.common.mail;

import java.util.Properties;
import java.util.Random;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;

import com.mystudy.boardSystem.vo.BoardVO;

public class MailService {
	
	public String sendMail(String toEmail) {
		final String fromEmail = "signuptest.soyeon@gmail.com"; //requires valid gmail id
		final String password = "kwlyhynusjvizall"; // correct password for gmail id
		
		final String ePw = createKey();
		System.out.println("인증번호생성:" + ePw);
		
		String msg="";
		msg += "<div style='margin:100px;'>";
		msg += "<h1> 안녕하세요</h1>";
		msg += "<h1> BoardSystem 입니다.</h1>";
		msg += "<br>";
		msg += "<p>아래 코드를 회원가입 창으로 돌아가 입력해주세요</p>";
		msg += "<br>";
		msg += "<div align='center' style='border:1px solid black; font-family:verdana';>";
		msg += "<h3 style='color:blue;'>회원가입 인증 코드입니다.</h3>";
		msg += "<div style='font-size:130%'>";
		msg += "CODE : <strong>";
		msg += ePw + "</strong><div><br/> "; // 메일에 인증번호 넣기
		msg += "</div>";
		
		System.out.println("SSLEmail Start");
		Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com"); //SMTP Host
		props.put("mail.smtp.socketFactory.port", 587); //SSL Port
		props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory"); //SSL Factory Class
		props.put("mail.smtp.starttls.enable", true);
		props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
		props.put("mail.smtp.auth", true); //Enabling SMTP Authentication
		props.put("mail.smtp.port", 587); //SMTP Port
		
		props.put("mail.smtp.ssl.protocols", "TLSv1.2");
		
		Authenticator auth = new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(fromEmail, password);
			}
		};
		
		Session session = Session.getDefaultInstance(props, auth);
		System.out.println("Session created");
	        String result = EmailUtil.sendEmail(session, toEmail,"회원가입 이메일 인증입니다.", msg);
	        if (result == "Success") {
	        	return ePw;
	        } else {
	        	return "Failed";
	        }
	        
	}
	
	// 인증코드 만들기
    public static String createKey() {
        StringBuffer key = new StringBuffer();
        Random rnd = new Random();

        for (int i = 0; i < 6; i++) { // 인증코드 6자리
            key.append((rnd.nextInt(10)));
        }
        return key.toString();
    }
    
    public String sendMailBlind(String toEmail, BoardVO boardVo) {
    	final String fromEmail = "signuptest.soyeon@gmail.com"; //requires valid gmail id
		final String password = "kwlyhynusjvizall"; // correct password for gmail id
		
		String msg="";
		msg += "<div style='margin:100px;'>";
		msg += "<h3> 안녕하세요. BoardSystem 입니다.</h3>";
		msg += "<br>";
		msg += "<p>"+boardVo.getCreateUser()+"님이 작성하신 게시글이 규정에 따라 블라인드 처리되었습니다.</p>";
		msg += "<br>";
		msg += "<p><strong>게시글 제목 : "+ boardVo.getTitle() +"</strong></p>";
		msg += "<p><strong>사유 : 비속어 사용 </strong></p>";
		msg += "<br>";
		msg += "<p>자세한 사항은 관리자에게 문의해주세요.</p>";
		msg += "<p>감사합니다.</p>";
		msg += "<br>";
		msg += "</div>";
		
		System.out.println("SSLEmail Start");
		Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com"); //SMTP Host
		props.put("mail.smtp.socketFactory.port", 587); //SSL Port
		props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory"); //SSL Factory Class
		props.put("mail.smtp.starttls.enable", true);
		props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
		props.put("mail.smtp.auth", true); //Enabling SMTP Authentication
		props.put("mail.smtp.port", 587); //SMTP Port
		
		props.put("mail.smtp.ssl.protocols", "TLSv1.2");
		
		Authenticator auth = new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(fromEmail, password);
			}
		};
		
		Session session = Session.getDefaultInstance(props, auth);
		System.out.println("Session created");
		String result = EmailUtil.sendEmail(session, toEmail,"게시글 블라인드 처리 안내", msg);
	        if (result == "Success") {
	        	return result;
	        } else {
	        	return "Failed";
	        }
    }
    
    
}
