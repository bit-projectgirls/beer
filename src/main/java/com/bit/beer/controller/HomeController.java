package com.bit.beer.controller;

import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bit.beer.repository.BeerVo;
import com.bit.beer.service.BeerService;


/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	BeerService beerService;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		logger.info("Welcome home!");
		List<BeerVo> beerList = beerService.getTopList();
		List<BeerVo> beerListBA = beerService.getTopBAList();
		model.addAttribute("beerList", beerList);
		model.addAttribute("beerListBA", beerListBA);
		return "home";
	}
	
	@RequestMapping(value="/mypage")
	public String myPage() {
		logger.info("My page load");
		return "mypage";
	}
	
	@RequestMapping(value="/map")
	public String beerInfoPage() {
		logger.info("map page load");
		return "map";
	}
	
}
