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
<!-- star rating -->
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
	.kakaologin {
		margin: 100px auto;
		width: 222px;
		
	}
	.wrap {
		margin-bottom: 70px;
	}
	.navbar {
		background:#fff;
		z-index:99;
	  	position:fixed;
	  	bottom: 0;
	  	width: 100%;
	}
	.userinfo {
		height: 150px;
		background-color: #fde16d;
		text-align: center;
	}
	.userpic{
		width: 100px;
		margin: 0 auto;
		padding-top: 100px;
	}
	.userpic i {
		width: 30px;
		height: 30px;
		border-radius: 50%;
		background-color: rgba(253, 225, 109, 0.8);
		padding: 6px;
		color: #323940;
		position: relative;
		float: right;
		bottom: 30px;
	}
	#userPic {
		width: 100px;
		height: 100px;
		object-fit: cover;
		object-position: top;
		border-radius: 50%;
	}
	.username {
		width: 200px;
		text-align: center;
		position: absolute;
		left: 50%;
		margin-left: -100px;
		margin-top: 5px;
	}
	.username a{
		color: #323940;
		font-size: 0.9em;
	}
	.mymenu {
		margin-top: 100px;
	}
	.mymenu a{
		color: #323940;
	}
	.mymenu i{
		float: right;
		color: #878787;
		margin-top: 5px;
	}

</style>
</head>
<body>
	<div class="wrap">
	<c:choose>
		<c:when test="${ empty authUser }">
		<div class="kakaologin">
			<a id="kakao-login-btn" href="https://kauth.kakao.com/oauth/authorize?client_id=247c6d507dbd703741920ee35f89946e&redirect_uri=http://localhost:8080/beer/login&response_type=code">
			<img src="<c:url value="/img/kakao_account_login_btn.png"/>">
			</a>
		</div>
		</c:when>
		<c:otherwise>
		<div class="userinfo">
			<div class="userpic">
				<img id="userPic" src="${ authUser.userPic }">
				<i class="fas fa-images" id="modPicbtn"></i>
				<form method="post" enctype="multipart/form-data" action="" id="fileForm" style=" display: none">
					<input type="file" accept="image/*;capture=camera" id="uploadFile" name="uploadFile" style="display: none">
				</form>
			</div>
			<div class="username">
				${ authUser.nickname }<a href="<c:url value="/modifyname"/>"><i class="fas fa-pen" id="modifyName"></i></a>
			</div>
		</div>
		<div class="mymenu">
			<table class="table table-hober">
			<tr><td onClick="location.href='<c:url value="/myblike"/>'">좋아요 누른 맥주 리스트 관리<i class="fas fa-angle-right fa-lg"></i></td></tr>
			<tr><td onClick="location.href='<c:url value="/myreview"/>'">작성한 리뷰 관리<i class="fas fa-angle-right fa-lg"></i></td></tr>
			<tr><td onClick="location.href='<c:url value="/logout"/>'">로그아웃<i class="fas fa-angle-right fa-lg"></i></td></tr>
			</table>
		</div>
		</c:otherwise>
	</c:choose>
	</div>
	
	<footer class="navbar">
		<c:import url="/WEB-INF/views/footer.jsp"/>
	</footer>
</body>
<script type='text/javascript'>
	$("#modPicbtn").on("click", function(e) {
		$("#uploadFile").click();
	});
	$("#uploadFile").change(function(){
		//var file = document.getElementById('userPic').files;
		//var nickname = document.getElementById('nickname').value;
		// Get form
		var form = $('#fileForm')[0];

		// Create an FormData object 
		 var data = new FormData(form);

		$.ajax({
		    url : "<c:url value="/userpicupload"/>",
		    type : "post",
		    enctype: 'multipart/form-data',
		    processData: false,
            contentType: false,
            cache: false,
		    data : data,
		    success : function(result){
		    	console.log(result);
		    	$("#userPic").attr("src", result);
		    },
		    error: function(request, status, error) {
				console.error("Error:", error);
			}
		});
	});
</script>
</html>	