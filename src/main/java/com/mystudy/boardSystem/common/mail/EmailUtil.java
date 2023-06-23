package com.mystudy.boardSystem.common.mail;

import java.util.Date;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EmailUtil {

	public static String sendEmail(Session session, String toEmail, String subject, String body){
		
		try {
	      MimeMessage msg = new MimeMessage(session);
	      //set message headers
	      //msg.addHeader("Content-type", "text/HTML; charset=UTF-8");
	      //msg.addHeader("format", "flowed");
	      //msg.addHeader("Content-Transfer-Encoding", "8bit");

	      msg.setFrom(new InternetAddress("signuptest.soyeon@gmail.com", "BoardAdmin"));

	      msg.setReplyTo(InternetAddress.parse("no_reply@example.com", false));

	      msg.setSubject(subject, "UTF-8");

	      msg.setText(body, "utf-8", "html"); //내용, charset타입, subtype

	      msg.setSentDate(new Date());

	      msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail, false));
	      System.out.println("Message is ready");
    	  Transport.send(msg);  

	      System.out.println("EMail Sent Successfully!!");
	      return "Success";
	    
	      
	    }
	    catch (Exception e) {
	      e.printStackTrace();
	      return "Failed";
	    }
	}
}
