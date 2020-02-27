<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
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
<link href="https://fonts.googleapis.com/css?family=Coda:800|Knewave|Nanum+Gothic&display=swap" rel="stylesheet">
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
	a:active, a:visited, a:hover {
		text-decoration: none;
	}
	.header {
		z-index: 1;
		position: fixed;
		top:0;
		width: 100%;
		height: 60px;	
		color: #323940;
		background-color: #fde16d;
		margin: 0;
		padding: 0;
	}
	.header a{
		position:absolute;
		color: #323940;
		top: 4px;
		left: 15px;
		z-index: 1;
	}
	#recenttitle {
		color: #fff;
		padding-left: 20px;
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
		background: #fff;
		border: none;
		font-size: 10pt;
		float: left;
		color: #323940;
		padding-left: 45px;
		padding-right: 45px;
		border-radius: 20px;
	}
	.searchbox .icon{
		position: absolute;
		top: 11px;
		right: 15px;
		z-index: 1;
		color: #323940;
	}
	#searchresult{
	margin-top:70px;
	}
	ul {
		list-style:none;
		padding:0px;
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
		font-size: 0.8em;
		margin: 0;
		overflow: hidden; 
		text-overflow: ellipsis;
		white-space: nowrap;
		width: 190px;
	}
	.beerrating {
		font-size: 1.1em;
	}
	.beername {
		font-size: 1.5em;
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
<div class="header">

<div class="searchbox">
	<a href="<c:url value="/"/>"><i class="fas fa-chevron-left fa-2x"></i></a>
	<form name="searchform" action="" method="POST" onsubmit="return false;">
		<input type="search" name="keyword" id="search">
		<span class="icon"><i class="fas fa-search fa-lg"></i></span>
	</form>
</div>
</div>
<div id="searchresult">
	<h5 id="recenttitle">최근 검색 기록</h5>
	<ul id="beerlist" class="beerlist">
	<c:forEach items="${ beerList }" var="beerVo">
		<li class='beercard'>
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
		</li>
	</c:forEach>
	</ul>
</div>

</body>
<script>
$(document).ready(function() {
	$("#search").focus();
	console.log(document.cookie);
	$("#search").keyup(function(event){
		var keyword = document.getElementById("search").value.trim();
		if(keyword.length == 0){
			$("#recenttitle").css('display', 'block');
		} else {
			$("#recenttitle").css('display', 'none');
		}
		$.ajax({
		    url : "<c:url value="/searchkeyword"/>",
		    dataType : "html",
		    type : "post",
		    data : {keyword: keyword},
		    success : function(result){
		        $("#searchresult").html(result);
		    }
		});
	})
	//좋아요 기능
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
		    		$("#li"+result.beerNo).css('display', 'none');
		    	}
		    }
		})
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
</script>
</html>