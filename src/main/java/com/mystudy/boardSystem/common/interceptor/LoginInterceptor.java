package com.mystudy.boardSystem.common.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;

//인터셉터 작동 순서: preHandler -> 요청 처리 -> postHandler -> View -> afterCompletion
@Slf4j
@Component
public class LoginInterceptor implements HandlerInterceptor {
	
	//controller로 보내기 전 이벤트 작동(false - controller로 요청을 안함)
	
//	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
//			throws Exception {
//		// TODO Auto-generated method stub
//		System.out.println("preHandle() 실행");
//		System.out.println("request:"+request);
//		System.out.println("response:"+response);
//		System.out.println("handler:"+handler.toString());
//		
		
//		
//		HttpSession session = request.getSession();
//		System.out.println(">>세션member값:"+session.getAttribute("member") );
//		if (session.getAttribute("member") != null) {
//			return true;
//		}else {
//			response.setContentType("text/html; charset=utf-8");
//			PrintWriter printwriter = response.getWriter();
//			printwriter.print("<script>alert('로그인이 필요합니다.'); location.href='/boardSystem';</script>");
//			printwriter.flush();
//			printwriter.close();
//			//response.sendRedirect("/boardSystem");
//			return false;
//		}
//		
//		//return false;
//		//return super.preHandle(request, response, handler);
//		
//	}
	
	//controller 처리 이후 이벤트 작동
	
	
	//view 처리 이후 이벤트 작동
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
//		log.debug("msg");
//		log.info("msg");
//		log.error("msg");
        log.info("==================== preHandle ====================");
        HttpSession session = request.getSession();
		//System.out.println(">>세션member값:"+session.getAttribute("member") );
        log.info(">>세션member값 : {}", session.getAttribute("member"));
		if (session.getAttribute("member") != null) {
			return true;
		}else {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter printwriter = response.getWriter();
			printwriter.print("<script>alert('로그인이 필요합니다.'); location.href='/boardSystem';</script>");
			printwriter.flush();
			printwriter.close();
			return false;
		}
		
	}
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		log.info("==================== postHandle ======================");
		HandlerInterceptor.super.postHandle(request, response, handler, modelAndView);
	}

}
