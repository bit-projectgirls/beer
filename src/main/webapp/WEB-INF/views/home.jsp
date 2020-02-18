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
	.swiper-container {
	    width: 100%;
	    height: 30%;
	}
	.swiper-slide {
	    text-align: center;
	    font-size: 18px;
	    background: #fff;
	
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
	.navbar {
		background:#fff;
		z-index:99;
	  	position:fixed;
	  	bottom: 0;
	  	width: 100%;
	}
</style>
</head>

<body>
	<h3>맥주검색</h3>
	<a href="<c:url value="/search"/>">
		<div>
			<input type="text" name="keyword" id="keywordinput">
			<i class="fas fa-search"></i>
		</div>
	</a>
	<h5>우리 TOP 10 리스트</h5>
	<!-- Swiper -->
	<div class="swiper-container">
		<div class="swiper-wrapper">
			<c:forEach items="${ beerList }" var="beerVo">
			<div class="swiper-slide">
				<div class='beerpic'>그림</div>
				<dl class='lst_dsc'>
					<dd>${ beerVo.company }</dd>
					<dd class='beeridx' data-idx="${ beerVo.idx }"></dd>
					<dt class='beername'><a href="<c:url value="/beer/${ beerVo.beerNo }"/>">${ beerVo.beerName }</a></dt>
					<dd class='beerinfo'>${ beerVo.type } from ${ beerVo.country }</dd>
					<dd class='beerrating'>${ beerVo.ratingBA }</dd>
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
			</c:forEach>
		</div>
		<!-- Add Pagination -->
		<div class="swiper-pagination"></div>
	</div>
	<h5>Beeradvocate TOP 10 리스트</h5>
	<!-- Swiper -->
	<div class="swiper-container">
		<div class="swiper-wrapper">
			<c:forEach items="${ beerListBA }" var="beerVo">
			<div class="swiper-slide">
				<div class='beerpic'>그림</div>
				<dl class='lst_dsc'>
					<dd>${ beerVo.company }</dd>
					<dd class='beeridx' data-idx="${ beerVo.idx }"></dd>
					<dt class='beername'><a href="<c:url value="/beer/${ beerVo.beerNo }"/>">${ beerVo.beerName }</a></dt>
					<dd class='beerinfo'>${ beerVo.type } from ${ beerVo.country }</dd>
					<dd class='beerrating'>${ beerVo.ratingBA }</dd>
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
			</c:forEach>
		</div>
		<!-- Add Pagination -->
		<div class="swiper-pagination"></div>
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
    },
  });
</script>
</html>