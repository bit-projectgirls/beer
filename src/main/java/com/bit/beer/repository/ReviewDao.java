package com.bit.beer.repository;

import java.util.List;

public interface ReviewDao {
	public int insertHashtag(HashtagVo vo);
	public int insertReview(ReviewVo vo);
	public ReviewVo selectReviewByContent(String reviewCnt);
	public List<HashtagVo> selectTagByKeyword(String keyword);
}
