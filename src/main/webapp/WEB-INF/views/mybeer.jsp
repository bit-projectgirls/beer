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
	.beerpic {
		width:80px;
		height:100px;
		float: left;
		border: 1px solid #303030;
	}
</style>
</head>
<body>
	<a href="<c:url value="/mypage"/>">뒤로</a>
	<div id="mybeerlist">
	<ul id="beerlist" class="beerlist">
	<c:if test="${ empty beerList }">
	좋아요 리스트가 없어요.
	</c:if>
	<c:forEach items="${ beerList }" var="beerVo">
		<li>
			<div class='beerpic'>그림</div>
			<dl class='lst_dsc'>
				<dd>${ beerVo.company }</dd>
				<dd class='beeridx' data-idx="${ beerVo.idx }"></dd>
				<dt class='beername'><a href="<c:url value="/beer/${ beerVo.beerNo }"/>">${ beerVo.beerName }</a></dt>
				<dd class='beerinfo'>${ beerVo.type } from ${ beerVo.country }</dd>
				<dd class='beerrating'>${ beerVo.ratingBA }</dd>
				<dd id='like${beerVo.beerNo }' class='likeArea' onclick='bLike(${ beerVo.beerNo})'>
					<i class='fas fa-heart'></i>
				</dd>
			</dl>
		</li>
	</c:forEach>
	</ul>
	</div>
	<footer class="navbar">
		<c:import url="/WEB-INF/views/footer.jsp"/>
	</footer>
</body>
<script type='text/javascript'>

</script>
</html>
