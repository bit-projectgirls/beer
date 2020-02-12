package com.bit.beer.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bit.beer.repository.UserVo;
import com.bit.beer.service.UserService;

@Controller
public class UserController {
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	private UserService userService;
	 
	@RequestMapping(value="/login")
	public String login(@RequestParam("code") String code, HttpSession session) {
		String access_token = userService.getAccessToken(code);
		HashMap<String, String> userInfo = userService.getUserInfo(access_token);		
		logger.info("login Controller: " + userInfo);

		// 가입여부 체크
		if(userService.checkId(userInfo.get("kakaoId")) == null) {
			boolean isSuccess = false;
			isSuccess = userService.join(access_token);
		}
		UserVo authUser = userService.checkId(userInfo.get("kakaoId"));
		session.setAttribute("authUser", authUser);
		session.setAttribute("access_token", access_token);
		return "mypage";
	}

	@RequestMapping(value="/logout")
	public String logout(HttpSession session) {
	    userService.kakaoLogout((String)session.getAttribute("access_token"));
	    session.invalidate();
	    return "mypage";
	}

}
