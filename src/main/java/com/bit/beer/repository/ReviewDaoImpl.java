package com.bit.beer.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ReviewDaoImpl implements ReviewDao {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public int insertHashtag(HashtagVo vo) {
		int insertedCount = 0;
		try{
			insertedCount = sqlSession.insert("review.insertHashtag", vo);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return insertedCount;
	}

	@Override
	public int insertReview(ReviewVo vo) {
		int insertedCount = 0;
		try{
			insertedCount = sqlSession.insert("review.insertReview", vo);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return insertedCount;
	}

	@Override
	public List<HashtagVo> selectTagByKeyword(String keyword) {
		List<HashtagVo> list = sqlSession.selectList("review.selectTagByKeyword", keyword);

		return list;
	}
	
	@Override
	public List<ReviewVo> selectReviewByBeerNo(int beerNo) {
		List<ReviewVo> list = sqlSession.selectList("review.selectByBeerNo", beerNo);
		return list;
	}

	@Override
	public List<ReviewVo> selectReviewByUuid(String uuid) {
		List<ReviewVo> list = sqlSession.selectList("review.selectByUuid", uuid);
		return list;
	}



}
