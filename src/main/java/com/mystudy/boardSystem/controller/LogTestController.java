package com.mystudy.boardSystem.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class LogTestController {
	
	private final Logger logger = LoggerFactory.getLogger(getClass());
    
    @RequestMapping("log-test")
    public String logTest() {

        String name = "Spring";

        System.out.println("name = " + name);

        logger.info(" info log={}", name);

        return "ok";
    }
}
