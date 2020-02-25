package com.bit.beer.repository;

import java.util.List;
import java.util.Map;

public interface ReviewDao {
	public int insertHashtag(HashtagVo vo);
	public int insertReview(ReviewVo vo);
	public List<HashtagVo> selectTagByKeyword(String keyword);
	public List<HashtagVo> selectTagByBeerNo(int beerNo);
	public List<ReviewVo> selectReviewByBeerNo(int beerNo);
	public List<ReviewVo> selectReviewByUuid(String uuid);
	public ReviewVo writtenReview(Map<String, Object> map);
	public int deleteReview(String reviewNo);
	public int deleteHashtag(String reviewNo);
}
