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
	 <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <style>
		.tribute-demo-input {
        outline: none;
        border: 1px solid #eee;
        padding: 3px 5px;
        border-radius: 2px;
        font-size: 15px;
        min-height: 200px;
        cursor: text;
        }		
    </style>
  </head>
  <body>
  <a href="<c:url value="/"/>">뒤로</a>
  <h3>맥주 정보</h3>
  <form id="reviewForm" method="post" action="<c:url value="write"/>">
    <input name="uuid" type="hidden" value="${ authUser.uuid }">
    <input name="beerNo" type="hidden" value="1">
	<input id="rating" type="text" class="kv-fa rating" data-size="xl" showClear="false">
	<h5>리뷰작성하기</h5>
	<p
	   id="testMultiple"
	   class="tribute-demo-input"
	></p>
	<input id="btnSubmit" value="등록" class="btn btn-info">
  </form>
</body>
<script>
	//star rating
	$('.kv-fa').rating({
            theme: 'krajee-fa',
            filledStar: '<i class="fa fa-star"></i>',
            emptyStar: '<i class="fa fa-star-o"></i>',
            showClear: false,
            showCaption: false
    });
	// example of alternative callback
	var tributeMultipleTriggers = new Tribute({
        collection: [
          {
            // The function that gets call on select that retuns the content to insert
            selectTemplate: function(item) {
              if (this.range.isContentEditable(this.current.element)) {
                return (
                  '<a href="http://zurb.com" title="' +
                  item.original.email +
                  '">@' +
                  item.original.value +
                  "</a>"
                );
              }

              return "@" + item.original.value;
            },

            // the array of objects
            values: []
          },
          {
            // The symbol that starts the lookup
            trigger: "#",

            // The function that gets call on select that retuns the content to insert
            selectTemplate: function(item) {
              if (typeof item === "undefined") return "언디파인드";
              if (this.range.isContentEditable(this.current.element)) {
                return (
                  '#' +
                  item.original.username 
                );
              }
			console.log(item.original.name);
              return "#" + item.original.name;
            },

            // function retrieving an array of objects
            values: function (text, cb) {
        	    remoteSearch(text, users => cb(users));
            },

            lookup: "username",

            fillAttr: "username"
          }
        ]
      });
    tributeMultipleTriggers.attach(document.getElementById("testMultiple"));
		
    function remoteSearch(text, cb) {
    	  var URL = '<c:url value="/searchtag"/>';
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
    	  xhr.open("GET", URL + "?keyword=" + text, true);
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