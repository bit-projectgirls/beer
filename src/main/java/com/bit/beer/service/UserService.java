package com.bit.beer.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.beer.repository.BeerDaoImpl;
import com.bit.beer.repository.BeerVo;
import com.bit.beer.repository.ReviewDaoImpl;
import com.bit.beer.repository.ReviewVo;
import com.bit.beer.repository.UserDaoImpl;
import com.bit.beer.repository.UserVo;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@Service
public class UserService {
	@Autowired
	private UserDaoImpl userDao;
	@Autowired
	private BeerDaoImpl beerDao;
	@Autowired
	private ReviewDaoImpl reviewDao;
	
	private static final Logger logger = LoggerFactory.getLogger(UserService.class);

	// 카카오API
	public String getAccessToken(String authorize_code) {
		String access_token = "";
		String refresh_token = "";
		String reqURL = "https://kauth.kakao.com/oauth/token";
		
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection)url.openConnection();
			
			// POST 요청을 위해 setDoOutput -> true
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			
			// POST 필요 파라미터 전송
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			StringBuilder sb = new StringBuilder();
			sb.append("grant_type=authorization_code");
			sb.append("&client_id=247c6d507dbd703741920ee35f89946e");
			sb.append("&redirect_uri=http://localhost:8080/beer/login");
			sb.append("&code=" + authorize_code);
			bw.write(sb.toString());
			bw.flush();
			
			// 결과 코드 200이면 성공
			int responseCode = conn.getResponseCode();
			logger.info("responseCode: " + responseCode);
			
			// JSON타입의 Response 메세지 읽어오기
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "";
			String result = "";
			
			while((line = br.readLine()) != null) {
				result += line;
			}
			logger.info("responseBody: " + result);
			
			// JSON파싱 객체 생성
			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);
			
			access_token = element.getAsJsonObject().get("access_token").getAsString();
			refresh_token = element.getAsJsonObject().get("refresh_token").getAsString();
			logger.info("access_token: " + access_token);
			logger.info("refresh_token: " + refresh_token);
			br.close();
			bw.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return access_token;
	}
	
	public HashMap<String, String> getUserInfo(String access_token) {
		HashMap<String, String> userInfo = new HashMap<String, String>();
		String reqURL = "https://kapi.kakao.com/v2/user/me";
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection)url.openConnection();
			conn.setRequestMethod("POST");
			
			// 요청에 필요한 Header에 포함될 내용
			conn.setRequestProperty("Authorization", "Bearer " + access_token);
			int responseCode = conn.getResponseCode();
			logger.info("responseCode: " + responseCode);
			
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "";
			String result = "";
			
			while((line = br.readLine()) != null) {
				result += line;
			}
			logger.info("responseBody: " + result);
			
			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);
			JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
			JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
			
			String kakaoId = element.getAsJsonObject().get("id").getAsString();
			String nickname = properties.getAsJsonObject().get("nickname").getAsString();
			String email = kakao_account.getAsJsonObject().get("email").getAsString();
			String userPic = properties.getAsJsonObject().get("profile_image").getAsString();
			
			userInfo.put("kakaoId", kakaoId);
			userInfo.put("nickname", nickname);
			userInfo.put("email", email);
			userInfo.put("userPic", userPic);

		} catch(IOException e) {
			e.printStackTrace();
		}
		return userInfo;
	}
	
	public void kakaoLogout(String access_token) {
	    String reqURL = "https://kapi.kakao.com/v1/user/logout";
	    try {
	        URL url = new URL(reqURL);
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("POST");
	        conn.setRequestProperty("Authorization", "Bearer " + access_token);
	        
	        int responseCode = conn.getResponseCode();
	        logger.info("responseCode : " + responseCode);
	        
	        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        
	        String result = "";
	        String line = "";
	        
	        while ((line = br.readLine()) != null) {
	            result += line;
	        }
	        logger.info(result);
	    } catch (IOException e) {
	        // TODO Auto-generated catch block
	        e.printStackTrace();
	    }
	}
	
	// 가입
	public boolean join(String access_token) {
		UserVo vo = new UserVo();
		HashMap<String, String> userInfo = getUserInfo(access_token);
		
		vo.setEmail(userInfo.get("email"));
		vo.setKakaoId(userInfo.get("kakaoId"));
		vo.setNickname(userInfo.get("nickname"));
		vo.setUserPic(userInfo.get("userPic"));
		vo.setUuid(UUID.randomUUID().toString());
		logger.info("가입정보: " + vo.toString());
		
		int insertedCount = userDao.insert(vo);
		return 1 == insertedCount;
	}
	
	// 가입여부 체크
	public UserVo checkId(String kakaoId) {
		logger.info("checkId: " + kakaoId);
		UserVo vo = userDao.selectUser(kakaoId);
		return vo;
	}
	
	// 작성한 리뷰 목록 받아오기
	public List<ReviewVo> getReviewList(String uuid){
		List<ReviewVo> list = reviewDao.selectReviewByUuid(uuid);
		return list; 
	}
}
