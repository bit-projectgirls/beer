package com.bit.beer.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.beer.repository.HashtagVo;
import com.bit.beer.repository.ReviewVo;
import com.bit.beer.service.ReviewService;
import com.google.gson.Gson;

@Controller
public class ReviewController {
	
	private static final Logger logger = LoggerFactory.getLogger(ReviewController.class);

	@Autowired
	private ReviewService reviewService;
	
	
	// 리뷰 DB에 저장
	@RequestMapping(value="/write", method=RequestMethod.POST)
	public String reviewAction(@ModelAttribute ReviewVo reviewVo) {
		logger.info("reviewAction: " + reviewVo.toString());
		String reviewCnt = reviewVo.getReviewContent();
		reviewService.insertReview(reviewVo);
		// 해시태그 분리 후 DB에 저장
		reviewVo = reviewService.getReviewByContent(reviewCnt);	// DB에서 reviewNo 받아오기
		List<String> tagList = reviewService.ExtractHashtag(reviewCnt);
		logger.info("태그추출: " + tagList.toString());
		if(tagList != null) {
			reviewService.insertHashtag(reviewVo, tagList);
		}
		return "beer";
	}
	
	@RequestMapping(value = "/searchtag", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/text; charset=utf8")
	@ResponseBody
	public String getMap(@RequestParam(value="keyword") String keyword) {
		logger.info("search tag start: " + keyword);
		Gson gson = new Gson();
		// TODO : keyword가 없을때는 추천 태그 띄워주기
		List<HashtagVo> list = reviewService.getHashtagByKeyword(keyword);
		
		logger.info(gson.toJson(list));
		return gson.toJson(list);
	}
}
