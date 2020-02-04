package com.bit.beer.repository;

public interface ReviewDao {
	public int insertHashtag(HashtagVo vo);
	public int insertReview(ReviewVo vo);
}
