package com.bit.beer.repository;

import java.util.Date;

public class UserVo {
	private String uuid;
	private String email;
	private String nickname;
	private String kakaoId;
	private String userPic;
	private Date joinDate;
	
	public String getUuid() {
		return uuid;
	}
	public void setUuid(String uuid) {
		this.uuid = uuid;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getPassword() {
		return kakaoId;
	}
	public void setKakaoId(String kakaoId) {
		this.kakaoId = kakaoId;
	}
	public String getUserPic() {
		return userPic;
	}
	public void setUserPic(String userPic) {
		this.userPic = userPic;
	}
	public Date getJoinDate() {
		return joinDate;
	}
	public void setJoinDate(Date joinDate) {
		this.joinDate = joinDate;
	}
	
	@Override
	public String toString() {
		return "UserVo [uuid=" + uuid + ", email=" + email + ", nickname=" + nickname + ", kakaoId=" + kakaoId
				+ ", userPic=" + userPic + ", joinDate=" + joinDate + "]";
	}
	
}

