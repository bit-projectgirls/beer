package com.bit.beer.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.beer.repository.BeerDaoImpl;
import com.bit.beer.repository.BeerVo;
import com.bit.beer.repository.HashtagVo;
import com.bit.beer.repository.ReviewDaoImpl;
import com.bit.beer.repository.ReviewVo;

@Service
public class ReviewService {
	private static final Logger logger = LoggerFactory.getLogger(ReviewService.class);

	@Autowired
	private ReviewDaoImpl reviewDao;
	@Autowired
	private BeerDaoImpl beerDao;
	
	// 해시태그 DB에 저장
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
	
	// 리뷰 DB에 저장
	public boolean insertReview(ReviewVo reviewVo) {
		// 해시태그에 태그 붙혀 저장하기
		String reviewcnt = reviewVo.getReviewContent();
		if(reviewcnt.length() != 0) {
			// reviewCnt 가공
			reviewcnt = reviewcnt.replace("</div>", "");
			reviewcnt = reviewcnt.replace("<div>", "<br>");
			
			reviewcnt = renderHashtag(reviewcnt);
			reviewVo.setReviewContent(reviewcnt);
		}
		int insertedCount = reviewDao.insertReview(reviewVo);
		return 1 == insertedCount;
	}
	
	// 내가 작성한 리뷰 리스트
	public List<ReviewVo> getReviewList(String uuid){
		List<ReviewVo> list = reviewDao.selectReviewByUuid(uuid);
		return list;
	}
	public List<BeerVo> getReviewBeerInfo(List<ReviewVo> list){
		List<BeerVo> result = new ArrayList<>();
		if(list != null) {
			for(ReviewVo vo: list) {
				BeerVo beerVo = beerDao.selectBeerByNo(vo.getBeerNo());
				result.add(beerVo);
			}
		}
		return result;
	}
	
	public List<HashtagVo> getHashtagByKeyword(String keyword) {
		List<HashtagVo> list = reviewDao.selectTagByKeyword(keyword);
		return list;
	}

	public List<HashtagVo> getHashtagByBeerNo(int beerNo) {
		List<HashtagVo> list = reviewDao.selectTagByBeerNo(beerNo);
		return list;
	}
	// rating update
	public boolean updateRating(int beerNo) {
		List<ReviewVo> list = reviewDao.selectReviewByBeerNo(beerNo);
		double sum = 0;
		double cnt = 0;
		double rating = 0;
		if(list != null) {
			for(ReviewVo vo: list) {
				sum += vo.getRating();
				cnt++;
			}
			rating = Math.round((sum / cnt) * 100) / 100.0;
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("beerNo", beerNo);
		map.put("rating", rating);
		int updatedCount = beerDao.updateRating(map);
		return 1 == updatedCount;
	}
	
	// 해시태그 분리
	public List<String> extractHashtag(String content) {
	    Pattern p = Pattern.compile("\\#([0-9a-zA-Z가-힣ㄱ-ㅎㅏ-ㅣ]*)");
	    Matcher m = p.matcher(content);
	    List<String> list = new ArrayList<String>();
	    while(m.find()) {
	    	if(m.group().substring(1).length() > 0)
	    		list.add(m.group().substring(1));
	    }
	    return list;
	}
	
	// 해시태그 앞뒤로 a태그 붙이기
	public String renderHashtag(String reviewcnt) {
		String result = reviewcnt;
		List<String> tagList = extractHashtag(reviewcnt);
		if(tagList != null) {
			for(String tag : tagList) {
				String html = "<a href=\"/beer/searchbytag?keyword=" + tag + "\">#" + tag + "</a>";
				tag = "#" + tag;
				logger.info("태그변환전: " + result);
				result = result.replace(tag, html);
				logger.info("태그변환후: " + result);
			}
		}
		return result;
	}
}
