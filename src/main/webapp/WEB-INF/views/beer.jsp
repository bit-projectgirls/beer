<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <meta http-equiv="x-ua-compatible" content="ie=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <!-- jQuery -->
	<script src="<c:url value="/resources/jquery/jquery-3.4.1.min.js"/>"></script>
    <!-- star rating -->
    <link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.css" rel="stylesheet"/>
	<link href="<c:url value="/resources/star-rating.css"/>" media="all" rel="stylesheet" type="text/css" />
	<script src="<c:url value="/resources/star-rating.js"/>" type="text/javascript"></script>
	<link href="<c:url value="/resources/krajee-fa/theme.css"/>" media="all" rel="stylesheet" type="text/css" />
	<script src="<c:url value="/resources/krajee-fa/theme.js"/>" type="text/javascript"></script>
	<!-- font awesome -->
	<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
  </head>
  <body>
  <a href="<c:url value="/list"/>">뒤로</a>
  <div>
	${ beerVo.company }<br/>
	<h3>${ beerVo.beerName }</h3><br/>
	${ beerVo.type } from ${ beerVo.country }<br/>
  </div>
  <div>
	Beeradvocate
	<h3>${ beerVo.ratingBA }</h3><br/>
	<h3>${ beerVo.rating }</h3><br/>
  </div>
  <div id="rating">
  	리뷰 남기기
    <form id="ratingform" method="post" action="<c:url value="/reviewform"/>">
    <input id="beerNo" type="hidden" name="beerNo" value="${ beerVo.beerNo }">
	<input id="starRating" type="text" value="${ rating }" class="kv-fa rating" data-size="xl" showClear="false">
	</form>
  </div>
  <div>
  	리뷰<br/>
  	<c:if test="${ empty reviewlist }">
  		아직 작성된 리뷰가 없어요.
  	</c:if>
  	<c:if test="${ not empty reviewlist }">
	    <table class="table table-sm">
		<c:forEach items="${ reviewlist }" var="reviewVo">
			<tr>
				<td>${ reviewVo.reviewContent }</td>
				<td><input name="ratingReview" value="${ reviewVo.rating }" class="kv-fa rating"></td>
				<td>by ${ reviewVo.nickname }</td>
			</tr>
		</c:forEach>
	    </table>
    </c:if>
  </div>
</body>
<script>
	//star rating
	$('#ratingReview').rating({
		displayOnly: true,
		size: 'xs',
		step: 0.5,
		showCaption: false,
		theme: 'krajee-fa',
        filledStar: '<i class="fa fa-star"></i>',
        emptyStar: '<i class="fa fa-star-o"></i>',
        });
	$('.kv-fa').rating({
            theme: 'krajee-fa',
            filledStar: '<i class="fa fa-star"></i>',
            emptyStar: '<i class="fa fa-star-o"></i>',
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
</script>