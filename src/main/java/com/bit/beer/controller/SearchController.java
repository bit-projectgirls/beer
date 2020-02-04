package com.bit.beer.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

@Controller
public class SearchController {
	private static final Logger logger = LoggerFactory.getLogger(SearchController.class);
	private Gson gson = new Gson();

	public RestHighLevelClient createConnection() {
		return new RestHighLevelClient(
				RestClient.builder(new HttpHost("localhost", 9200, "http")));
	}
	
	// 맥주 검색
	@RequestMapping(value="/searchkeyword", method=RequestMethod.POST)
	public String search(@RequestParam(value="keyword") String keyword, Model model) {
		logger.info("search start: " + keyword);
		String indexName = "users";
		
		SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();
		searchSourceBuilder.query(QueryBuilders.matchQuery("id", keyword));
		searchSourceBuilder.from(0);
		searchSourceBuilder.size(10);
		searchSourceBuilder.sort(
				new FieldSortBuilder("userno").order(SortOrder.DESC));
		
		SearchRequest request = new SearchRequest(indexName);		
		request.source(searchSourceBuilder);
		
		SearchResponse response = null;
		SearchHits searchHits = null;
		List<Map<String, Object>> resultList = new ArrayList<Map<String,Object>>();
		try {
			RestHighLevelClient client = createConnection();
			response = client.search(request, RequestOptions.DEFAULT);
			searchHits = response.getHits();
			for(SearchHit hit : searchHits) {
				Map<String, Object> sourceAsMap = hit.getSourceAsMap();
				resultList.add(sourceAsMap);
			}
		}catch(Exception e) {
			e.printStackTrace();
			return "문서조회 실패";
		}
		model.addAttribute("list", resultList);
		return "searchresult";
	}
	
	// 해시태그 검색
	@RequestMapping(value = "/searchtag", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/text; charset=utf8")
	@ResponseBody
	public String getMap(@RequestParam(value="keyword") String keyword) {
		logger.info("search tag start: " + keyword);
		String indexName = "users";
		
		SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();
		searchSourceBuilder.query(QueryBuilders.matchQuery("username", keyword));
		searchSourceBuilder.from(0);
		searchSourceBuilder.size(10);
		searchSourceBuilder.sort(
				new FieldSortBuilder("userno").order(SortOrder.DESC));
		
		SearchRequest request = new SearchRequest(indexName);		
		request.source(searchSourceBuilder);
		
		SearchResponse response = null;
		SearchHits searchHits = null;
		List<Map<String, Object>> resultList = new ArrayList<Map<String,Object>>();
		try {
			RestHighLevelClient client = createConnection();
			response = client.search(request, RequestOptions.DEFAULT);
			searchHits = response.getHits();
			for(SearchHit hit : searchHits) {
				Map<String, Object> sourceAsMap = hit.getSourceAsMap();
				resultList.add(sourceAsMap);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return gson.toJson(resultList);
	}
	
	// 나라 검색
	@RequestMapping(value="/searchcountry", method=RequestMethod.POST)
	public String searchCountry(@RequestParam(value="keyword") String keyword, Model model) {
		logger.info("search start: " + keyword);
		String indexName = "users";
		
		SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();
		searchSourceBuilder.query(QueryBuilders.matchQuery("id", keyword));
		searchSourceBuilder.from(0);
		searchSourceBuilder.size(10);
		searchSourceBuilder.sort(
				new FieldSortBuilder("userno").order(SortOrder.DESC));
		
		SearchRequest request = new SearchRequest(indexName);		
		request.source(searchSourceBuilder);
		
		SearchResponse response = null;
		SearchHits searchHits = null;
		List<Map<String, Object>> resultList = new ArrayList<Map<String,Object>>();
		try {
			RestHighLevelClient client = createConnection();
			response = client.search(request, RequestOptions.DEFAULT);
			searchHits = response.getHits();
			for(SearchHit hit : searchHits) {
				Map<String, Object> sourceAsMap = hit.getSourceAsMap();
				resultList.add(sourceAsMap);
			}
		}catch(Exception e) {
			e.printStackTrace();
			return "문서조회 실패";
		}
		model.addAttribute("list", resultList);
		return "searchresult";
	}
}
