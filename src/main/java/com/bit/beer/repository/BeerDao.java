package com.bit.beer.repository;

import java.util.List;
import java.util.Map;

public interface BeerDao {
	public List<Map<String, Object>> selectCountry(Map<String, Object> keyword);
	public List<String> selectType();
	public BeerVo selectBeerByNo(int beerNo);
	public List<BeerVo> selectBeer(Map<String, Object> list);
	
}
