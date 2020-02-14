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
	public List<Map<String, Object>> selectCountry(Map<String, Object> keyword) {
		List<Map<String, Object>> list = sqlSession.selectList("beer.selectCountry", keyword);
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
		List<BeerVo> list = sqlSession.selectList("beer.selectBeer", map);
		return list;
	}

	@Override
	public List<BeerVo> selectBeerByTag(String keyword) {
		List<BeerVo> list = sqlSession.selectList("beer.selectBeerByTag", keyword);
		return list;
	}
	
	@Override
	public int updateRating(Map<String, Object> map) {
		int updatedCount = sqlSession.update("beer.updateRating", map);
		return updatedCount;
	}

	@Override
	public int insertBeerLike(Map<String, Object> map) {
		int insertedCount = sqlSession.update("beer.insertLike", map);
		return insertedCount;
	}
	
}
