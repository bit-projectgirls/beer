package com.bit.beer.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BeerDaoImpl implements BeerDao {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<String> selectCountry(Map<String, Object> keyword) {
		List<String> list = sqlSession.selectList("beer.selectCountry", keyword);
		return list;
	}
	
	@Override
	public List<String> selectType() {
		List<String> list = sqlSession.selectList("beer.selectType");
		return list;
	}
	
	@Override
	public BeerVo selectBeerByNo(int beerNo) {
		BeerVo vo = sqlSession.selectOne("beer.selectBeerByNo", beerNo);
		return vo;
	}

	@Override
	public List<BeerVo> selectBeer(Map<String, Object> map) {
		List<BeerVo> result = sqlSession.selectList("beer.selectBeer", map);
		return result;
	}

	@Override
	public List<ReviewVo> selectReviewByBeerNo(int beerNo) {
		List<ReviewVo> list = sqlSession.selectList("review.selectByBeerNo", beerNo);
		return list;
	}
}
