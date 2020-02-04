package com.bit.beer.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bit.beer.repository.ReviewVo;
import com.bit.beer.service.ReviewService;

@Controller
public class ReviewController {
	
	private static final Logger logger = LoggerFactory.getLogger(ReviewController.class);

	@Autowired
	private ReviewService reviewService;
	
	@RequestMapping(value="/reviewform")
	public String reviewForm() {		
		logger.info("write form load");
		return "writeform";
	}
	
	// 리뷰 저장
	@RequestMapping(value="/write", method=RequestMethod.POST)
	public String reviewAction(@ModelAttribute ReviewVo reviewVo) {
		logger.info("reviewAction: " + reviewVo.toString());
		
		reviewService.insertReview(reviewVo);
		// 해시태그 분리 후 DB에 저장
		List<String> tagList = reviewService.ExtractHashtag(reviewVo.getReviewContent());
		logger.info("태그추출: " + tagList.toString());
		if(tagList != null) {
			reviewService.insertHashtag(reviewVo, tagList);
		}
		return "beer";
	}
}
