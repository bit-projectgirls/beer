package com.bit.beer.repository;

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

}
