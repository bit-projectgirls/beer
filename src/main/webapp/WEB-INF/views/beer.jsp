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
    <link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.css" rel="stylesheet">
	<link href="<c:url value="/resources/star-rating.css"/>" media="all" rel="stylesheet" type="text/css" />
	<script src="<c:url value="/resources/star-rating.js"/>" type="text/javascript"></script>
	<link href="<c:url value="/resources/krajee-fa/theme.css"/>" media="all" rel="stylesheet" type="text/css" />
	<script src="<c:url value="/resources/krajee-fa/theme.js"/>" type="text/javascript"></script>
	<!-- font awesome -->
	<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
  </head>
  <body>
  <a href="<c:url value="/"/>">뒤로</a>
  <h3>맥주 정보</h3>
  <form>
	 <input id="starRating" type="text" class="kv-fa rating" data-size="xl" showClear="false">
	 <a href="<c:url value="/reviewform"/>">리뷰작성페이지 가기</a>
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
</script>