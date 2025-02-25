package com.study.pet;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;


@Controller
public class HomeController {

	@GetMapping("/")
	public String goHome() {
		return "mainHome";
	}
	
}
