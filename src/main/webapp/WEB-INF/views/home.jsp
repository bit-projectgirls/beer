<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인</title>

<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
<!-- Bootstrap -->
<link rel="stylesheet" href="<c:url value="/resources/bootstrap/css/bootstrap.css"/>"/>
<!-- Link Swiper's CSS -->
<link rel="stylesheet" href="<c:url value="/resources/swiper.min.css"/>"/>
<!-- jQuery -->
<script src="<c:url value="/resources/jquery/jquery-3.4.1.min.js"/>"></script>
<!-- Swiper JS -->
<script src="<c:url value="/resources/swiper.min.js"/>"></script>
<!-- star rating -->
<link href="<c:url value="/resources/star-rating.css"/>" media="all" rel="stylesheet" type="text/css" />
<script src="<c:url value="/resources/star-rating.js"/>" type="text/javascript"></script>
<link href="<c:url value="/resources/krajee-fa/theme.css"/>" media="all" rel="stylesheet" type="text/css" />
<script src="<c:url value="/resources/krajee-fa/theme.js"/>" type="text/javascript"></script>
<!-- font awesome -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.12.1/css/all.css" integrity="sha384-v8BU367qNbs/aIZIxuivaU55N5GPF89WBerHoGA4QTcbUjYiLQtKdrfXnqAcXyTv" crossorigin="anonymous">
<!-- Google Font -->
<link href="https://fonts.googleapis.com/css?family=Knewave|Nanum+Gothic&display=swap" rel="stylesheet">
<style>
	html, body {
	    position: relative;
	    height: 100%;
	}
	body {
		font-family: 'Nanum Gothic', sans-serif;
		background-color: #323940;
	    margin:0;
	    padding:0;
	}
	.wrap {
		padding-bottom: 70px;
	}
	h5 {
		margin: 0;
	}
	.swiper-container {
	    width: 100%;
	    height: 200px;
	}
	.swiper-slide {
	    font-size: 18px;
	    /* Center slide text vertically */
	    display: -webkit-box;
	    display: -ms-flexbox;
	    display: -webkit-flex;
	    display: flex;
	    -webkit-box-pack: center;
	    -ms-flex-pack: center;
	    -webkit-justify-content: center;
	    justify-content: center;
	    -webkit-box-align: center;
	    -ms-flex-align: center;
	    -webkit-align-items: center;
	    align-items: center;
	}
	.swiper-container-horizontal>.swiper-pagination-bullets {
		bottom: 0px;
	}
	.swiper-pagination-bullet-active {
		background: #fde16d;
	}
	.swiper-pagination-bullet {
		background: #fff;
	}
	.navbar {
		background:#fff;
		z-index:99;
	  	position:fixed;
	  	bottom: 0;
	  	width: 100%;
	}
	.searchbox {
		margin:10px auto;
		width:300px;
		height:50px;
		vertical-align: middle;
		white-space: nowrap;
		position: relative;
	}
	.searchbox input#search {
		width: 300px;
		height: 40px;
		background: #fde16d;
		border: none;
		font-size: 10pt;
		float: left;
		color: #63717f;
		padding-left: 45px;
		border-radius: 20px;
	}
	.searchbox .icon {
		position: absolute;
		top: 20%;
		left: 20px;
		z-index: 1;
		color: #323940;
	}
	.title {
		width: 300px;
		margin: 10px auto 0px;
		color: #fff;
		position: relative;
		top: 20px;
	}
	.beercard {
		width: 300px;
		height: 150px;
		margin: 10px auto;
		border-radius: 20px;
		background: #fff;
	}
	.beerpic {
		text-align: center;
		width:60px;
		height:120px;
		float:left;
		margin: 15px;
	}
	.beerpic img{
		height: 120px;
	}
	.lst_dsc {
		height: 150px;
		padding: 15px;
		margin: 0;
	}
	.company, .beerinfo {
		color: #323940;
		font-size: 0.7em;
		margin: 0;
		overflow: hidden; 
		text-overflow: ellipsis;
		white-space: nowrap;
		width: 190px;
	}
	.beerrating {
		font-size: 1.0em;
	}
	.beername {
		font-size: 1.4em;
		line-height: 1.1em;
		margin: 0;
		width: 190px;
		height: 55px;
		overflow: hidden;
		display: -webkit-box;
		-webkit-line-clamp: 2;
		-webkit-box-orient: vertical;
	}
	.beername a {
		color: #000;
	}
	.rating-container .empty-stars {
		color: #fcba03;
	}
	.rating-container .filled-stars {
		color: #fcba03;
	}
	.beeridx {
		display: none;
	}
	.likeArea {
		font-size: 1.1em;
		color: #ff7575;
		float : right;
		margin: 0;
		padding: 0;
		position: relative;
		bottom: 5px;
		right: 2px;
	}
	.rating-container, .ratingcap {
		float: left;
	}
	.rating-xs  {
    	font-size: 0.5em;
	}
