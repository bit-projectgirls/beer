package com.bit.beer.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.bit.beer.repository.ReviewVo;
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
	
	@RequestMapping(value="/modifyname")
	public String modifyName() {
		return "modifyname";
	}
	
	@RequestMapping(value="/modnameaction", method=RequestMethod.POST)
	public String modNameAction(@ModelAttribute UserVo vo, HttpSession session) {
		boolean isSuccess = false;
		
		UserVo authUser = (UserVo)session.getAttribute("authUser");
		vo.setUuid(authUser.getUuid());
		logger.info(vo.getNickname() + vo.getUuid());
		
		 isSuccess = userService.modifyProfile(vo);
		
		authUser.setNickname(vo.getNickname());

		
		return "mypage";
	}

	@RequestMapping(value="/userpicupload", method=RequestMethod.POST)
	@ResponseBody
	public String uploadUserPic(HttpServletRequest request, HttpSession session, @RequestParam("uploadFile") MultipartFile file) {
		UserVo vo = (UserVo)session.getAttribute("authUser");
		String fileUrl = "";
		if(!file.isEmpty()) {
			try {
				fileUrl = userService.store(file, request);
				vo.setUserPic(fileUrl);
				logger.info("fileUrl: " + fileUrl);
				boolean isSuccess = userService.modifyProfile(vo);
			}catch(Exception e) {
				logger.debug(e.getMessage() + e.toString());
			}
		}
		session.setAttribute("authUser", vo);
		
		return fileUrl;
	}
}
