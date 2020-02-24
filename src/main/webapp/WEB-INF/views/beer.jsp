<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="x-ua-compatible" content="ie=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<!-- Bootstrap -->
<link rel="stylesheet" href="<c:url value="/resources/bootstrap/css/bootstrap.css"/>"/>
<!-- jQuery -->
<script src="<c:url value="/resources/jquery/jquery-3.4.1.min.js"/>"></script>
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
		margin:0;
	    padding:0;
	}
	.header {
		position: fixed;
		top:0;
		width: 100%;
		height: 50px;
		padding: 10px 20px;
		margin: 0;
	}
	.header a{
		color: #fde16d;
	}
	.wrap {
		margin-top: 50px;
	}
	.ratingArea {
		background-color: #fde16d;
		border-radius: 20px;
		width: 250px;
		height: 100px;
		margin: 0 auto;
	}
	.ratingBA, .ratingBS {
		float:left;
		width: 100px;
		height: 100px;
		margin: 12.5px;
	}
	.logo {
		width: 100px;
	}
	.beerimg {
		margin: 0 auto;
		width: 150px;
		height: 250px;
		border: 1px solid;
	}
	.beerInfo {
		margin: 20px;
	}
	.beerInfo dd{
		margin:0;
		line-height: 1.0em;
	}
	.beername {
		font-family: 'Knewave', cursive;
		font-size: 1.5em;
		line-height: 1.2em;
		margin-bottom: 8px;
	}
	.likeArea {
		width: 30px;
		height: 30px;
		position: relative;
		float: right;
		color: #ff7575;
		bottom: 52px;
		right: 24px;
	}
	.reviewArea{
		margin-top: 20px;
		width: 100%;
		border-top-right-radius: 20px;
		border-top-left-radius: 20px;
		background-color: #323940;
		padding-bottom:50px;
	}
	.myreview {
		padding-top: 10px;
		width: 100%;
		min-height: 100px;
	}
	.msg {
		color: #fff;
		height: 100px;
		width: 210px;
		margin: 0 auto;
		padding-top: 38px;
		text-align: center;
	}
	.msg a{
		color: #fff;
	}
	.ratingform {
		width: 270px;
		margin: 10px auto;
	}
	.menutitle {
		margin: 5px 20px 0 20px;
		font-size: 1.2em;
		color: #fde16d;
	}
	.reviewItem {
		color: #fff;
		padding: 10px 20px;
		margin: 0;
	}
	.reviewcnt {
		margin: 20px 0px;
		overflow: hidden;
		line-height: 19px;
		display: -webkit-box;
		-webkit-line-clamp: 5;
		-webkit-box-orient: vertical;
	}
	.reviewcnt a{
		color: #a8efff;
	}
	.reviewRating {
	  	height: 20px;
		margin: 1px;
	}
	.nickname{
		margin: 0;
		font-size: 0.9em;
	}
	.regdate {
		margin: 0;
		font-size: 0.6em;
	}
	.rating-xs  {
    	font-size: 0.8em;
	}
	.userPic {
		float:left;
		width: 30px;
		height: 30px;
		margin-right: 5px;
		object-fit: cover;
		object-position: top;
		border-radius: 50%;
	}
	hr {
		width: 90%;
		margin: 0 auto;
		border: 0.5px solid rgba(255, 255, 255, 0.5 );
		
	}
