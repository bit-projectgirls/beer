package com.bit.beer.repository;

public class BeerVo {
	private int idx;
	private int beerNo;
	private String beerName;
	private String beerPic;
	private String type;
	private String country;
	private String company;
	private double abv;
	private double rating;
	private double ratingBA;
	private String note;
	private boolean chkBLike;
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getBeerNo() {
		return beerNo;
	}
	public void setBeerNo(int beerNo) {
		this.beerNo = beerNo;
	}
	public String getBeerName() {
		return beerName;
	}
	public void setBeerName(String beerName) {
		this.beerName = beerName;
	}
	public String getBeerPic() {
		return beerPic;
	}
	public void setBeerPic(String beerPic) {
		this.beerPic = beerPic;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public double getAbv() {
		return abv;
	}
	public void setAbv(double abv) {
		this.abv = abv;
	}
	public double getRating() {
		return rating;
	}
	public void setRating(double rating) {
		this.rating = rating;
	}
	public double getRatingBA() {
		return ratingBA;
	}
	public void setRatingBA(double ratingBA) {
		this.ratingBA = ratingBA;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public boolean ischkBLike() {
		return chkBLike;
	}
	public void setchkBLike(boolean chkBLike) {
		this.chkBLike = chkBLike;
	}
	
	
}