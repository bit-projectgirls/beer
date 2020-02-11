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
  <a href="<c:url value="/"/>">뒤로</a>
  <div>
	  ${ beerVo.beerNo }<br/>
	  <h3>${ beerVo.beerName }</h3><br/>
	  <input id="ratingBA" name="ratingBA" value="${ beerVo.ratingBA }" class="kv-fa rating">${ beerVo.ratingBA }<br/>
	  ${ beerVo.company } from ${ beerVo.country }<br/>
  </div>
  <div id="rating">
     <form id="ratingform" method="post" action="<c:url value="/reviewform"/>">
     <input id="beerNo" type="hidden" name="beerNo" value="${ beerVo.beerNo }">
	 <input id="starRating" type="text" value="${ rating }" class="kv-fa rating" data-size="xl" showClear="false">
	 </form>
  </div>
</body>
<script>
	//star rating
	$('#ratingBA').rating({
		displayOnly: true,
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
	// cookie 저장
	function setCookie(cookie_name, value, days) {
		var exdate = new Date();
		exdate.setDate(exdate.getDate() + days);
		// 설정 일수만큼 현재시간에 만료값으로 지정
		var cookie_value = escape(value) + ((days == null) ? '' : ';    expires=' + exdate.toUTCString());
		document.cookie = cookie_name + '=' + cookie_value;
		console.log(document.cookie);
	}
	function getCookie(cookie_name) {
		var x, y;
		var val = document.cookie.split(';');
		
		for (var i = 0; i < val.length; i++) {
			x = val[i].substr(0, val[i].indexOf('='));
			y = val[i].substr(val[i].indexOf('=') + 1);
			x = x.replace(/^\s+|\s+$/g, ''); // 앞과 뒤의 공백 제거하기
			if (x == cookie_name) {
				return unescape(y); // unescape로 디코딩 후 값 리턴
			}
		}
	}
	function addCookie(id) {
		var items = getCookie('beerViewed'); // 이미 저장된 값을 쿠키에서 가져오기
		var maxItemNum = 10; // 최대 저장 가능한 아이템개수
		var expire = 7; // 쿠키값을 저장할 기간
		if (items) {
		var itemArray = items.split(',');
		if (itemArray.indexOf(id) != -1) {
			// 이미 존재하는 경우 종료
			console.log('Already exists.');
		}
		else {
			// 새로운 값 저장 및 최대 개수 유지하기
			itemArray.unshift(id);
			if (itemArray.length > maxItemNum ) itemArray.length = 5;
				items = itemArray.join(',');
				setCookie('beerViewd', items, expire);
			}
		}
		else {
			// 신규 id값 저장하기
			setCookie('productItems', id, expire);
		}
	}
	$(document).ready(function() {
		var beerNo = document.getElementById("beerNo").value;
		addCookie(beerNo);
	});
</script>