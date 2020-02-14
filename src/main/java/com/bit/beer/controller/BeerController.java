package com.bit.beer.controller;


import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.beer.repository.BeerVo;
import com.bit.beer.repository.ReviewVo;
import com.bit.beer.repository.UserVo;
import com.bit.beer.service.BeerService;
import com.google.gson.Gson;


@Controller
public class BeerController {
	private static final Logger logger = LoggerFactory.getLogger(BeerController.class);
	
	private Gson gson = new Gson();

	@Autowired
	private BeerService beerService;
	
	// 맥주 상세 정보 페이지
	@RequestMapping(value="/beer/{beerNo}")
	public String beerInfoPage(
			@RequestParam(value="rating", required=false, defaultValue = "0.0") String rating,
			@PathVariable("beerNo") int beerNo, Model model,
			HttpServletRequest request, HttpServletResponse response) {
		logger.info("beer page load: " + beerNo);
		
		// 맥주 정보 받아오기
		BeerVo vo = beerService.getBeerInfo(beerNo);
		model.addAttribute("rating", rating);
		model.addAttribute("beerVo", vo);
		
		// 리뷰 리스트 받아오기
		List<ReviewVo> reviewList = beerService.getReviewList(beerNo);
		model.addAttribute("reviewlist", reviewList);
		
		// 쿠키 생성
		Cookie[] cookies = request.getCookies();
		String cookieValue = beerService.setCookieList(cookies, beerNo);
		Cookie cookie;
		try {
			cookie = new Cookie("beerViewed", URLEncoder.encode(cookieValue, "UTF-8"));
			cookie.setMaxAge(60 * 60 * 24 * 365);
			cookie.setPath("/");
			response.addCookie(cookie);
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "beer";
	}
	
	// 좋아요 기능
	@RequestMapping(value="/blike")
	public String beerLikeAction(@RequestParam(value="beerNo") int beerNo, HttpSession session) {
		UserVo authUser = (UserVo)session.getAttribute("authUser");
		String uuid = authUser.getUuid();
		
		// 이미 좋아요했는지 확인
		boolean checkLike;
		return null;
	}
	
	// 검색 페이지
	@RequestMapping(value="/search", method=RequestMethod.GET)
	public String searchForm(HttpServletRequest request, Model model) {
		logger.info("search page load");
		
		
		Cookie[] cookies = request.getCookies();
		List<BeerVo> list = beerService.getCookieList(cookies);
		model.addAttribute("beerlist", list);
		return "search";		
	}
	
	
	// 리뷰 작성 페이지
	@RequestMapping(value="/reviewform")
	public String reviewForm(@RequestParam(value="beerNo") int beerNo, @RequestParam(value="rating", required=false, defaultValue= "2.5") String rating, Model model) {		
		logger.info("write form load: " + rating);
		BeerVo vo = beerService.getBeerInfo(beerNo);
		model.addAttribute("beerVo", vo);
		model.addAttribute("rating", rating);
		return "writeform";
	}
	
	// 맥주 리스트 페이지
	@RequestMapping(value="/list")
	public String list(Model model) {
		logger.info("list page load");
		// 맥주 리스트 받아오기
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("idx", 0);
		List<BeerVo> list = beerService.getBeerList(map);
		model.addAttribute("beerlist", list);
		// Typelist 전송
		List<String> typelist = beerService.getTypeList();
		model.addAttribute("typelist", typelist);
		return "list";
	}

	// 나라 검색
	@RequestMapping(value="/searchcountry", method={ RequestMethod.GET, RequestMethod.POST }, produces = "application/text; charset=utf8")
	@ResponseBody
	public String searchCountry(@RequestParam(value="idx", required=false, defaultValue="0") int idx, @RequestParam(value="keyword") String keyword, Model model) {
		logger.info("search start: " + keyword);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyword", keyword);
		logger.info("idx: "+ idx);
		
		map.put("idx", idx);
		List<Map<String, Object>> list = beerService.getCountryList(map);

		return gson.toJson(list);
	}

	// 필터로 맥주 검색
	@RequestMapping(value="/loadlist")
	@ResponseBody
	public String selectByCountry(HttpServletRequest request, Model model) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		String[] ctrylist = request.getParameterValues("ctrylist");
		map.put("ctrylist", ctrylist);
		String[] typelist = request.getParameterValues("typelist");
		map.put("typelist", typelist);
		double minabv = Double.parseDouble(request.getParameterValues("minabv")[0]);
		double maxabv = Double.parseDouble(request.getParameterValues("maxabv")[0]);
		map.put("minabv", minabv);
		map.put("maxabv", maxabv);
		int idx = 0;
		if(request.getParameter("idx") != null) {
			idx = Integer.parseInt(request.getParameter("idx"));
		}
		map.put("idx", idx);

		List<BeerVo> list = beerService.getBeerList(map);

		logger.info(gson.toJson(list));
		return gson.toJson(list);
	}
	
	// 키워드로 맥주 검색
	@RequestMapping(value="/searchkeyword", method=RequestMethod.POST)
	public String search(HttpServletRequest hprequest, @RequestParam(value="keyword") String keyword, Model model) {
		logger.info("search start: " + keyword);
		if(keyword.length() == 0) {
			Cookie[] cookies = hprequest.getCookies();
			List<BeerVo> list = beerService.getCookieList(cookies);
			model.addAttribute("beerlist", list);
			return "searchresult";
		}
		// 일라스틱서치 호출
		List<BeerVo> resultList = beerService.search(keyword);
		
		logger.info("search result: " + resultList.toString());
		model.addAttribute("beerlist", resultList);
		return "searchresult";
	}
	
	// 해시태그로 맥주 검색
	@RequestMapping(value="/searchbytag")
	public String search(@RequestParam(value="keyword") String keyword, Model model) {
		logger.info("search by tag:" + keyword);
		List<BeerVo> list = beerService.getBeerList(keyword);
		model.addAttribute("beerlist", list);
		return "searchresult";
	}
}
