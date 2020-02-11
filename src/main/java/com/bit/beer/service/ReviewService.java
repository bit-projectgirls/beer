package com.bit.beer.service;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.beer.repository.HashtagVo;
import com.bit.beer.repository.ReviewDaoImpl;
import com.bit.beer.repository.ReviewVo;

@Service
public class ReviewService {
	@Autowired
	private ReviewDaoImpl reviewDao;
	
	public List<String> ExtractHashtag(String content) {
	    Pattern p = Pattern.compile("\\#([0-9a-zA-Z가-힣ㄱ-ㅎㅏ-ㅣ]*)");
	    Matcher m = p.matcher(content);
	    List<String> list = new ArrayList<String>();
	    while(m.find()) {
	    	if(m.group().substring(1).length() > 0)
	    		list.add(m.group().substring(1));
	    }
	    return list;
	}
	
	public boolean insertHashtag(ReviewVo reviewVo, List<String> list) {
		int insertedCount = 0;
		for(String tag: list) {
			HashtagVo tagVo = new HashtagVo();
			tagVo.setBeerNo(reviewVo.getBeerNo());
			tagVo.setReviewNo(reviewVo.getReviewNo());
			tagVo.setTagName(tag);
			insertedCount += reviewDao.insertHashtag(tagVo);
		}
		return 0 != insertedCount;
	}
	
	public boolean insertReview(ReviewVo reviewVo) {
		int insertedCount = reviewDao.insertReview(reviewVo);
		return 1 == insertedCount;
	}
	
	public ReviewVo getReviewByContent(String reviewCnt) {
		ReviewVo vo = reviewDao.selectReviewByContent(reviewCnt);
		return vo;
	}
	
	public List<HashtagVo> getHashtagByKeyword(String keyword) {
		List<HashtagVo> list = reviewDao.selectTagByKeyword(keyword);
		return list;
	}
}
