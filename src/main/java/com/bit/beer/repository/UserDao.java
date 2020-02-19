package com.bit.beer.repository;

public interface UserDao {
	public int insert(UserVo vo);	// 가입 INSERT
	public UserVo selectUser(String kakaoId);	// 가입여부체크
	public int update(UserVo vo);	// 개인 정보 변경
}
