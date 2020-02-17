package com.bit.beer.repository;

import java.util.List;
import java.util.Map;

public interface BeerDao {
	public List<Map<String, Object>> selectCountry(Map<String, Object> keyword);
	public List<String> selectType();
	public BeerVo selectBeerByNo(int beerNo);
	public List<BeerVo> selectBeer(Map<String, Object> list);
	public List<BeerVo> selectBeerByTag(String keyword);
	public List<BeerVo> selectTop();
	public List<BeerVo> selectTopBA();
	public int updateRating(Map<String, Object> map);
	public int insertBeerLike(Map<String, Object> map);
	public int deleteBeerLike(Map<String, Object> map);
	public int selectBLikeCheck(Map<String, Object> map);
	public List<BeerVo> selectBLikeList(String uuid);
}
