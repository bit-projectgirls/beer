package com.bit.beer.repository;

import java.util.List;
import java.util.Map;

public interface ReviewDao {
	public int insertHashtag(HashtagVo vo);
	public int insertReview(ReviewVo vo);
	public List<HashtagVo> selectTagByKeyword(String keyword);
	public int updateRating(Map<String, Object> map);
	public List<ReviewVo> selectReviewByBeerNo(int beerNo);
}
