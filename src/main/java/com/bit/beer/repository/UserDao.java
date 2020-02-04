package com.bit.beer.repository;

import java.util.HashMap;

public interface UserDao {
	public int insert(UserVo vo);	// 가입 INSERT
	public UserVo selectUser(String kakaoId);	// 가입여부체크
}
