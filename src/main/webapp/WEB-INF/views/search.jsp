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
		padding:10px;
	}
	li{
		background-color:#f7f4da;
	}
	.beerpic {
		width:80px;
		height:100px;
		float: left;
		border: 1px solid #303030;
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
		<li>
			<div class='beerpic'>그림</div>
			<dl class='lst_dsc'>
			<dd>by ${ beerVo.company }</dd>
			<dd class='beeridx' data-idx="${ beerVo.idx }"></td>
			<dt class='beername'><a href="<c:url value="/beer/${ beerVo.beerNo }"/>">${ beerVo.beerName }</a></dt>
			<dd class='beerinfo'>${ beerVo.type } from ${ beerVo.country }</dd>
			<dd class='beerrating'>${ beerVo.ratingBA }</dd>
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
</script>
</html>