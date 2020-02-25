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
<!-- Tag Tribute -->
<script src="<c:url value="/resources/tribute.js"/>"></script>
<link rel="stylesheet" href="<c:url value="/resources/tribute.css"/>"/>
<!-- star rating -->
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.css" rel="stylesheet">
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
	}
	#btnSubmit {
		position:relative;
		bottom: 29px;
		width: 29px;
		float: right;
	}
	.wrap {
		margin-top: 60px;
	}
	.beerinfo {
		width: 240px;
		height: 80px;
		border: 1px solid #323940;
		border-radius: 20px;
		padding: 10px;
		margin: 10px auto;
	}
	.beerpic {
		text-align: center;
		float:left;
		width: 30px;
		height: 60px;
		margin-right: 10px;
	}
	.beerpic img {
		height: 60px;
	}
	.company, .country {
		font-size: 0.8em;
		overflow: hidden; 
		text-overflow: ellipsis;
		white-space: nowrap;
		width: 175px;
	}
	.beername{
		font-size: 1.3em;
		overflow: hidden; 
		text-overflow: ellipsis;
		white-space: nowrap;
		width: 175px;
	}
	.tribute-demo-input {
		outline: none;
		border: 2px solid #fde16d;
		padding: 5px 10px;
		border-radius: 5px;
		font-size: 1.0em;
		height: 150px;
		cursor: text;
		overflow: auto;
	}
	.reviewform {
		width: 90%;
		margin: 10px auto;
	}
	.rating-container {
		width: 270px;
		margin: 0px auto;
	}
</style>
</head>
<body>
	<div class="header">
		<a href="<c:url value="/beer/${ beerVo.beerNo }?rating=${ rating }"/>"><i class="fas fa-chevron-left fa-2x"></i></a>
		<h4 class="pagetitle"><strong>리뷰 작성하기</strong></h4>
		<div id="btnSubmit"><strong>게시</strong></div>
	</div>
	<div class="wrap">
		<dl class="beerinfo">
			<div class="beerpic"><img src="<c:url value="${ beerVo.beerPic }"/>"></div>
			<dt class="beername">${ beerVo.beerName }</dt>
			<dd class="company">${ beerVo.company }</dd>
			<dd class="country">${ beerVo.country }</dd>
		</dl>
		<div class="reviewform">
		<form id="reviewForm" method="post" action="<c:url value="/write"/>">
			<input name="uuid" type="hidden" value="${ authUser.uuid }">
			<input id="beerNo" name="beerNo" type="hidden" value="${ beerVo.beerNo }">
			<input name="reviewPic" type="hidden" value="default">
			<input id="rating" type="text" value="${ rating }" class="kv-fa rating">
			<p id="testMultiple" class="tribute-demo-input"></p>
		</form>
		</div>
	</div>
</body>
<script>
	$(document).ready(function(){
		$("#testMultiple").focus();
	});
	//star rating
	$('.kv-fa').rating({
            theme: 'krajee-fa',
            filledStar: '<i class="fas fa-star"></i>',
            emptyStar: '<i class="far fa-star"></i>',
            size: 'lg',
            showClear: false,
            showCaption: false
    });
	// example of alternative callback
	var tributeMultipleTriggers = new Tribute({
        collection: [
          {
            // The symbol that starts the lookup
            trigger: "#",

            // The function that gets call on select that retuns the content to insert
            selectTemplate: function(item) {
              if (typeof item === "undefined") return "언디파인드";
              if (this.range.isContentEditable(this.current.element)) {
                return (
                	"#" + item.original.tagName
                );
              }
			console.log(item.original.tagName);
              return "#" + item.original.tagName;
            },

            // function retrieving an array of objects
            values: function (text, cb) {
        	    remoteSearch(text, users => cb(users));
            },

            lookup: "tagName",

            fillAttr: "tagName"
          }
        ]
      });
    tributeMultipleTriggers.attach(document.getElementById("testMultiple"));
		
    function remoteSearch(text, cb) {
    	  var URL = '<c:url value="/searchtag"/>';
    	  var beerNo = document.getElementById("beerNo").value;
    	  console.log(beerNo);
    	  xhr = new XMLHttpRequest();
    	  xhr.onreadystatechange = function() {
    	    if (xhr.readyState === 4) {
    	      if (xhr.status === 200) {
    	        var data = JSON.parse(xhr.responseText);
    	        console.log("data", data);
    	        cb(data);
    	      } else if (xhr.status === 403) {
    	        cb([]);
    	      }
    	    }
    	  };
    	  xhr.open("GET", URL + "?keyword=" + text +"&beerNo=" + beerNo, true);
    	  xhr.send();
    }
    //submit 시 리뷰 내용 보내기
    var formObj = document.forms["reviewForm"];
    $("#btnSubmit").on("click", function(event){
    	var rating = document.getElementById("rating").value;
    	var review = $("#testMultiple").html();
    	if(rating == 0){
    		alert("별점을 체크해주세요");
    		return false;
    	}
    	var inputReviewContent = document.createElement("input");
    	inputReviewContent.setAttribute("type", "hidden");
    	inputReviewContent.setAttribute("name", "reviewContent");
    	inputReviewContent.setAttribute("value", review);
    	var inputRating = document.createElement("input");
    	inputRating.setAttribute("type", "hidden");
    	inputRating.setAttribute("name", "rating");
    	inputRating.setAttribute("value", rating);
    	formObj.appendChild(inputReviewContent);
    	formObj.appendChild(inputRating);
    	formObj.submit();
    });
</script>