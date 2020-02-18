<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
	<a href="<c:url value="/mypage"/>">뒤로</a>
	<div>
	 	리뷰<br/>
	 	<c:if test="${ empty reviewList }">
		아직 작성하신 리뷰가 없어요.
		</c:if>
		<c:if test="${ not empty reviewList }">
		<c:forEach items="${ reviewList }" var="reviewVo" varStatus="status">
		<dl>
			<dd>${ reviewVo.reviewContent }</dd>
			<dd><input name="ratingReview" value="${ reviewVo.rating }" class="rating">${ reviewVo.rating }</dd>
			<dd>
				<div class='beerpic'>그림</div>
				<dl class="bee_info">
				<dd>${ beerList[status.index].company }</dd>
				<dt class='beername'><a href="<c:url value="/beer/${ reviewVo.beerNo }"/>">${ beerList[status.index].beerName }</a></dt>
				<dd class='beerinfo'>${ beerList[status.index].type } from ${ beerList[status.index].country }</dd>
				</dl>
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