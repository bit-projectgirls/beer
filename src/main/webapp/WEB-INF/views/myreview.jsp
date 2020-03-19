<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width"/>
<title>My Beer List</title>
<!-- Bootstrap -->
<link rel="stylesheet" href="<c:url value="/resources/bootstrap/css/bootstrap.css"/>"/>
<!-- jQuery -->
<script src="<c:url value="/resources/jquery/jquery-3.4.1.min.js"/>"></script>
<!-- font awesome -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.12.1/css/all.css" integrity="sha384-v8BU367qNbs/aIZIxuivaU55N5GPF89WBerHoGA4QTcbUjYiLQtKdrfXnqAcXyTv" crossorigin="anonymous">
<!-- star rating -->
<link href="<c:url value="/resources/star-rating.css"/>" media="all" rel="stylesheet" type="text/css" />
<script src="<c:url value="/resources/star-rating.js"/>" type="text/javascript"></script>
<link href="<c:url value="/resources/krajee-fa/theme.css"/>" media="all" rel="stylesheet" type="text/css" />
<script src="<c:url value="/resources/krajee-fa/theme.js"/>" type="text/javascript"></script>
<!-- Google Font -->
<link href="https://fonts.googleapis.com/css?family=Knewave|Nanum+Gothic&display=swap" rel="stylesheet">
<!-- readmore -->
<script src="<c:url value="/resources/readmore.min.js"/>"></script>
<style>
	html, body {
	    position: relative;
	}
	body {
	    font-family: 'Nanum Gothic', sans-serif;
		margin:0;
	    padding:0;
	}
	a:active, a:visited, a:hover {
		text-decoration: none;
	}
	.wrap {
		margin-top: 60px;
		margin-bottom: 100px;		
	}
	.navbar {
		background:#fff;
		z-index:99;
	  	position:fixed;
	  	bottom: 0;
	  	width: 100%;
	}
	.header {
		z-index: 1;
		position: fixed;
		top:0;
		width: 100%;
		height: 50px;	
		color: #323940;
		background-color: #fde16d;
		margin: 0;
		padding: 10px 20px;
		text-align: center;
	}
	.header a{
		color: #323940;
		float: left;
	}
	.pagetitle {
		margin: 8px;
		font-size: 18px;
	}
	.delbtn {
		font-size: 0.8em;
		float: right;
		margin: 0;
		padding: 3px 7px;
		color: #323940;
		border: 0;
		background-color: #fde16d;
		border-radius: 20px;
		position: relative;
    	right: -10px;
	}
	.reviewitem {
		width: 90%;
		border: 1px solid;
		border-radius: 20px;
		padding: 10px 20px;
		margin: 10px auto;
	}
	.reviewcnt {
		margin: 10px 0px;
		line-height: 17px;
		overflow:hidden;
		min-height: 10px;
		max-height: 95px;
	}
	.reviewcnt a {
		color: #35b0cc;
	}
	.reviewrating {
	  	height: 20px;
		margin: 0px;
	}
	.rating-container, .ratingcap {
    	float: left;
    	font-size: 0.8em;
	}
	.regdate {
		width: 50px;
	    margin: 0;
	    font-size: 0.8em;
	    float: right;
	}
	.rating-xs  {
    	font-size: 0.8em;
	}
	hr {
		margin: 0 auto 10px;		
	}
	.beerinfo {
		margin: 0;
		height: 60px;
	}
	.beerinfo i {
		float: right;
    	position: relative;
    	bottom: 50px;
	}
	.beerpic {
		text-align: center;
		float:left;
		width: 30px;
		height: 60px;
		margin-right: 10px;
	}
	.beerpic img{
		height: 60px;
	}
	.company, .country {
		margin: 0;
		font-size: 0.6em;
		overflow: hidden; 
		text-overflow: ellipsis;
		white-space: nowrap;
		width: 175px;
	}
	.beername{
		font-size: 1.0em;
		overflow: hidden; 
		text-overflow: ellipsis;
		white-space: nowrap;
		width: 175px;
	}
</style>
</head>
<body>
	<div class="header">
		<a href="<c:url value="/mypage"/>"><i class="fas fa-chevron-left fa-2x"></i></a>
		<h4 class="pagetitle"><strong>나의 리뷰 리스트</strong></h4>
	</div>
	<div class="wrap">
	 	<c:if test="${ empty reviewList }">
		아직 작성하신 리뷰가 없어요.
		</c:if>
		<c:if test="${ not empty reviewList }">
		<c:forEach items="${ reviewList }" var="reviewVo" varStatus="status">
		<dl class="reviewitem" id="review${ status.index }">
			<form name="frm${ status.index }" action='<c:url value="/deletereview"/>' method="POST">
			<input type="hidden" name="reviewNo" value='${ reviewVo.reviewNo }'>
			<input type="hidden" name="reviewContent" value='${ reviewVo.reviewContent }'>
			<input class="delbtn" type="submit" value="삭제">
			</form>
			<dd class="reviewcnt">${ reviewVo.reviewContent }</dd>
			<dd class="reviewrating">
				<input name="ratingReview" value="${ reviewVo.rating }" class="rating">
				<div class="ratingcap">${ reviewVo.rating }</div>
				<div class="regdate"><fmt:formatDate value="${ reviewVo.regDate }" pattern="yy.MM.dd"/></div>
			</dd>
			<hr/>
			<dd class="beerinfo" onclick='window.open("<c:url value="/beer/${ reviewVo.beerNo }"/>")'>
				<div class='beerpic'><img src="<c:url value="${ beerList[status.index].beerPic }"/>"></div>
				<dl class="beeritem">
				<dt class='beername'>${ beerList[status.index].beerName }</dt>
				<dd class="company">${ beerList[status.index].company }</dd>
				<dd class='country'>${ beerList[status.index].type } from ${ beerList[status.index].country }</dd>
				</dl>
				<i class="fas fa-angle-right fa-lg"></i>
			</dd>
		</dl>
		</c:forEach>
		</c:if>
	</div>
	<footer class="navbar">
		<c:import url="/WEB-INF/views/footer.jsp"/>
	</footer>
</body>
<script>
	$('.reviewcnt').readmore({
		speed: 500,
		collapsedHeight: 95,
		moreLink: '<i class="fas fa-angle-down fa-sm"></i>',
		lessLink: '<i class="fas fa-angle-up fa-sm"></i>'
	})
	$(".rating").rating({
		displayOnly: true,
		size: 'xs',
		step: 0.5,
		showCaption: false,
		theme: 'krajee-fa',
	    filledStar: '<i class="fas fa-star"></i>',
	    emptyStar: '<i class="far fa-star"></i>',
	    showClear: false
	    });
</script>
</html>