package com.bit.beer.repository;

import java.util.Date;

public class ReviewVo {
	private String reviewNo;
	private String uuid;
	private String nickname;
	private String userPic;
	private int beerNo;
	private String reviewContent;
	private String reviewPic;
	private double rating;
	private Date regDate;
	private int likeCnt;
	
	public String getUserPic() {
		return userPic;
	}
	public void setUserPic(String userPic) {
		this.userPic = userPic;
	}
	public String getReviewNo() {
		return reviewNo;
	}
	public void setReviewNo(String reviewNo) {
		this.reviewNo = reviewNo;
	}
	public String getUuid() {
		return uuid;
	}
	public void setUuid(String uuid) {
		this.uuid = uuid;
	}
	public int getBeerNo() {
		return beerNo;
	}
	public void setBeerNo(int beerNo) {
		this.beerNo = beerNo;
	}
	public String getReviewContent() {
		return reviewContent;
	}
	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}
	public String getReviewPic() {
		return reviewPic;
	}
	public void setReviewPic(String reviewPic) {
		this.reviewPic = reviewPic;
	}
	public double getRating() {
		return rating;
	}
	public void setRating(double rating) {
		this.rating = rating;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	public int getLikeCnt() {
		return likeCnt;
	}
	public void setLikeCnt(int likeCnt) {
		this.likeCnt = likeCnt;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	@Override
	public String toString() {
		return "ReviewVo [reviewNo=" + reviewNo + ", uuid=" + uuid + ", nickname=" + nickname + ", userPic=" + userPic
				+ ", beerNo=" + beerNo + ", reviewContent=" + reviewContent + ", reviewPic=" + reviewPic + ", rating="
				+ rating + ", regDate=" + regDate + ", likeCnt=" + likeCnt + "]";
	}
}
