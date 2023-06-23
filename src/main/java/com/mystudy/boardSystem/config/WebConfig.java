package com.mystudy.boardSystem.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.mystudy.boardSystem.common.interceptor.LoginInterceptor;

@Configuration
public class WebConfig implements WebMvcConfigurer{
	/*
     * 로그인 인증 Interceptor 설정
     * */
    @Autowired
    LoginInterceptor loginInterceptor;
    
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(loginInterceptor)
                .addPathPatterns("/**/*")
                .excludePathPatterns("/boardSystem/")
        		.excludePathPatterns("/**/signUp")
        		.excludePathPatterns("/**/login")
        		.excludePathPatterns("/**/logout");
    }
}
