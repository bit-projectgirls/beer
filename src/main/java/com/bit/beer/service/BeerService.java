package com.bit.beer.service;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;

import org.apache.http.HttpHost;
import org.elasticsearch.action.search.SearchRequest;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestClient;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.search.SearchHit;
import org.elasticsearch.search.SearchHits;
import org.elasticsearch.search.builder.SearchSourceBuilder;
import org.elasticsearch.search.sort.FieldSortBuilder;
import org.elasticsearch.search.sort.SortOrder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.beer.repository.BeerDaoImpl;
import com.bit.beer.repository.BeerVo;
import com.bit.beer.repository.ReviewDaoImpl;
import com.bit.beer.repository.ReviewVo;

@Service
public class BeerService {

	@Autowired
	private BeerDaoImpl beerDao;
	@Autowired
	private ReviewDaoImpl reviewDao;
	
	public List<Map<String, Object>> getCountryList(Map<String, Object> keyword){
		List<Map<String, Object>> list = beerDao.selectCountry(keyword);
		return list;
	}
	
	public List<String> getTypeList(){
		List<String> list = beerDao.selectType();
		return list;
	}
	
	public BeerVo getBeerInfo(int beerNo){
		BeerVo vo = beerDao.selectBeerByNo(beerNo);
		return vo;
	}
	
	public List<BeerVo> getBeerList(Map<String, Object> map){
		List<BeerVo> list = beerDao.selectBeer(map);
		return list;
	}
	
	public List<BeerVo> getBeerList(String keyword){
		List<BeerVo> list = beerDao.selectBeerByTag(keyword);
		return list;
	}
	
	public List<BeerVo> getTopList(){
		List<BeerVo> list = beerDao.selectTop();
		return list;
	}
	
	public List<BeerVo> getTopBAList(){
		List<BeerVo> list = beerDao.selectTopBA();
		return list;
	}
	
	public List<ReviewVo> getReviewList(int beerNo){
		List<ReviewVo> list = reviewDao.selectReviewByBeerNo(beerNo);
		return list;
	}
	
	public Boolean insertBeerLike(String uuid, int beerNo) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		map.put("beerNo", beerNo);
		int insertedCount = beerDao.insertBeerLike(map);
		return 1 == insertedCount;
	}
	
	public Boolean deleteBeerLike(String uuid, int beerNo) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		map.put("beerNo", beerNo);
		int deletedCount = beerDao.deleteBeerLike(map);
		return 1 == deletedCount;
	}
	
	// Like 여부 체크
	public boolean checkBLike(String uuid, int beerNo) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		map.put("beerNo", beerNo);
		int count = beerDao.selectBLikeCheck(map);
		return 0 < count;
	}
	
	// Review 작성 여부 체크
	public ReviewVo writtenReview(String uuid, int beerNo) {
		Map<String, Object> map = new HashMap<>();
		map.put("uuid", uuid);
		map.put("beerNo", beerNo);
		ReviewVo vo = reviewDao.writtenReview(map);
		return vo;
	}
	
	// 최근 검색한 맥주 리스트
	public List<BeerVo> getCookieList(Cookie[] cookies){
		List<BeerVo> list = new ArrayList<BeerVo>();
		if (cookies != null) {
			for(Cookie cookie : cookies) {
				if("beerViewed".equals(cookie.getName())) {
					String cookieValue;
					try {
						cookieValue = URLDecoder.decode(cookie.getValue(), "UTF-8");
						String[] cookieVals = cookieValue.split(",");
						for(String cookieVal : cookieVals) {
							if(cookieVal.length() != 0) {
								BeerVo vo = beerDao.selectBeerByNo(Integer.valueOf(cookieVal));
								list.add(vo);
							}
						}
					} catch (UnsupportedEncodingException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}
		}
		return list;
	}
	
	// 쿠키 생성
	public String setCookieList(Cookie[] cookies, int beerNo) {
		String cookieValue = "";
		if (cookies != null) {
			for(Cookie cookie : cookies) {
				if("beerViewed".equals(cookie.getName())) {
					try {
						cookieValue = URLDecoder.decode(cookie.getValue(), "UTF-8");
					} catch (UnsupportedEncodingException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}
		}
		String[] cookieVals = cookieValue.split(",");
		boolean isCookieExist = false;
		// 쿠키 중복 체크
		for(String cookieVal: cookieVals) {
			if(cookieVal.equals(Integer.toString(beerNo))) {
				isCookieExist = true;
				break;
			}
		}
		if(!isCookieExist) {
			cookieValue = cookieValue + ',' + beerNo;
		}
		return cookieValue;
	}
	
	// ElasticSearch connect
	public RestHighLevelClient createConnection() {
		return new RestHighLevelClient(
				RestClient.builder(new HttpHost("localhost", 9200, "http")));
	}
	
	// ElasticSearch API
	public List<BeerVo> search(String keyword) {
		
		SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();
		searchSourceBuilder.query(QueryBuilders.matchQuery("beername", keyword));
		searchSourceBuilder.from(0);
		searchSourceBuilder.size(20);
		searchSourceBuilder.sort(
				new FieldSortBuilder("beerno").order(SortOrder.DESC));
		
		SearchRequest request = new SearchRequest("beer");		
		request.source(searchSourceBuilder);
		
		SearchResponse response = null;
		SearchHits searchHits = null;
		List<BeerVo> resultList = new ArrayList<BeerVo>();
		try {
			RestHighLevelClient client = createConnection();
			response = client.search(request, RequestOptions.DEFAULT);
			searchHits = response.getHits();
			for(SearchHit hit : searchHits) {
				Map<String, Object> sourceAsMap = hit.getSourceAsMap();
				BeerVo vo = mapToVo(sourceAsMap);
				resultList.add(vo);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}

		return resultList;
	}
	
	// 검색결과 map을 vo객체로 변환
	public BeerVo mapToVo(Map<String, Object> map) {
		BeerVo vo = new BeerVo();
		vo.setBeerNo((Integer)map.get("beerno"));
		if(map.get("abv") instanceof Integer) {
			vo.setAbv((Integer)map.get("abv"));
		} else {
			vo.setAbv((Double)map.get("abv"));
		}
		vo.setBeerName((String)map.get("beername"));
		vo.setCompany((String)map.get("company"));
		vo.setCountry((String)map.get("country"));
		vo.setNote((String)map.get("note"));
		if(map.get("rating") instanceof Integer) {
			vo.setRating((Integer)map.get("rating"));
		} else {
			vo.setRating((Double)map.get("rating"));
		}
		if(map.get("ratingba") instanceof Integer) {
			vo.setRatingBA((Integer)map.get("ratingba"));
		} else {
			vo.setRatingBA((Double)map.get("ratingba"));
		}
		vo.setType((String)map.get("type"));
		return vo;
	}
}
