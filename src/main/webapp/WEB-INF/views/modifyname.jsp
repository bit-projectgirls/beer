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
	}
	body {
	    font-family: 'Nanum Gothic', sans-serif;
		background-color: #323940;
	    margin:0;
	    padding:0;
	}
	a:active, a:visited, a:hover {
		text-decoration: none;
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
		font-size: 18px;
	}
	.modform {
		width: 300px;
		margin: 70px auto;
	}
	.modform input#inputname {
		width: 300px;
		height: 40px;
		background: #fff;
		border: none;
		font-size: 10pt;
		color: #323940;
		padding-left: 18px;
		padding-right: 45px;
		border-radius: 20px;
	}
	.modform input#btnSubmit {
		position: relative;
		bottom: 40px;
		left: 240px;
		z-index: 1;
		background-color: #fde16d;
		border: 0;
		height: 40px;
		width: 60px;
		border-bottom-right-radius: 20px;
		border-top-right-radius: 20px;
	}
</style>
</head>
<body>
	<div class="header">
		<a href="<c:url value="/mypage"/>"><i class="fas fa-chevron-left fa-2x"></i></a>
		<h4 class="pagetitle"><strong>닉네임 변경</strong></h4>
	</div>
	<div class="modform">
	<form id="modForm" name="modForm" action="<c:url value="/modnameaction"/>" method="POST">
		<input  id='inputname' name="nickname" type="text"  value="${ authUser.nickname }"/>
		<input id="btnSubmit" type="submit" value="변경" class="btnsubmit">
	</form>
	</div>
</body>
</html>