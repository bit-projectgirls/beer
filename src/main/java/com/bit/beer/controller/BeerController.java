package com.bit.beer.controller;


import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

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
	public String beerInfoPage(@RequestParam(value="rating", required=false, defaultValue = "0.0") String rating, @PathVariable("beerNo") int beerNo, Model model) {
		logger.info("beer page load: " + beerNo);
		BeerVo vo = beerService.getBeerInfo(beerNo);
		model.addAttribute("rating", rating);
		model.addAttribute("beerVo", vo);
		return "beer";
	}
	
	// 리뷰 작성 페이지
	@RequestMapping(value="/reviewform")
	public String reviewForm(@RequestParam(value="beerNo") int beerNo, @RequestParam(value="rating", required=false, defaultValue = "2.5") String rating, Model model) {		
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
		// Typelist 전송
		List<String> typelist = beerService.getTypeList();
		model.addAttribute("typelist", typelist);
		return "list";
	}
	
	// 검색 페이지
	@RequestMapping(value="/search", method=RequestMethod.GET)
	public String searchForm(HttpServletRequest request, Model model) {
		logger.info("search page load");
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			
		}
		return "search";		
	}
	
	// 나라 검색
	@RequestMapping(value="/searchcountry", method={ RequestMethod.GET, RequestMethod.POST }, produces = "application/text; charset=utf8")
	@ResponseBody
	public String searchCountry(@RequestParam(value="keyword") String keyword, Model model) {
		logger.info("search start: " + keyword);
		List<String> test = beerService.getCountryList(keyword);
//		test.addAll(Arrays.asList("한국", "독일", "프랑스", "일본", "중국", "벨기에", "미국"));
		Iterator<String> iter = test.iterator();
		while(iter.hasNext()) {
			String country = iter.next();
			if(!country.contains(keyword)) {
				iter.remove();
			}
		}
		return gson.toJson(test);
	}
		
	@RequestMapping(value="/selectcountry")
	public String selectByCountry(HttpServletRequest request, Model model) {
		String[] ctrylist = request.getParameterValues("chklist");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("ctrylist", ctrylist);
		double minabv = Double.parseDouble(request.getParameterValues("minabv")[0]);
		double maxabv = Double.parseDouble(request.getParameterValues("maxabv")[0]);
		map.put("minabv", minabv);
		map.put("maxabv", maxabv);
		if(ctrylist != null) {
			for(String str:ctrylist) {
				logger.info(str);
			}
		}
		List<BeerVo> list = beerService.getBeerList(map);
		if(list != null) {
			logger.info("select result!!!!!");
			for(BeerVo vo: list) {
				logger.info(vo.toString());
			}
		}
		model.addAttribute("beerlist", list);
		return "searchresult";
	}
}