</style>
</head>
<body>	
	<div class="header">
		<a href="<c:url value="/list"/>" onclick="javascript:window.close()"><i class="fas fa-chevron-left fa-2x"></i></a>
	</div>
	<div class="wrap">
	<div class="beerimg">
	</div>	
	<dl class="beerInfo">
		<dd class='beerno' id="infoBeerNo" style="display:none;">${ beerVo.beerNo }</dd>
		<dd class="company">${ beerVo.company }</dd>
		<dt class="beername">${ beerVo.beerName }</dt>
		<dd>한글이름</dd>
	<dd class="type">${ beerVo.type } from ${ beerVo.country }</dd>
	</dl>
	<div class="likeArea" id="likeArea">
		<c:if test="${ not empty authUser }">
		<c:choose>
			<c:when test="${ chkLike == true }">
			<i class="fas fa-heart fa-2x"></i>
			</c:when>
			<c:otherwise>
			<i class="far fa-heart fa-2x"></i>
			</c:otherwise>
		</c:choose>
		</c:if>
	</div>
	<div class="ratingArea">
		<div class="ratingBA">
			<img class="logo" src="<c:url value="/img/beeradvocate-nav-logo.png"/>">
			<h1 align="center">${ beerVo.ratingBA }</h1>
		</div>
		<div class="ratingBS">
		우리별점<br/><h1 align="center">${ beerVo.rating }</h1>
		</div>
	</div>
	<div class="reviewArea">
		<div class="myreview">
			<c:if test="${ empty authUser }">
			<div class="msg">
			<a href="<c:url value="/mypage"/>">로그인 시 리뷰를 남길 수 있어요!</a>
			</div>
			</c:if>
			<c:if test="${ not empty authUser }">
			<c:choose>
				<c:when test="${ chkReview == true }">
				<div class="menutitle">내가 작성한 리뷰</div>
				<dl class="reviewItem">
					<c:if test="${ not empty writtenReview.reviewContent }">
					<dd class="reviewcnt">${ writtenReview.reviewContent }</dd>
					</c:if>
					<dd class="reviewRating"><input name="ratingReview" value="${ writtenReview.rating }"class="kv-fa rating"></dd>
					<dd class="nickname"><img class="userPic" src="${ writtenReview.userPic }"> ${ writtenReview.nickname }</dd>
					<dd class="regdate"><fmt:formatDate value="${ writtenReview.regDate }" pattern="yy.MM.dd"/></dd>
				</dl>
				</c:when>
				<c:otherwise>
				<div class="menutitle">리뷰 남기기></div>
				<div class="ratingform">
				<form id="ratingform" method="post" action="<c:url value="/reviewform"/>">
					<input id="beerNo" type="hidden" name="beerNo" value="${ beerVo.beerNo }">
					<input id="starRating" type="text" value="${ rating }" class="kv-fa rating">
				</form>
				</div>
				</c:otherwise>
			</c:choose>
			</c:if>
		</div>
		<hr>
		<div class="reviewlist">
		 	<div class="menutitle">리뷰</div>
		 	<c:if test="${ empty reviewList }">
		 	<div class="msg">아직 작성된 리뷰가 없어요!</div>
			</c:if>
			<c:if test="${ not empty reviewList }">
			<c:forEach items="${ reviewList }" var="reviewVo">
				<dl class="reviewItem">
					<c:if test="${ not empty reviewVo.reviewContent }">
					<dd class="reviewcnt">${ reviewVo.reviewContent }</dd>
					</c:if>
					<dd class="reviewRating"><input name="ratingReview" value="${ reviewVo.rating }" class="kv-fa rating"></dd>
					<dd class="nickname"><img class="userPic" src="${ reviewVo.userPic }"> ${ reviewVo.nickname }</dd>
					<dd class="regdate"><fmt:formatDate value="${ reviewVo.regDate }" pattern="yy.MM.dd"/></dd>
				</dl>
				<hr>
			</c:forEach>
			</c:if>
		</div>
	</div>
	</div>
</body>
<script>
	$("input[name='ratingBA']").rating({
		displayOnly: true,
		size: 'xs',
		step: 0.5,
		showCaption: false,
		theme: 'krajee-fa',
	  filledStar: '<i class="fas fa-star"></i>',
	  emptyStar: '<i class="far fa-star"></i>',
	});
	//star rating
	$("input[name='ratingReview']").rating({
		displayOnly: true,
		size: 'xs',
		step: 0.5,
		showCaption: false,
		theme: 'krajee-fa',
        filledStar: '<i class="fas fa-star"></i>',
        emptyStar: '<i class="far fa-star"></i>',
        });
	$('.kv-fa').rating({
            theme: 'krajee-fa',
            size: 'lg',
            filledStar: '<i class="fas fa-star"></i>',
            emptyStar: '<i class="far fa-star"></i>',
            showClear: false,
            showCaption: false
    });
	$("#starRating").on("rating:change", function(event){
		var formObj = document.forms["ratingform"];
    	var rating = document.getElementById("starRating").value;
    	console.log("click", rating);
    	// ajax로 맥주정보와 별점 콘트롤러로 전송
    	var inputRating = document.createElement("input");
    	inputRating.setAttribute("type", "hidden");
    	inputRating.setAttribute("name", "rating");
    	inputRating.setAttribute("value", rating);
    	formObj.appendChild(inputRating);
    	formObj.submit();
	});
	// 좋아요 기능
	$("#likeArea").on("click", function(event){
		var beerNo = $("#infoBeerNo").text();
		console.log(beerNo);
		$.ajax({
			url:"<c:url value="/blike"/>",
			dataType : "json",
		    type : "post",
		    data : {beerNo: beerNo},
		    success : function(result){
		    	if(result.chkLike){
		    		var html = "<i class='fas fa-heart fa-2x'></i>";
		    		$("#likeArea").html(html);
		    	} else {
		    		var html = "<i class='far fa-heart fa-2x'></i>";
		    		$("#likeArea").html(html);
		    	}
		    }
		})
	});
</script>