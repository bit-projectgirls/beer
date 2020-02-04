package com.bit.beer.repository;

public class HashtagVo {
	private int tagNo;
	private String tagName;
	private int reviewNo;
	private int beerNo;
	
	public int getTagNo() {
		return tagNo;
	}
	public void setTagNo(int tagNo) {
		this.tagNo = tagNo;
	}
	public String getTagName() {
		return tagName;
	}
	public void setTagName(String tagName) {
		this.tagName = tagName;
	}
	public int getReviewNo() {
		return reviewNo;
	}
	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}
	public int getBeerNo() {
		return beerNo;
	}
	public void setBeerNo(int beerNo) {
		this.beerNo = beerNo;
	}
	
	@Override
	public String toString() {
		return "HashtagVo [tagNo=" + tagNo + ", tagName=" + tagName + ", reviewNo=" + reviewNo + ", beerNo=" + beerNo
				+ "]";
	}
}
