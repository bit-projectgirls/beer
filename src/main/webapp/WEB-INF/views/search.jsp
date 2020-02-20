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
<style>
	html, body {
	    position: relative;
	    height: 100%;
	}
	body {
	    font-family: Helvetica Neue, Helvetica, Arial, sans-serif;
	    font-size: 14px;
	    color:#000;
	    margin:0;
	    padding:0;
	}
	ul{
		list-style:none;
		padding:0px;
	}
	.beercard {
		width:300px;
		height: 150px;
		margin: 10px auto;
		border-radius: 20px;
		background: #ffe6db;
	}
	.beerpic {
		width:60px;
		height:120px;
		float:left;
		border:1px solid #303030;
		margin: 15px;
	}
	.lst_dsc {
		height: 150px;
		padding: 15px;
		margin: 0;
	}
	.company, .beerinfo, .beerrating {
		font-size: 1.0em;
		margin: 0;
		overflow: hidden; 
		text-overflow: ellipsis;
		white-space: nowrap; 
		width: 190px;
	}
	.beername {
		font-size: 1.5em;
		margin: 0;
		overflow: hidden; 
		text-overflow: ellipsis;
		white-space: nowrap; 
		width: 190px;
	}
	.rating-container .empty-stars {
		color: #000;
	}
	.rating-container .filled-stars {
		color: #000;
	}
	.beeridx {
		display: none;
	}
	.likeArea {
		float : right;
		margin: 10px 0 0 0;
	}
	.rating-container, .ratingcap {
		float: left;
	}
	.rating-xs  {
    	font-size: 1.0em;
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
	.searchbox .icon{
		position: absolute;
		top: 5%;
		left: 20px;
		z-index: 1;
		color: #4f5b66;
	}
	#searchresult{
	top:30%;
	margin-top:10px;
	}
</style>
</head>
<body>
<div class="titleheader">
	<a href="<c:url value="/"/>">뒤로</a>
</div>

<div class="searchbox">
	<form name="searchform" action="" method="POST" onsubmit="return false;">
		<a href="<c:url value="/search"/>">
			<input type="search" name="keyword" id="search">
			<span class="icon"><i class="fas fa-search fa-lg"></i></span>
		</a>
	</form>
</div>
<div id="searchresult">
	<ul id="beerlist" class="beerlist">
	<c:forEach items="${ beerList }" var="beerVo">
		<li class='beercard'>
			<div class='beerpic'>그림</div>
			<dl class='lst_dsc'>
				<dd class='company'>${ beerVo.company }</dd>
				<dd class='beeridx' data-idx="${ beerVo.idx }"></dd>
				<dt class='beername'><a href="<c:url value="/beer/${ beerVo.beerNo }"/>">${ beerVo.beerName }</a></dt>
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