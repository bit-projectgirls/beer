package com.bit.beer.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.beer.repository.BeerDaoImpl;
import com.bit.beer.repository.BeerVo;
import com.bit.beer.repository.ReviewVo;

@Service
public class BeerService {

	@Autowired
	private BeerDaoImpl beerDao;
	
	public List<String> getCountryList(Map<String, Object> keyword){
		List<String> list = beerDao.selectCountry(keyword);
		return list;
	}
	
	public List<String> getTypeList(){
		List<String> list = beerDao.selectType();
		return list;
	}
	
	public BeerVo getBeerInfo(int beerNo){
		BeerVo vo = beerDao.selectBeerByNo(beerNo);
		return vo;
	}
	
	public List<BeerVo> getBeerList(Map<String, Object> map){
		List<BeerVo> list = beerDao.selectBeer(map);
		return list;
	}
	
	public List<ReviewVo> getReviewList(int beerNo){
		List<ReviewVo> list = beerDao.selectReviewByBeerNo(beerNo);
		return list;
	}
}
