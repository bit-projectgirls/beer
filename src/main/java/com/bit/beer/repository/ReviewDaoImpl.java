package com.bit.beer.repository;

import java.util.List;

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
	public ReviewVo selectReviewByContent(String reviewCnt) {
		ReviewVo vo = sqlSession.selectOne("review.selectByReviewContent", reviewCnt);
		
		return vo;
	}

	@Override
	public List<HashtagVo> selectTagByKeyword(String keyword) {
		List<HashtagVo> list = sqlSession.selectList("review.selectTagByKeyword", keyword);

		return list;
	}

}