</style>
</head>
<body>
	<div class="wrap">
	<h3 align="center">Beer Searcher</h3>
	<div class="searchbox">
		<a href="<c:url value="/search"/>">
			<input type="search" name="keyword" id="search">
			<span class="icon"><i class="fas fa-search fa-lg"></i></span>
		</a>
	</div>
	<h5 class="title">우리 TOP 10 리스트</h5>
	<!-- Swiper -->
	<div class="swiper-container">
		<div class="swiper-wrapper">
			<c:forEach items="${ beerList }" var="beerVo">
			<div class="swiper-slide">
				<div class="beercard">
					<div class='beerpic'><img src="<c:url value="${ beerVo.beerPic }"/>"></div>
					<dl class='lst_dsc'>
						<dd class='company'>${ beerVo.company }</dd>
						<dd class='beeridx' data-idx="${ beerVo.idx }"></dd>
						<dt class='beername'><a href="<c:url value="/beer/${ beerVo.beerNo }"/>" target='_blank'>${ beerVo.beerName }</a></dt>
						<dd class='beerinfo'>${ beerVo.type } from ${ beerVo.country }</dd>
						<dd class='beerrating'><div class='ratingcap'>${ beerVo.ratingBA }</div><input name='ratingBA' value='${ beerVo.ratingBA }' class='kv-fa rating'></dd>
						<c:if test='${ not empty authUser }'>
						<dd id='like${beerVo.beerNo }' class='likeArea' onclick='bLike(${ beerVo.beerNo})'>
							<c:set var='chkLike' value='false' />
							<c:forEach items='${ bLikeList }' var='likeVo'>
								<c:if test='${ likeVo.beerNo eq beerVo.beerNo }'>
									<c:set var='chkLike' value='true' />
								</c:if>
							</c:forEach>
							<c:choose>
							<c:when test='${ chkLike == true }'>
							<i class='fas fa-heart'></i>
							</c:when>
							<c:otherwise>
							<i class='far fa-heart'></i>
							</c:otherwise>
							</c:choose>
						</dd>
						</c:if>
					</dl>
				</div>
			</div>
			</c:forEach>
		</div>
		<!-- Add Pagination -->
		<div class="swiper-pagination"></div>
	</div>
	<h5 class="title">Beeradvocate TOP 10 리스트</h5>
	<!-- Swiper -->
	<div class="swiper-container">
		<div class="swiper-wrapper">
			<c:forEach items="${ beerListBA }" var="beerVo">
			<div class="swiper-slide">
				<div class="beercard">
					<div class='beerpic'><img src="<c:url value="${ beerVo.beerPic }"/>"></div>
					<dl class='lst_dsc'>
						<dd class='company'>${ beerVo.company }</dd>
						<dd class='beeridx' data-idx="${ beerVo.idx }"></dd>
						<dt class='beername'><a href="<c:url value="/beer/${ beerVo.beerNo }"/>" target='_blank'>${ beerVo.beerName }</a></dt>
						<dd class='beerinfo'>${ beerVo.type } from ${ beerVo.country }</dd>
						<dd class='beerrating'><div class="ratingcap">${ beerVo.ratingBA }</div><input name="ratingBA" value="${ beerVo.ratingBA }" class="kv-fa rating"></dd>
						<c:if test='${ not empty authUser }'>
						<dd id='like${beerVo.beerNo }' class='likeArea' onclick='bLike(${ beerVo.beerNo})'>
							<c:set var='chkLike' value='false' />
							<c:forEach items='${ bLikeList }' var='likeVo'>
								<c:if test='${ likeVo.beerNo eq beerVo.beerNo }'>
									<c:set var='chkLike' value='true' />
								</c:if>
							</c:forEach>
							<c:choose>
							<c:when test='${ chkLike == true }'>
							<i class='fas fa-heart'></i>
							</c:when>
							<c:otherwise>
							<i class='far fa-heart'></i>
							</c:otherwise>
							</c:choose>
						</dd>
						</c:if>
					</dl>
				</div>
			</div>
			</c:forEach>
		</div>
		<!-- Add Pagination -->
		<div class="swiper-pagination"></div>
	</div>
	</div>
	<footer class="navbar">
		<c:import url="/WEB-INF/views/footer.jsp"/>
	</footer>
</body>
<!-- Initialize Swiper -->
<script>
	var swiper = new Swiper('.swiper-container', {
		pagination: {
		el: '.swiper-pagination',
		}
	});
	
	$("input[name='ratingBA']").rating({
		displayOnly: true,
		size: 'xs',
		step: 0.5,
		showCaption: false,
		theme: 'krajee-fa',
      filledStar: '<i class="fas fa-star"></i>',
      emptyStar: '<i class="far fa-star"></i>',
	});
	
	function bLike(beerNo){
		console.log(beerNo);
		$.ajax({
			url:"<c:url value="/blike"/>",
			dataType : "json",
		    type : "post",
		    data : {beerNo: beerNo},
		    success : function(result){
		    	if(result.chkLike){
		    		var html = "<i class='fas fa-heart'></i>";
		    		$("#like"+result.beerNo).html(html);
		    	} else {
		    		var html = "<i class='far fa-heart'></i>";
		    		$("#like"+result.beerNo).html(html);
		    	}
		    }
		})
	}
</script>
</html>