package com.bit.beer.controller;

import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bit.beer.repository.ReviewVo;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		return "home";
	}
	
	@RequestMapping(value="/search", method=RequestMethod.GET)
	public String searchForm() {
		logger.info("search page load");
		return "search";		
	}
	
	@RequestMapping(value="/list")
	public String list() {
		logger.info("list page load");
		return "list";
	}
	
	@RequestMapping(value="/mypage")
	public String myPage() {
		logger.info("My page load");
		return "mypage";
	}
	
	@RequestMapping(value="/beer/{beerNo}")
	public String beerInfoPage(@PathVariable("beerNo") int beerNo) {
		logger.info("beer page load: " + beerNo);
		return "beer";
	}
	
	@RequestMapping(value="/map")
	public String beerInfoPage() {
		logger.info("map page load");
		return "map";
	}
}
