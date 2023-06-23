package com.mystudy.boardSystem.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mystudy.boardSystem.common.mail.MailService;
import com.mystudy.boardSystem.service.MemberService;
import com.mystudy.boardSystem.vo.MemberVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@SessionAttributes("member")
@Controller
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
//	public MemberController(MemberService memberService) {
//		super();
//		this.memberService = memberService;
//	}


	@RequestMapping("/")
	public String index() {
		return "login";
	}
	
	@GetMapping("/signUp")
	public String signUp() {
		return "users/signUp";
	}
	
	@PostMapping("/login")
	public String login(MemberVO vo, HttpSession session, RedirectAttributes rttr) {
		MemberVO member = memberService.getMember(vo);
		
		if(member!=null) {
			session.setAttribute("member", member);
			log.info("로그인성공 후 memberVo: {}", member);
			//System.out.println("로그인성공 후 memberVo:"+ member);
			return "redirect:getBoard";
		} else {
			log.info("로그인실패");
			//System.out.println("로그인실패");
			rttr.addFlashAttribute("msg", "로그인실패");
			return "redirect:/";
		}
	}
	
	@RequestMapping("/logout")
	public String logout(SessionStatus ss,HttpSession session) {
        session.removeAttribute("member");
        ss.setComplete();
        //session.invalidate(); //세션무효화
        return "redirect:/";
	}
	
	@PostMapping("/signUp")
	public String register(MemberVO memberVo, RedirectAttributes rttr){
		try {
			log.info("가입정보: {}", memberVo);
			//System.out.println("가입정보:"+ memberVo);
			int res = memberService.register(memberVo);
			if(res == 1) {
				rttr.addFlashAttribute("msg", "가입성공");
				return "redirect:/";
			} 
			
			else {
				rttr.addFlashAttribute("msg", "가입실패");
				return "redirect:/signUp";
			}
			
		}catch (Exception e) {
			e.printStackTrace();
			rttr.addFlashAttribute("msg", "가입오류");
			return "redirect:/signUp";
		}
	}
	
	@PostMapping("/idCheck")
	@ResponseBody
	public String idCheck(String id) {
		log.info("idCheck()실행 / 전달받은 vo : {}", id);
		//System.out.println("idCheck()실행 / 전달받은 vo : " +id);
		
		MemberVO member = memberService.getMemberInfo(id);
		log.info("getMemberInfo 실행 / 조회 결과 member : {}", member);
		//System.out.println(member);
		String result ="";
		if(member!= null) { //id가 있을때
			result = "Exist";
		} else {
			result = "Available";
		}
		return result;
	}
	
	@PostMapping("/emailConfirm")
	@ResponseBody
	public String emailConfirm(@RequestParam String email) throws Exception {
		log.info("emailConfirm()실행 /받은 이메일 : {}", email);
		//System.out.println("emailConfirm()실행 /받은 이메일 : " + email);
		MailService mailService = new MailService();
		String code = mailService.sendMail(email);
		return code;
	}
	
	@GetMapping("/myPage")
	public String myPage() {
		return "users/myPage";
	}
	
	
	
	
}
