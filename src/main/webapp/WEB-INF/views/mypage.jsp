<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width"/>
<title>API Demo - Kakao JavaScript SDK</title>
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
	<a href="<c:url value="/"/>">뒤로</a>
	<div id="mypageMenu">
	<c:choose>
		<c:when test="${ empty authUser }">
		<a id="kakao-login-btn" href="https://kauth.kakao.com/oauth/authorize?client_id=247c6d507dbd703741920ee35f89946e&redirect_uri=http://localhost:8080/beer/login&response_type=code">카카오로 로그인</a>
		</c:when>
		<c:otherwise>
		<img src="${ authUser.userPic }">
		<p>${ authUser.nickname }</p>
		<a href="<c:url value="/myblike"/>">좋아요 누른 맥주 리스트 관리</a><br>
		<a href="<c:url value="/reviewlist"/>">작성한 리뷰 관리</a><br>
		<a href="<c:url value="/profilemod"/>">개인정보 수정</a><br>
		<a href="<c:url value="/logout"/>">로그아웃</a>
		</c:otherwise>
	</c:choose>
	</div>
	<footer class="navbar">
		<c:import url="/WEB-INF/views/footer.jsp"/>
	</footer>
</body>
<script type='text/javascript'>

</script>
</html>
