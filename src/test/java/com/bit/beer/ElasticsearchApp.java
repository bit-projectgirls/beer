package com.bit.beer;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.http.HttpHost;
import org.elasticsearch.action.get.GetRequest;
import org.elasticsearch.action.get.GetResponse;
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

import com.google.gson.Gson;


public class ElasticsearchApp {
	static Gson gson = new Gson();
	
	public static RestHighLevelClient createConnection() {
		return new RestHighLevelClient(
				RestClient.builder(new HttpHost("localhost", 9200, "http")));
	}
	
	public static Object search() {
		String indexName = "users";
		String docId = "w0Pfxm8B4aOK7XohUaPl";
		
		GetRequest request = new GetRequest(indexName, docId);
		GetResponse response = null;
		try{
			RestHighLevelClient client = createConnection();
			response = client.get(request, RequestOptions.DEFAULT);
		}catch (Exception e) {
			e.printStackTrace();
			return "문서조회 실패";
		}
		Map<String, Object> sourceAsMap = null;
		if(response.isExists()) {
			long version = response.getVersion();
			sourceAsMap = response.getSourceAsMap();
			System.out.println(sourceAsMap.toString());
		}
		return gson.toJson(sourceAsMap);
	}
	
	public static String match(String keyword) {
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
		List<Map> resultMap = new ArrayList<Map>();
		try {
			RestHighLevelClient client = createConnection();
			response = client.search(request, RequestOptions.DEFAULT);
			searchHits = response.getHits();
			for(SearchHit hit : searchHits) {
				Map<String, Object> sourceAsMap = hit.getSourceAsMap();
				resultMap.add(sourceAsMap);
			}
		}catch(Exception e) {
			e.printStackTrace();
			return "문서조회 실패";
		}
		return gson.toJson(resultMap);
	}
	public static void main(String[] args) throws IOException {
		Object test = search();
		String result = match("peng");
		System.out.println(result);
//		RestHighLevelClient client = new RestHighLevelClient(
//		        RestClient.builder(
//		                new HttpHost("localhost", 9200, "http"),
//		                new HttpHost("localhost", 9201, "http")));
//		
//		XContentBuilder builder = XContentFactory.jsonBuilder();
//		builder.startObject();
//		{
//		    builder.field("user", "kimchy");
//		    builder.timeField("postDate", new Date());
//		    builder.field("message", "trying out Elasticsearch");
//		}
//		builder.endObject();
//		IndexRequest indexRequest = new IndexRequest("posts")
//		    .id("1").source(builder); 
//		indexRequest.
////		IndexRequest indexRequest = new IndexRequest("posts")
////			    .id("1")
////			    .source("user", "kimchy",
////			        "postDate", new Date(),
////			        "message", "trying out Elasticsearch"); 
//		
//		GetRequest getRequest = new GetRequest("users", "w0Pfxm8B4aOK7XohUaPl");
//		GetRequest getRequest2 = new GetRequest("posts", "1");
//		System.out.println(getRequest.toString());
//		System.out.println(getRequest2.toString());
//		
////		client.close();
////		SearchRequest searchRequest = new SearchRequest(); 
////		SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder(); 
////		searchSourceBuilder.query(QueryBuilders.matchAllQuery()); 
////		searchRequest.source(searchSourceBuilder); 
	
	}
}

