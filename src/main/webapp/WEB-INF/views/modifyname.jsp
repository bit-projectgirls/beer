<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width"/>
<title>modify form</title>
<!-- Bootstrap -->
<link rel="stylesheet" href="<c:url value="/resources/bootstrap/css/bootstrap.css"/>"/>
<!-- kakao api -->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
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
	#mypageMenu {
		padding-bottom:68px;
		text-align: center;
	}
	img {
		width: 100px;
		height: 100px;
		object-fit: cover;
		object-position: top;
		border-radius: 50%;
	}
</style>
</head>
<body>
	<a href="<c:url value="/mypage"/>">뒤로</a>
	<form id="modForm" name="modForm" action="<c:url value="/modnameaction"/>" method="POST">
		<input name="nickname" type="text"  value="${ authUser.nickname }"/>
		<input id="btnSubmit" type="submit" value="변경" class="btn btn-warning">
		
	</form>
</body>
</html>