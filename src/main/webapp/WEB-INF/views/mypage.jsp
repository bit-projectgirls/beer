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
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<link rel="stylesheet" href="<c:url value="/resources/bootstrap/css/bootstrap.css"/>"/>
<!-- jQuery -->
<script src="<c:url value="/resources/jquery/jquery-3.4.1.min.js"/>"></script>
</head>
<body>
  <a href="<c:url value="/"/>">뒤로</a>
  <div>
  <c:choose>
    <c:when test="${ empty authUser }">
      <a id="kakao-login-btn" href="https://kauth.kakao.com/oauth/authorize?client_id=247c6d507dbd703741920ee35f89946e&redirect_uri=http://localhost:8080/beer/login&response_type=code">카카오로 로그인</a>
    </c:when>
    <c:otherwise>
      <img src="${ authUser.userPic }">
      <p>${ authUser.nickname }</p>
      <a href="<c:url value="/logout"/>">로그아웃</a>
    </c:otherwise>
  </c:choose>
  </div>
</body>
<script type='text/javascript'>

</script>
</html>
