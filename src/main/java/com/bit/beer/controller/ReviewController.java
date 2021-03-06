package com.bit.beer.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

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

import com.bit.beer.repository.BeerVo;
import com.bit.beer.repository.HashtagVo;
import com.bit.beer.repository.ReviewVo;
import com.bit.beer.repository.UserVo;
import com.bit.beer.service.ReviewService;
import com.google.gson.Gson;

@Controller
public class ReviewController {
	
	private static final Logger logger = LoggerFactory.getLogger(ReviewController.class);
	private Gson gson = new Gson();
	
	@Autowired
	private ReviewService reviewService;
	
	// 리뷰 DB에 저장
	@RequestMapping(value="/write", method=RequestMethod.POST)
	public String reviewAction(@ModelAttribute ReviewVo reviewVo) {
		logger.info("reviewAction: " + reviewVo.toString());
		
		// reviewNo 세팅 후 DB에 저장
		String reviewNo = UUID.randomUUID().toString();
		reviewVo.setReviewNo(reviewNo);
		reviewService.insertReview(reviewVo);
		
		// 해시태그 분리 후 DB에 저장
		String reviewCnt = reviewVo.getReviewContent();
		List<String> tagList = reviewService.extractHashtag(reviewCnt);
		logger.info("태그추출: " + tagList.toString());
		if(tagList != null) {
			reviewService.insertHashtag(reviewVo, tagList);
		}
		
		// 레이팅 정보 업데이트
		logger.info("beerNo: " + reviewVo.getBeerNo());
		int beerNo = reviewVo.getBeerNo();
		reviewService.updateRating(beerNo);
		return "redirect:/beer/" + beerNo;
	}
	
	// 해시태그 목록 보여주기
	@RequestMapping(value="/searchtag", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/text; charset=utf8")
	@ResponseBody
	public String getHashtag(@RequestParam(value="keyword") String keyword, @RequestParam(value="beerNo", required=false) int beerNo) {
		logger.info("search tag start: " + keyword);
		List<HashtagVo> list = new ArrayList<HashtagVo>();
		// TODO : keyword가 없을때는 추천 태그 띄워주기
		if(keyword.length() == 0) {
			list = reviewService.getHashtagByBeerNo(beerNo);
		} else {
			list = reviewService.getHashtagByKeyword(keyword);
		}
		
		logger.info(gson.toJson(list));
		return gson.toJson(list);
	}
	
	// 내가 작성한 리뷰 목록
	@RequestMapping(value="/myreview")
	public String getMyreview(Model model, HttpSession session) {
		UserVo authUser = (UserVo)session.getAttribute("authUser");
		String uuid = authUser.getUuid();
		
		List<ReviewVo> reviewList = reviewService.getReviewList(uuid);
		List<BeerVo> beerList = reviewService.getReviewBeerInfo(reviewList);
		model.addAttribute("beerList", beerList);
		model.addAttribute("reviewList", reviewList);
		return "myreview";
	}
	
	// 작성한 리뷰 삭제
	@RequestMapping(value="/deletereview")
	public String deleteMyreview(Model model, HttpSession session, @ModelAttribute ReviewVo reviewVo) {
		boolean isSuccess = reviewService.deleteReview(reviewVo);
		logger.info("리뷰삭제:" + isSuccess);
		UserVo authUser = (UserVo)session.getAttribute("authUser");
		String uuid = authUser.getUuid();
		
		List<ReviewVo> reviewList = reviewService.getReviewList(uuid);
		List<BeerVo> beerList = reviewService.getReviewBeerInfo(reviewList);
		model.addAttribute("beerList", beerList);
		model.addAttribute("reviewList", reviewList);
		return "myreview";
	}
}
