package com.bit.beer.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class UserDaoImpl implements UserDao {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public int insert(UserVo vo) {
		int insertedCount = 0;
		try{
			insertedCount = sqlSession.insert("user.insert", vo);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return insertedCount;
	}

	@Override
	public UserVo selectUser(String kakaoId) {
		UserVo vo = sqlSession.selectOne("user.selectBykakaoId", kakaoId);
		return vo;
	}
}
