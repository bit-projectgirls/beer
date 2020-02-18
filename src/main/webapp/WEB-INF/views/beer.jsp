<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
	#menubar {
	background:#fff;
	z-index:99;
  	position:fixed;
  	bottom: 0;
  	width: 100%;
	}
</style>
</head>
<body>
	<a href="<c:url value="/list"/>">뒤로</a>
	<div>
	${ beerVo.company }<br/>
	<h3>${ beerVo.beerName }</h3><br/>
	${ beerVo.type } from ${ beerVo.country }<br/>
	</div>
	<div>
	<h3>Beeradvocate:${ beerVo.ratingBA }</h3><br/>
	<h3>우리별점:${ beerVo.rating }</h3><br/>
	</div>
	<div id="likeArea">
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
	<div id="rating">
		<c:if test="${ empty authUser }">
		<a href="<c:url value="/mypage"/>">로그인 시 리뷰를 남길 수 있어요!</a>
		</c:if>
		<c:if test="${ not empty authUser }">
		<c:choose>
			<c:when test="${ chkReview == true }">
			내가 작성한 리뷰
			<dl class="writtenReview">
				<dd>${ writtenReview.reviewContent }</dd>
				<dd><input name="ratingReview" value="${ writtenReview.rating }"class="kv-fa rating">${ writtenReview.rating }</dd>
				<dd>by ${ writtenReview.nickname }</dd>
			</dl>
			</c:when>
			<c:otherwise>
			리뷰 남기기
			<form id="ratingform" method="post" action="<c:url value="/reviewform"/>">
			<input id="beerNo" type="hidden" name="beerNo" value="${ beerVo.beerNo }">
			<input id="starRating" type="text" value="${ rating }" class="kv-fa rating" data-size="xl" showClear="false">
			</form>
			</c:otherwise>
		</c:choose>
		</c:if>
	</div>
	<div>
	 	리뷰<br/>
	 	<c:if test="${ empty reviewList }">
			아직 작성된 리뷰가 없어요.
		</c:if>
		<c:if test="${ not empty reviewList }">
		<c:forEach items="${ reviewList }" var="reviewVo">
		<dl>
			<dd>${ reviewVo.reviewContent }</dd>
			<dd><input name="ratingReview" value="${ reviewVo.rating }" class="kv-fa rating">${ reviewVo.rating }</dd>
			<dd>by ${ reviewVo.nickname }</dd>
		</dl>
		</c:forEach>
		</c:if>
	</div>
	<footer class="navbar" id="menubar">
		<c:import url="/WEB-INF/views/footer.jsp"/>
	</footer>
</body>
<script>
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
		var beerNo = document.getElementById("beerNo").value;
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